import 'package:flutter/material.dart';

import '../../core/shared_widgets/feature_placeholder.dart';
import '../../l10n/generated/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.search)),
      body: FeaturePlaceholder(
        icon: Icons.search_rounded,
        message: l10n.searchPlaceholderMessage,
      ),
    );
  }
}
