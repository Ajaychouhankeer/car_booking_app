import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/themes/theme_bloc.dart';
import '../navigations/navigation_service.dart';

class GifConstants {
  static bool get isDark => BlocProvider.of<ThemeBloc>(
    NavigationService.navigatorKey.currentContext!,
  ).state.isDark;

  static const _giSuccess = 'assets/gifs/gi_success.gif';
  static const _giSuccessDark = 'assets/gifs/gi_success_dark.gif';
  static const giSaving = 'assets/gifs/gi_saving.gif';
  static const giLogout = 'assets/gifs/gi_logout.gif';
  static const giLogoutIcon = 'assets/gifs/gi_logout.gif';
  static const giSetMpin = 'assets/gifs/set_mpin.gif';
  static const imgMPINSubmitLight = 'assets/images/stars_light.gif';
  static const imgMPINSubmitdark = 'assets/images/stars_dark.gif';
  static const imgPendingWithdrawal = 'assets/gifs/gi_pending_withdrawal.gif';
  static const imgRejectWithdrawal = 'assets/gifs/gi_reject_withdrawal.gif';
  static const pixyAnnimatedLogo = 'assets/gifs/pixy_annimated_logo.gif';
  static const giDeleteBin = 'assets/gifs/gi_delete_bin.gif';

  static String get giSuccess=>
      isDark ? _giSuccessDark : _giSuccess;

  static String get mpinGifImg =>
      isDark ? imgMPINSubmitdark : imgMPINSubmitLight;


}