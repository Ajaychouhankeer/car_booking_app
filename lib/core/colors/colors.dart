
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/themes/theme_bloc.dart';
import '../navigations/navigation_service.dart';

class AppColors {
  static bool get isDark =>
      BlocProvider.of<ThemeBloc>(
        NavigationService.navigatorKey.currentContext!,
        //  listen: false,
      ).state.isDark;
  // Shared colors
  static Color get scaffold =>
      isDark ? const Color(0xFF121212) : Colors.white;
  static Color get appBarBackGroundColor =>
      isDark ? const Color(0xFF0E0B17) : AppColors.white; //changed AppColors.secondary to AppColors.white
  static Color get lightDarkWhiteColor =>
      isDark ?  Colors.white:const Color(0xFF121212);

  static Color get appBarTitleColor =>
      isDark ? AppColors.white : AppColors.black;

  static Color get lightDarkBlackColor =>
      isDark ? const Color(0xFF0E0B17): Colors.white;

  static Color get lightDarkNavBarColor =>
      isDark ?  Colors.black.withValues(alpha: 0.7): Colors.white;
  static Color get lightDarkBackgroundColor =>
      isDark ? const Color(0xFF0E0B17):AppColors.white; //changed AppColors.secondary to AppColors.white
  static Color get lightWhiteDarkBackgroundColor =>
      isDark ? const Color(0xFF0E0B17): AppColors.white;
  static Color get enableTextfieldColor =>
      isDark ? const Color(0xFF616161): AppColors.grey;
  static Color get lightDarkBlackGreyColor =>
      isDark ? const Color(0xFFB7B6B9): Colors.black;

  static Color get lightDarkGreyBlackColor =>
      isDark ? Colors.black: grey;

  static Color get lightDarkCardGroundColor =>
      isDark ? const Color(0xFF1A1820) : Colors.white;

// Personal Data Or Nominee Details Screen
  static Color get borderLightDarkColor =>
      isDark ? const Color(0xFF1A1820) : AppColors.white;

  static Color get cardBorderColor => Color(0xFFE7E7E8);
  static Color get buttonSwitchColor => isDark ?   const Color(0xFF6E6D74):const Color(0xFFF8F6FD);

  static Color get unselectedLightDarkBorder  =>
      isDark ? const Color(0xFF1A1C2C) : const Color(0xFFE7E7E8);

  static Color get pieCardLightDark  =>
      isDark ? const Color(0xFF1A1C2C) : const Color(0xFFF4F7FF);

  // For Support Screen Divider Color
  static Color get dividerLightDarkColor =>
      isDark ? const Color(0xFF6E6D74) : const Color(0xFFE7E7E8);

  //Notification Dark Light Theme Color
  static Color get unReadTitleLightDarkTextColor =>
      isDark ? Color(0xFFFFFFFF) : const Color(0xFF0E0B17);
  static Color get CardTextColor =>
      isDark ? Color(0xFFFFFFFF) : const Color(0xFF6E6E6E);

  static Color get unReadMessageLightDarkTextColor =>
      isDark ? const Color(0xFFFFFFFF) : AppColors.greys2;

  static Color get lightDarkGreyColorForText =>
      isDark ? const Color(0xFFB7B6B9): Color(0xFF6E6D74);

  static Color get readTitleMessageDateLightDarkTextColor =>
      isDark ? const Color(0xFFB7B6B9) : const Color(0xFFB7B6B9);

  static Color get notificationBgLightDarkColor =>
      isDark ? const Color(0xFFDAEDE2) : const Color(0xFFE7E7E8);

  static Color get ProfileOptionAndIconColor =>
      isDark ?  AppColors.white : AppColors.black;

  static Color get lightDarkTextLightColor =>
      isDark ? const Color(0xFFE7E7E8) : const Color(0xFFB7B6B9);

  static Color get lightDarkTextDarkColor =>
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF1A1C2C);

  static Color get ShimmerBaseColor =>
      isDark ?  const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0);


  static Color get ShimmerHighlightColor =>
      isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5);

  static Color get lightDarkTextFieldBorderColor =>
      isDark ? Colors.white : Colors.grey;


  static Color get textFieldBgLightDarkColor =>
      isDark ? const Color(0xFF1A1820) : AppColors.secondary;

  static Color get mpinTextFieldBgLightDarkColor =>
      isDark ? const Color(0xFF1A1820) : AppColors.white;


  static Color notificationBg({required bool isRead}) {
    if (isDark) {
      return isRead ? greys2 : white;
    } else {
      return isRead ? white : lightgrey;
    }
  }

  static Color get lightDarkBaseColor =>
      isDark ? const Color(0xFF1A1820) : const Color(0xFFF8F6FD);

  static Color get lightDarkCardColor =>
      isDark ? const Color(0xFF1A1820) : AppColors.white;

  static Color get lightDarkBorderColor =>
      isDark ? AppColors.white : AppColors.black;

  static Color get lightDarkIconColors =>
      isDark ? AppColors.white : AppColors.black;



  static Color get CardShadow =>
      isDark ? const Color(0x000000) : Color(0xFFE9E9E9);

  static Color get deviderColor =>
      isDark ? const Color(0x33FFFFFF): Color(0xFFE9E9E9);

  static Color get CardbackgoundColor =>
     isDark ? Colors.grey.shade900 : AppColors.white;

  static Color get lightYellowDark => isDark? const Color(0xFF2D2E32) :Color(0xFFFFFCF2);
  static Color get lightGreenDark => isDark? const Color(0x33007535) :Color(0xFFF1FFF6);

  static const Color lightgrey = Color(0xFFE7E7E8);

  static const Color MainBlueColor = Color(0xFF011F5B);

  static const Color primary = Color(0xFF8A6AE5);
  static const Color primaryLight = Color(0xFFAD97ED);
  static const Color cardAPrimary = Color(0xFF99A4FF);
  static const Color cardBBlue = Color(0xFFA0D7F3);
  static const Color primary2 = Color(0xFF4B4CED);

  static const Color secondary = Color(0xFFF8F6FD);
  static const Color errorColor = Color(0xFFBE1B2C);
  static const Color white = Colors.white;
  static const Color Red = Colors.red;
  static const Color lightRed = Color(0xFFE27F7F);
  static const Color lightWhite = Colors.white54;
  static const Color grey = Color(0xFFE9E9E9);
  static const Color greys2 = Color(0xFF6E6D74);
  static const Color greysMate = Color(0xFFB7B6B9);
  static const Color black = Colors.black;
  static const Color purple = Color(0xFFC8A0FF);
  static const Color black87 = Colors.black87;
  static const Color whiteTextColor = Colors.white;
  static const Color boldTextColor = Colors.black;
  static const Color lightTextColor = Color(0xFF121212);
  static const Color backGroundColor = Color(0xFF000000);
  static const Color greenColor = Color(0xFF0CB78F);
  static const Color greenDark = Color(0xFF007535);
  static const Color white70 = Colors.white70;
  static const Color profileHeadingColor = Color(0xFF8A6AE5);
  static const Color darkPurple = Color(0xFF534089);
  static const Color ProfileScreenBgColor = Color(0xFFF8F6FD);

  static const Color shadowColor = Color(0x1A000000);

  static const Color darkGreen = Color(0xFF003719);
  static const Color darkGreen2 = Color(0xFF0A7A3B);
  static const Color darkRed = Color(0xFF890000);
  static const Color lightYellow = Color(0xFFF9EEC4);
  static const Color lightYellow2 = Color(0xFFDAB116);
  static const Color lightGreen = Color(0xFFD1F9DE);
  static const Color lightMint = Color(0xFFDAEDE2);
  static const Color lightBlue = Color(0xFFDAE7FF);
  static const Color lightRose = Color(0xFFF9DEEC);
  static const Color GreyShine = Color(0xFFE0E0E0);
  static const Color blue = Color(0xFF1A9EB7);
  static const Color lightPurple = Color(0xFFAD97ED);
  static const Color lightGreenishBlue = Color(0xFFF6FAFF);
  static const Color skyBlue = Color(0xFFA0D7F3);
  static const Color lightPink = Color(0xFFF0ADCF);

  //Mode backgound light color
  static const Color lightYellowMode = Color(0xFFFFFCF2);
  static const Color lightPrimaryMode = Color(0xFFF6FAFF);
  static const Color lightGreenMode = Color(0xFFF1FFF6);

  // Light theme specific
  static const Color lightScaffold = Colors.white;
  static const Color lightAppBar = Colors.blue;

  // Dark theme specific
  static const Color darkScaffold = Color(0xFF121212);
  static const Color darkAppBar = Colors.black;
  static const Color shimmerColor = Colors.black;
  static const Color onboardIndicator = Color(0xFF20283F);
}
