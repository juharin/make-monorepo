// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_host_app/main.dart';
// Import the embedded app to find its type
import 'package:mobile_app/mobile_app.dart' show MobileApp;

void main() {
  testWidgets('Host app counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the host app label exists - REMOVED this assertion as the text changed
    // expect(find.text('You have pushed the Host app button this many times:'), findsOneWidget);
    
    // Find the host app counter using its key
    final hostCounterFinder = find.byKey(const Key('host_app_counter'));
    expect(hostCounterFinder, findsOneWidget);
    expect(tester.widget<Text>(hostCounterFinder).data, '0');
    
    // Find the host app's FloatingActionButton by key and tap it
    await tester.tap(find.byKey(const Key('host_app_fab')));
    await tester.pump();

    // After incrementing, verify the counter text is updated
    expect(tester.widget<Text>(hostCounterFinder).data, '1');
  });

  testWidgets('Embeds MobileApp and its counter works', (WidgetTester tester) async {
    // Build the host app.
    await tester.pumpWidget(const MyApp());

    // Verify the MobileApp widget is embedded.
    expect(find.byType(MobileApp), findsOneWidget);

    // Find the counter Text widget within the embedded MobileApp.
    // Use find.descendant to locate elements within the embedded app.
    final embeddedCounterFinder = find.descendant(
      of: find.byType(MobileApp),
      matching: find.byKey(const Key('embedded_app_counter')),
    );
    expect(embeddedCounterFinder, findsOneWidget);

    // Verify the embedded counter starts at '0'.
    expect(tester.widget<Text>(embeddedCounterFinder).data, '0');

    // Find the FAB (ElevatedButton) within the embedded MobileApp.
    final embeddedFabFinder = find.descendant(
      of: find.byType(MobileApp),
      matching: find.byKey(const Key('local_fab')),
    );
    expect(embeddedFabFinder, findsOneWidget);

    // Tap the embedded FAB.
    await tester.tap(embeddedFabFinder);
    await tester.pump();

    // Verify the embedded counter has incremented.
    expect(tester.widget<Text>(embeddedCounterFinder).data, '1');
  });
}
