import 'package:ballistic/features/analyze/domain/selected_video.dart';
import 'package:ballistic/features/analyze/presentation/analyze_screen.dart';
import 'package:ballistic/features/analyze/presentation/processing_screen.dart';
import 'package:ballistic/features/home/presentation/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/analyze',
      builder: (context, state) => const AnalyzeScreen(),
    ),
    GoRoute(
      path: '/processing',
      builder: (context, state) {
        final SelectedVideo? video = state.extra as SelectedVideo?;
        return ProcessingScreen(video: video);
      },
    ),
  ],
);
