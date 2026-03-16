import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/series/series_list_screen.dart';
import '../../features/quiz/quiz_screen.dart';
import '../../features/quiz/results_screen.dart';
import '../../features/lessons/lessons_screen.dart';
import '../../features/signs/signs_screen.dart';
import '../../features/exam/exam_screen.dart';
import '../../features/settings/settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/',        builder: (c, s) => const HomeScreen()),
      GoRoute(path: '/series',  builder: (c, s) => const SeriesListScreen()),
      GoRoute(
        path: '/quiz/:seriesId',
        builder: (c, s) => QuizScreen(seriesId: s.params['seriesId']!),
      ),
      GoRoute(
        path: '/results',
        builder: (c, s) => ResultsScreen(extra: s.extra as Map<String, dynamic>),
      ),
      GoRoute(path: '/lessons', builder: (c, s) => const LessonsScreen()),
      GoRoute(path: '/signs',   builder: (c, s) => const SignsScreen()),
      GoRoute(path: '/exam',    builder: (c, s) => const ExamScreen()),
      GoRoute(path: '/settings',builder: (c, s) => const SettingsScreen()),
    ],
  );
}
