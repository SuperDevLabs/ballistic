import 'package:ballistic/app/app.dart';
import 'package:ballistic/features/analyze/domain/selected_video.dart';
import 'package:ballistic/features/analyze/presentation/processing_screen.dart';
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

  testWidgets('opens the analyze workout flow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BallisticApp());
    await tester.pumpAndSettle();
    final Finder analyzeButton = find.byKey(
      const Key('analyze-workout-button'),
    );
    await tester.ensureVisible(analyzeButton);
    await tester.pumpAndSettle();
    await tester.tap(analyzeButton);
    await tester.pumpAndSettle();

    expect(find.text('ANALYZE WORKOUT'), findsOneWidget);
    expect(find.byKey(const Key('video-picker-card')), findsOneWidget);
    expect(find.text('Choose a workout video'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('start-analysis-button')))
          .onPressed,
      isNull,
    );
  });

  testWidgets('renders processing status for a selected video', (
    WidgetTester tester,
  ) async {
    const SelectedVideo video = SelectedVideo(
      name: 'session.mp4',
      path: r'C:\video\session.mp4',
      sizeBytes: 73400320,
    );

    await tester.pumpWidget(
      const MaterialApp(home: ProcessingScreen(video: video)),
    );

    expect(find.text('Preparing your analysis'), findsOneWidget);
    expect(find.text('session.mp4'), findsOneWidget);
    expect(find.text('Video selected'), findsOneWidget);
  });
}
