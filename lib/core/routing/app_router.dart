import 'package:go_router/go_router.dart';
import '../../main.dart';

class AppRouter {
  const AppRouter();

  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
        ],
      );
}
