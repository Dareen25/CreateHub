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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: const _RegisterForm(),
  );
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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
        title: l10n.registerTitle,
        subtitle: l10n.registerSubtitle,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: _email,
                label: l10n.emailLabel,
                icon: Icons.email_outlined,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l10n.emailRequired;
                  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                      .hasMatch(v.trim())) {
                    return l10n.emailInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _password,
                label: l10n.passwordLabel,
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.passwordRequired;
                  if (v.length < 6) return l10n.passwordTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _confirm,
                label: l10n.confirmPassword,
                icon: Icons.lock_reset_outlined,
                isPassword: true,
                validator: (v) =>
                    v != _password.text ? l10n.passwordsDoNotMatch : null,
              ),
              if (state.status == AuthStatus.failure)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _registerError(state.errorCode, l10n),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: state.status == AuthStatus.loading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
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
                    : Text(l10n.registerAction),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go(RoutePath.loginRoute),
                child: Text(l10n.haveAccountLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _registerError(String? code, AppLocalizations l10n) => switch (code) {
  'email-already-in-use' => l10n.authEmailInUse,
  'weak-password' => l10n.passwordTooShort,
  'invalid-email' => l10n.emailInvalid,
  'operation-not-allowed' ||
  'firebase-not-configured' ||
  'no-app' => l10n.firebaseNotConfigured,
  'network-request-failed' => l10n.authNetworkError,
  'too-many-requests' => l10n.authTooManyRequests,
  _ => l10n.authGenericError,
};
