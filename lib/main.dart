import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/app_router.dart';
import 'shared/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BluePuffinApp(),
    ),
  );
}

class BluePuffinApp extends StatelessWidget {
  const BluePuffinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '步凡 - AI跑步助手',
      theme: AppTheme.lightTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
