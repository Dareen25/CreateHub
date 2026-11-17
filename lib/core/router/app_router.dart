import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/cart_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/search/search_screen.dart';
import '../shared_widgets/app_bottom_navigation_bar.dart';
import 'nav_helper.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.homeRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: NavHelper.getCurrentIndex(state.uri.path),
            onDestinationSelected: (index) =>
                NavHelper.onItemTapped(context, index),
          ),
        ),
        routes: [
          GoRoute(
            path: RoutePath.homeRoute,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: RoutePath.searchRoute,
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: RoutePath.cartRoute,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: RoutePath.profileRoute,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
