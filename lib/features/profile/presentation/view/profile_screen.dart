import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/shared_widgets/feature_placeholder.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          FeaturePlaceholder(
            icon: Icons.person_outline_rounded,
            message: l10n.profilePlaceholderMessage,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => context.push(RoutePath.loginRoute),
            icon: const Icon(Icons.login_rounded),
            label: Text(l10n.loginAction),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.push(RoutePath.registerRoute),
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: Text(l10n.registerAction),
          ),
        ],
      ),
    );
  }
}
