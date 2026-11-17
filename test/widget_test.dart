import 'package:createhub/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CreateHub opens on its marketplace home screen', (tester) async {
    await tester.pumpWidget(const CreateHubApp());
    await tester.pumpAndSettle();

    expect(find.text('Good tools\nBrighter ideas'), findsOneWidget);
    expect(find.text('Artists'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
  });

  testWidgets('bottom navigation opens each placeholder screen', (
    tester,
  ) async {
    await tester.pumpWidget(const CreateHubApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Find creative products, artists, and maker tools here.'),
      findsOneWidget,
    );
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );

    await tester.tap(find.text('Cart').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Items you add to your cart will appear here.'),
      findsOneWidget,
    );
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
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
      3,
    );
  });
}
