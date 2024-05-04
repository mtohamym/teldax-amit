import 'package:flutter/material.dart';
import 'package:teldax/core/theme/app_theme.dart';
import 'package:teldax/feature/splash/view/splash_screen.dart';

import 'feature/auth/view/register_screen.dart';

class Teldax extends StatelessWidget {
  const Teldax({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Teldax",
      home: const SplashScreen(),
      theme: AppTheme.appTheme,
    );
  }
}
