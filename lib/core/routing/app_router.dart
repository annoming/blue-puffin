import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/user/presentation/user_profile_screen.dart';
import '../../features/user/presentation/user_profile_edit_screen.dart';
import '../../features/run/presentation/pages/run_page.dart';
import '../../features/run/presentation/pages/run_history_page.dart';
import '../../features/profile/presentation/screens/profile_form_screen.dart';
import '../../features/sync/presentation/screens/coros_sync_screen.dart';
import '../../features/training/presentation/screens/today_training_screen.dart';
import '../../features/training/presentation/screens/weekly_plan_screen.dart';

class AppRouter {
  const AppRouter();

  static final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileFormScreen(),
      ),
      GoRoute(
        path: '/user/:userId',
        builder: (context, state) {
          final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
          return UserProfileScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/user/profile/edit',
        builder: (context, state) {
          final userId = int.tryParse(state.uri.queryParameters['userId'] ?? '0') ?? 0;
          return UserProfileEditScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/run',
        builder: (context, state) => const RunPage(),
      ),
      GoRoute(
        path: '/run/history',
        builder: (context, state) => const RunHistoryPage(),
      ),
      GoRoute(
        path: '/sync/coros',
        builder: (context, state) => const CorosSyncScreen(),
      ),
      GoRoute(
        path: '/training/today',
        builder: (context, state) => const TodayTrainingScreen(),
      ),
      GoRoute(
        path: '/training/plan',
        builder: (context, state) => const WeeklyPlanScreen(),
      ),
    ],
  );
}
