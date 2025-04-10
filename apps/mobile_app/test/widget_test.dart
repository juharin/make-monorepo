// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/mobile_app.dart';

void main() {
  testWidgets('Embedded app counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MobileApp());

    // Verify that our counter starts at 0 using the key
    final counterFinder = find.byKey(const Key('embedded_app_counter'));
    expect(counterFinder, findsOneWidget);
    expect(tester.widget<Text>(counterFinder).data, '0');

    // Tap the '+' icon using the key and trigger a frame
    await tester.tap(find.byKey(const Key('local_fab')));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(tester.widget<Text>(counterFinder).data, '1');
  });
}
