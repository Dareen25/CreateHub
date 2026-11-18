import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/di.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_page_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: const _ResetForm(),
  );
}

class _ResetForm extends StatefulWidget {
  const _ResetForm();
  @override
  State<_ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<_ResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.resetEmailSent)));
        }
      },
      builder: (context, state) => AuthPageScaffold(
        title: l10n.forgotPasswordTitle,
        subtitle: l10n.forgotPasswordSubtitle,
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
              if (state.status == AuthStatus.failure)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _resetError(state.errorCode, l10n),
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
                          context.read<AuthCubit>().sendPasswordReset(
                            _email.text,
                          );
                        }
                      },
                child: state.status == AuthStatus.loading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.sendResetEmail),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(l10n.backToLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _resetError(String? code, AppLocalizations l10n) => switch (code) {
  'invalid-email' => l10n.emailInvalid,
  // Keep account existence private; Firebase may report this for unknown emails.
  'user-not-found' => l10n.resetEmailSent,
  'network-request-failed' => l10n.authNetworkError,
  'too-many-requests' => l10n.authTooManyRequests,
  'firebase-not-configured' || 'no-app' => l10n.firebaseNotConfigured,
  _ => l10n.authGenericError,
};
