import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/feature_placeholder.dart';
import '../../../../l10n/generated/app_localizations.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.cart)),
      body: FeaturePlaceholder(
        icon: Icons.shopping_cart_outlined,
        message: l10n.cartPlaceholderMessage,
      ),
    );
  }
}
