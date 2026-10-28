import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_form_screen.dart';
import '../../features/run/presentation/pages/run_history_page.dart';
import '../../features/run/presentation/screens/run_screen.dart';
import '../../features/sync/presentation/screens/coros_sync_screen.dart';
import '../../features/training/presentation/screens/today_training_screen.dart';
import '../../features/training/presentation/screens/training_task_detail_screen.dart';
import '../../features/training/presentation/screens/weekly_plan_screen.dart';
import '../../features/user/presentation/user_info_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileFormScreen(),
      ),
      GoRoute(
        path: '/user/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return UserInfoScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/training/today',
        builder: (context, state) => const TodayTrainingScreen(),
      ),
      GoRoute(
        path: '/training/task/:taskId',
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          return TrainingTaskDetailScreen(taskId: taskId);
        },
      ),
      GoRoute(
        path: '/training/plan',
        builder: (context, state) => const WeeklyPlanScreen(),
      ),
      GoRoute(
        path: '/run',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return RunScreen(extra: extra);
        },
      ),
      GoRoute(
        path: '/run/history',
        builder: (context, state) => const RunHistoryPage(),
      ),
      GoRoute(
        path: '/sync/coros',
        builder: (context, state) => const CorosSyncScreen(),
      ),
    ],
  );
}
