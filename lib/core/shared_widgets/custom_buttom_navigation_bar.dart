import 'package:flutter/material.dart';

import '../constants/values_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(RadiusSize.r20),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.tertiary.withAlpha(220),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        onTap: onTap,
        items: [
          _buildNavItem(context, icon: Icons.home_outlined, label: 'Home'),
          _buildNavItem(
            context,
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
          ),
          _buildNavItem(context, icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      icon: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
      label: label,
    );
  }
}
