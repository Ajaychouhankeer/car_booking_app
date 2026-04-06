import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/themes/theme_bloc.dart';
import '../navigations/navigation_service.dart';
class ImageConstants {
  static bool get isDark => BlocProvider.of<ThemeBloc>(
    NavigationService.navigatorKey.currentContext!,
  ).state.isDark;


  static const familyTripHomeImage = 'assets/images/familytrip.png';
  static const darshanTripHomeImage = 'assets/images/darshanTrip.png';
  static const transportTripHomeImage = 'assets/images/transport.png';

  static const skipTextIcon ='assets/images/skip.png';
  static const splashLogo ='assets/images/car_booking_logo.png';
  static const nextArrow ='assets/images/next_arrow.png';
  static const google ='assets/images/Google.png';
  static const facebook ='assets/images/facebook.png';
  static const apple ='assets/images/apple.png';
  static const saleImg ='assets/images/banner.jpeg';
  static const welcomeImageFirst ='assets/images/welcomeImage.jpeg';

  static const imageNoDataFound = 'assets/images/img_no_data_fond.png';
  static const imgLoginBg = 'assets/images/img_login_bg.png';
  static const imgEnglishLng = 'assets/images/img_english_lng.svg';
  static const imgHindiLng = 'assets/images/img_hindi_lng.svg';
  static const imgMarathiLng = 'assets/images/img_marathi_lng.svg';
  static const imgDummyOnboarding = 'assets/images/img_dummy_onboarding.png';

  static const VehicalSwift = 'assets/images/car.png';

  // static const _imgAuthIllustration = 'assets/images/img_auth_illustration.svg';
  // static const _imgAuthIllustrationDark =
  //     'assets/images/img_auth_illustration_dark.svg';

  //
  // static const imgFullPixyLogo = 'assets/images/img_full_pixy_logo.svg';
  // static const _imgPixySplash = 'assets/images/img_splash.png';
  // static const _imgPixySplashDark = 'assets/images/img_splash_dark.png';
  // static const _imgLightThemeYunicornLogo =
  //     'assets/images/img_light_theme_yunicorn_logo.svg';
  // static const _imgDarkThemeYunicornLogo =
  //     'assets/images/img_dark_theme_yunicorn_logo.svg';
  //
  // static const _onboardingImage1 = "assets/images/img_onboard_1.png";
  // static const _onboardingImage1Dark = "assets/images/img_onboard_1_dark.png";
  // static const _onboardingImage2 = 'assets/images/img_onboard_2.svg';
  // static const _onboardingImage2Dark = 'assets/images/img_onboard_2_dark.svg';
  // static const _onboardingImage3_without_center =
  //     'assets/images/img_onboard_3_without_center.svg';
  // static const _onboardingImage3_without_center_dark =
  //     'assets/images/img_onboard_3_without_center_dark.svg';
  // static const _onboardingImage_3_center =
  //     'assets/images/img_onboard_3_center.svg';
  // static const _onboardingImage_3_center_dark =
  //     'assets/images/img_onboard_3_dark_center.svg';
  // static const _imgPixyBWLogo = 'assets/images/img_pixy_bw_logo.png';
  // static const _imgPixyBWLogoDark = 'assets/images/imgPixyBWLogoDark.png';
  static const imgDarkThemeYunicornLogo =
      'assets/images/img_dark_theme_yunicorn_logo.svg';
  static const imgFrequentlyAskedQuestion = "assets/images/img_faq.svg";
  static const customerSupportLogo = 'assets/images/customer_support.png';
  static const logoutAlertboxImage = 'assets/images/ic_newlogoutAlert.png';
  static const imageAboutYunicornLogo = 'assets/images/yunicorn_icon.png';
  static const imgEmptyInvestment = 'assets/images/img_empty_investment.svg';
  static const imgErrorLight = 'assets/images/img_error_light.svg';
  static const imgEmptyWithdrawal = 'assets/images/img_empty_withdrawal.svg';
  static const imgEmptyReferrals = 'assets/images/img_empty_referrals.svg';
  static const imgEmptyPayout = 'assets/images/img_empty_payout.svg';
  static const imgEmptyRequest = 'assets/images/img_empty_request.svg';
  static const imgPixyTextLogo = 'assets/images/img_pixy_text_logo.svg';
  static const imgNoInternet = 'assets/images/img_no_internet.svg';
  static const icModeratorNotFound= 'assets/images/icNoDataFound.png';
  static const imgEmptyNotification =
      'assets/images/img_empty_notifications.svg';

  // static String get imgPixySplash =>
  //     isDark ? _imgPixySplashDark : _imgPixySplash;
  //
  // static String get imgLightThemeYunicornLogo =>
  //     isDark ? _imgDarkThemeYunicornLogo : _imgLightThemeYunicornLogo;
  //
  // static String get onboardingImage1 =>
  //     isDark ? _onboardingImage1Dark : _onboardingImage1;
  //
  // static String get onboardingImage2 =>
  //     isDark ? _onboardingImage2Dark : _onboardingImage2;
  //
  // static String get onboardingImage3_without_center => isDark
  //     ? _onboardingImage3_without_center_dark
  //     : _onboardingImage3_without_center;
  //
  // static String get onboardingImage_3_center =>
  //     isDark ? _onboardingImage_3_center_dark : _onboardingImage_3_center;
  //
  // static String get imgAuthIllustration =>
  //     isDark ? _imgAuthIllustrationDark : _imgAuthIllustration;
  //
  // static String get imgPixyBWLogo =>
  //     isDark ? _imgPixyBWLogoDark : _imgPixyBWLogo;
}
