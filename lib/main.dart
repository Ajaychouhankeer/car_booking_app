import 'package:bloc_project_basic/logic/about_bloc/about_bloc.dart';
import 'package:bloc_project_basic/logic/banners/banner_bloc.dart';
import 'package:bloc_project_basic/logic/booking/booking_bloc.dart';
import 'package:bloc_project_basic/logic/vehicles_bloc/vehicle_bloc.dart';
import 'package:bloc_project_basic/presentation/splash_screen/splash_screen.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/api_keys.dart';
import 'core/navigations/navigation_service.dart';
import 'core/translations/translation_service.dart';
import 'data/repositories/authentication/auth_repository.dart';
import 'logic/auth_bloc/auth_bloc.dart';
import 'logic/banners/banner_event.dart';
import 'logic/bottom_nav/bottom_nav_bloc.dart';
import 'logic/distance_bloc/distance_bloc.dart';
import 'logic/login/login_bloc.dart';
import 'logic/login/login_event.dart';
import 'logic/payment_bloc/payment_bloc.dart';
import 'logic/profile_bloc/profile_bloc.dart';
import 'logic/profile_bloc/profile_event.dart';
import 'logic/themes/theme_bloc.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// Load saved language
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? langCode = prefs.getString(ApiKeyConstants.languageKey);
  String? countryCode = prefs.getString(ApiKeyConstants.countryCode);

  Locale initialLocale;

  if (langCode != null && countryCode != null) {
    initialLocale = Locale(langCode, countryCode);
  } else {
    initialLocale = TranslationService.locale;
  }

  runApp( MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key,  required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc()..add(LoginInitialise()),
        ),

        BlocProvider(
          create: (_) => AuthBloc(),
        ),

        BlocProvider(
          create: (_) => ProfileBloc()..add(GetProfileEvent()),
        ),

        BlocProvider(
          create: (_) => BookingBloc(),
        ),

        BlocProvider(
          create: (_) => BannerBloc()..add(FetchBannersEvent()),
        ),

        BlocProvider(
        create: (_) => PaymentBloc(),
        ),

        BlocProvider(
          create: (_) => AboutBloc()
        ),

        BlocProvider(
          create: (_) => DistanceBloc(),
        ),

        BlocProvider(
          create: (_) => VehicleBloc(),
        ),

      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              builder: (context, child) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  navigatorKey: NavigationService.navigatorKey,
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                  initialRoute: AppRoutes.splash,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.deepPurple),
                  ),
                  translations: TranslationService(),
                  locale: initialLocale,
                  fallbackLocale: TranslationService.fallbackLocale,

                  ///initialRoute: '/',
                  ///  onGenerateRoute: AppRoutes.onGenerateRoute,
                  home: const SplashScreen(),
                );
              },
            );
          }),
    );
  }
}
