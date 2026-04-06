import 'package:bloc_project_basic/presentation/home_screen/home_screen.dart';
import 'package:bloc_project_basic/presentation/profile_screen/profile_screen.dart';
import 'package:bloc_project_basic/presentation/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/login/login_bloc.dart';
import '../presentation/auth_login/login_auth.dart';
import '../presentation/login_screen/login-screen.dart';
import '../presentation/login_screen/login_otp.dart';
import '../presentation/main_screen/main_navigation_screen.dart';
import '../presentation/onboarding_screen/onboarding_main.dart';
import '../presentation/onboarding_screen/onboarding_screen1.dart';
import '../presentation/onboarding_screen/onboarding_screen2.dart';
import '../presentation/onboarding_screen/onboarding_screen3.dart';
import '../presentation/profile_screen/select_language_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';


class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String loginOTP = '/login_otp';
  static const String home = '/home';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String mainScreen = '/main_sccreen';
  static const String authLogin = '/auth_login';

  static const onboarding1 = "/onboarding1";
  static const onboarding2 = "/onboarding2";
  static const onboarding3 = "/onboarding3";
  static const String selectLanguage = '/select_language';
  static const String onboardingMain = '/onboardingMain';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());

      case onboardingMain:
        return MaterialPageRoute(builder: (_) => const OnboardingMainScreen());

      case onboarding1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      case onboarding2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());

      case onboarding3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());

      case register:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());

      case authLogin:
        return MaterialPageRoute(builder: (_) =>  AuthLoginScreen());


      case login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      case loginOTP:
         return MaterialPageRoute(builder: (_) => LoginOTP());

      case home:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());

      case profile:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) =>  MainNavigationScreen());
      case selectLanguage:
        final data = args as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => SelectLanguageScreen(data: data),
        );
      // case selectLanguage:
      //   final data = args as Map<String, String>;
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider.value(
      //       value: BlocProvider.of<LoginBloc>(context),
      //     ),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _errorRoutes(String errorMassage) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $errorMassage')),
      ),
    );
  }
}
