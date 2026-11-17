import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home_rounded),
          label: l10n.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.search_rounded),
          label: l10n.search,
        ),
        NavigationDestination(
          icon: const Icon(Icons.shopping_cart_outlined),
          selectedIcon: const Icon(Icons.shopping_cart_rounded),
          label: l10n.cart,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline_rounded),
          selectedIcon: const Icon(Icons.person_rounded),
          label: l10n.profile,
        ),
      ],
    );
  }
}
