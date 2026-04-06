import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../core/constants/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     NavigationService.pushNamed(AppRoutes.login);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
     // NavigationService.pushNamed(AppRoutes.onboarding1);
      NavigationService.pushReplacementNamed(AppRoutes.onboardingMain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  SizedBox(
              width: 200,
              height: 200,
            child: Image.asset(ImageConstants.splashLogo)),
      ),
    );
  }
}
