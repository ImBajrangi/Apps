import 'package:flutter/material.dart';
import 'router.dart';
import '../core/theme/app_theme.dart';

class ShriJiGardenApp extends StatelessWidget {
  const ShriJiGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ShriJi Garden',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
