// Basic smoke test for the Alive app shell.
//
// A full integration test of the Google sign-in flow requires a configured
// Firebase project, so here we only assert that the brand mark renders.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alive_demo/widgets/alive_logo.dart';

void main() {
  testWidgets('AliveLogo renders the brand wordmark',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: AliveLogo(size: 80))),
      ),
    );

    expect(find.text('Alive'), findsOneWidget);
  });
}
