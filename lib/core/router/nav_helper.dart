import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_path.dart';

class NavHelper {
  static int getCurrentIndex(String location) {
    if (location == RoutePath.homeRoute) return 0;
    if (location == RoutePath.searchRoute) return 1;
    if (location == RoutePath.cartRoute) return 2;
    if (location == RoutePath.profileRoute) return 3;
    return 0;
  }

  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePath.homeRoute);
        return;
      case 1:
        context.go(RoutePath.searchRoute);
        return;
      case 2:
        context.go(RoutePath.cartRoute);
        return;
      case 3:
        context.go(RoutePath.profileRoute);
        return;
    }
  }
}
