import 'package:ballistic/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the BALLISTIC home dashboard', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BallisticApp());
    await tester.pumpAndSettle();

    expect(find.text('BALLISTIC'), findsOneWidget);
    expect(find.text('Ready to get better?'), findsOneWidget);
    expect(find.byKey(const Key('ballistic-score-card')), findsOneWidget);
    expect(find.byKey(const Key('analyze-workout-button')), findsOneWidget);
    expect(find.text('Recent workouts'), findsOneWidget);
  });
}
