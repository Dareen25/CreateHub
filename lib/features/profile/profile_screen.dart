import 'package:flutter/material.dart';

import '../../core/shared_widgets/feature_placeholder.dart';
import '../../l10n/generated/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: FeaturePlaceholder(
        icon: Icons.person_outline_rounded,
        message: l10n.profilePlaceholderMessage,
      ),
    );
  }
}
