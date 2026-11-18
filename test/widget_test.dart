import 'package:createhub/config/di/di.dart';
import 'package:createhub/core/router/app_router.dart';
import 'package:createhub/core/router/route_path.dart';
import 'package:createhub/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(configureDependencies);

  testWidgets('CreateHub opens login without Firebase configuration', (
    tester,
  ) async {
    AppRouter.goRouter.go(RoutePath.loginRoute);
    await tester.pumpWidget(const CreateHubApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
  });

  testWidgets(
    'unconfigured Firebase shows a setup message instead of crashing',
    (tester) async {
      AppRouter.goRouter.go(RoutePath.loginRoute);
      await tester.pumpWidget(const CreateHubApp());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'artist@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Authentication is not connected yet.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('bottom navigation opens each placeholder screen', (
    tester,
  ) async {
    AppRouter.goRouter.go(RoutePath.homeRoute);
    await tester.pumpWidget(const CreateHubApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cart').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Items you add to your cart will appear here.'),
      findsOneWidget,
    );
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );

    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Your account details, orders, and saved items will appear here.',
      ),
      findsOneWidget,
    );
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
    );
  });
}
