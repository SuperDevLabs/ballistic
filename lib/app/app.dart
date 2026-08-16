import 'package:ballistic/core/routing/app_router.dart';
import 'package:ballistic/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BallisticApp extends StatelessWidget {
  const BallisticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BALLISTIC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
