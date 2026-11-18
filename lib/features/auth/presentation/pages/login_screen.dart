import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/di.dart';
import '../../../../core/router/route_path.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_page_scaffold.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: const _LoginForm(),
  );
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) context.go(RoutePath.homeRoute);
      },
      builder: (context, state) => AuthPageScaffold(
        title: l10n.loginTitle,
        subtitle: l10n.loginSubtitle,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: _email,
                label: l10n.emailLabel,
                icon: Icons.email_outlined,
                validator: (v) => _validEmail(v, l10n),
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _password,
                label: l10n.passwordLabel,
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.passwordRequired : null,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => context.push(RoutePath.forgotPasswordRoute),
                  child: Text(l10n.forgotPassword),
                ),
              ),
              if (state.status == AuthStatus.failure)
                _ErrorMessage(message: _authError(state.errorCode, l10n)),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: state.status == AuthStatus.loading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                            _email.text,
                            _password.text,
                          );
                        }
                      },
                child: state.status == AuthStatus.loading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.loginAction),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.push(RoutePath.registerRoute),
                child: Text(l10n.noAccountRegister),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _validEmail(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) return l10n.emailRequired;
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())) {
    return l10n.emailInvalid;
  }
  return null;
}

String _authError(String? code, AppLocalizations l10n) => switch (code) {
  'user-not-found' ||
  'wrong-password' ||
  'invalid-credential' => l10n.authInvalidCredentials,
  'invalid-email' => l10n.emailInvalid,
  'user-disabled' => l10n.authUserDisabled,
  'too-many-requests' => l10n.authTooManyRequests,
  'network-request-failed' => l10n.authNetworkError,
  'firebase-not-configured' || 'no-app' => l10n.firebaseNotConfigured,
  _ => l10n.authGenericError,
};

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      message,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    ),
  );
}
