import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 4));

    final pref = await SharedPreferences.getInstance();

    final isFirstTime = pref.getBool("isFirstTime") ?? true;
    final token = pref.getString("token");

    if (isFirstTime) {
      NavigationService.pushReplacementNamed(AppRoutes.onboardingMain);

    } else if (token != null && token.isNotEmpty) {
      NavigationService.pushReplacementNamed(AppRoutes.mainScreen);

    } else {
      NavigationService.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      body: Center(
        child:  SizedBox(
              width: 400,
              height: 400,
            child: Image.asset(ImageConstants.splashLogo)),
      ),
    );
  }
}
