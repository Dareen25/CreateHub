import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:createhub/features/cart/presentation/view/cart_screen.dart';
import 'package:createhub/features/home/presentation/view/home_screen.dart';
import 'package:createhub/features/profile/presentation/view/profile_screen.dart';
import 'package:createhub/features/auth/presentation/pages/login_screen.dart';
import 'package:createhub/features/auth/presentation/pages/register_screen.dart';
import 'package:createhub/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:createhub/core/shared_widgets/app_bottom_navigation_bar.dart';

import 'nav_helper.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.loginRoute,
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
            path: RoutePath.cartRoute,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: RoutePath.profileRoute,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RoutePath.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePath.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePath.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  );
}
