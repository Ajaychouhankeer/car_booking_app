import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/themes/theme_bloc.dart';
import '../navigations/navigation_service.dart';

class IconConstants {
  static bool get isDark => BlocProvider.of<ThemeBloc>(
    NavigationService.navigatorKey.currentContext!,
  ).state.isDark;
  static const String icOnboardingOne = 'assets/icons/ic_onboarding_one.svg';
  static const String icOnboardingTwo = 'assets/icons/ic_onboarding.svg';
  static const String icOnboardingThre = 'assets/icons/ic_onboarding_one.svg';

  static const String icBack = 'assets/icons/ic_back.svg';
  static const String icLogo = 'assets/icons/ic_logo.png';
  static const String icYunicornLogo = 'assets/icons/ic_yunicorn_logo.png';
  static const String icEmail = 'assets/icons/ic_email.png';
  static const String icCloseCircle = 'assets/icons/ic_close_circle.png';

  static const String icHome = 'assets/icons/ic_home.svg';
  static const String icHomeSelected = 'assets/icons/ic_home_selected.svg';
  static const String icInvestment = 'assets/icons/ic_investment.svg';
  static const String icInvestmentSelected =
      'assets/icons/ic_investment_selected.svg';
  static const String icPayouts = 'assets/icons/ic_payouts.svg';
  static const String icPayoutsSelected = 'assets/icons/ic_payout_selected.svg';
  static const String icReferrals = 'assets/icons/ic_referrals.svg';
  static const String icReferralsSelected =
      'assets/icons/ic_referrals_selected.svg';
  static const String icRequests = 'assets/icons/ic_requests.svg';
  static const String icRequestsSelected =
      'assets/icons/ic_requests_selected.svg';
  static const String icUserSquare = 'assets/icons/ic_user_square.svg';
  static const String icHide = 'assets/icons/ic_hide.svg';
  static const String icShow = 'assets/icons/ic_show.svg';
  static const String icPassword = 'assets/icons/ic_password.svg';
  static const String icPhone = 'assets/icons/ic_phone.svg';
  static const String icRupees = 'assets/icons/ic_rupees_logo.svg';
  static const String icPercentage = 'assets/icons/ic_percentage_logo.svg';
  static const String icSort = 'assets/icons/ic_sort_logo.svg';
  static const String icHideFilled = 'assets/icons/ic_hide_filled.svg';
  static const String icShowFilled = 'assets/icons/ic_show_filled.svg';
  static const String icGroup = 'assets/icons/ic_groups_logo.svg';
  static const String icCalendarFilled = 'assets/icons/ic_calendar_filled.svg';
  static const String icArrowDownFilledTriangle =
      'assets/icons/ic_arrow_down_filled_triangle.svg';

  static const String PersonalDataIcon = 'assets/icons/ic_user_square.svg';
  static const String NomineeDtetails = 'assets/icons/ic_nominee_details.svg';
  static const String ChangePassword = 'assets/icons/ic_changepass.svg';
  static const String EKycIcon = 'assets/icons/ic_ekyc.svg';
  static const String BankDetails = 'assets/icons/ic_bankdetails.svg';
  static const String ChnageMPi = 'assets/icons/ic_changepin.svg';
  static const String Language = 'assets/icons/ic_language.svg';
  static const String TermAndConditionIcon =
      'assets/icons/ic_termandcodition.svg';
  static const String AboutPixy = 'assets/icons/lock.png';
  static const String AboutYunicornGroup = 'assets/icons/ic_about_yunicorn.svg';
  static const String icYunicorn = 'assets/icons/ic_yunicorn.svg';
  static const String FAQsIcon = 'assets/icons/ic_faqs.svg';
  static const String SupportIcon = 'assets/icons/ic_support.svg';
  static const String Logout = 'assets/icons/ic_logout.svg';
  static const String NewArrowLeftIcon = 'assets/icons/ic_new_arrow-left.svg';
  static const String NewLogoutAlertIcon = 'assets/icons/ic_newlogout.svg';
  static const String _icVerticalLineIcon =
      'assets/icons/ic_verticalLineIcon.svg';
  static const String _icVerticalLineIconDark =
      'assets/icons/ic_verticalLineIconDark.svg';
  static const String icWithdrawRupeeIcon =
      'assets/icons/ic_withdraw_rupee.svg';
  static const String _icVerticalLine_ThinEdge =
      'assets/icons/ic_verticalLine_thinEdge.svg';
  static const String _icVerticalLineDark_ThinEdge =
      'assets/icons/ic_verticalLineDark_thinEdge.svg';
  static const String icLinkOutlined = 'assets/icons/ic_link_outlined.svg';
  static const String icEyeGalleryOutlined = 'assets/icons/ic_eye_gallery_outlined.svg';
  static const String icSearch = 'assets/icons/ic_search.svg';

  static const String icGalleryUpload = 'assets/icons/ic_gallery_upload.svg';
  static const String icShare = 'assets/icons/ic_share.svg';
  static const String icCloseCircular = 'assets/icons/ic_close_circular.svg';
  static const String icRupeeSquare = 'assets/icons/ic_rupee_square.svg';
  static const String icReceipt = 'assets/icons/ic_receipt.svg';
  static const String icCardSend = 'assets/icons/ic_card_send.svg';
  static const String icAdd = 'assets/icons/ic_add.svg';
  static const String icMoneyBag = 'assets/icons/ic_money_bag.svg';
  static const String icMoneyReceiveCircular =
      'assets/icons/ic_money_receive_circular.svg';
  static const String icSlipLogo = 'assets/icons/ic_slip_logo.svg';
  static const String icWallet = 'assets/icons/ic_empty_wallet.svg';

  static const String icPersonalData = 'assets/icons/ic_user_square.svg';
  static const String icNomineeDtetails =
      'assets/icons/icon_new_nominee_details.svg';
  static const String icSelectThemes = 'assets/icons/newtheme_icon.svg';
  static const String icChangePassword = 'assets/icons/ic_changepass.svg';
  static const String icEKyc = 'assets/icons/ic_ekyc.svg';
  static const String icBankDetails = 'assets/icons/ic_bankdetails.svg';
  static const String icChangeMPi = 'assets/icons/ic_changepin.svg';
  static const String icLanguage = 'assets/icons/ic_language.svg';
  static const String icTermAndCondition =
      'assets/icons/ic_termandcodition.svg';
  static const String icAboutPixy = 'assets/icons/lock.png';
  static const String icAboutYunicornGroup =
      'assets/icons/ic_about_yunicorn.svg';
  static const String icFAQs = 'assets/icons/ic_faqs.svg';
  static const String icSupport = 'assets/icons/ic_support.svg';
  static const String icLogout = 'assets/icons/ic_logout.svg';
  static const String icNewArrowLeft = 'assets/icons/ic_new_arrow-left.svg';
  static const String icEditProfile = 'assets/icons/ic_edit_profile.svg';
  static const String icCustomerServiceEmail =
      'assets/icons/customersupport_email.svg';
  static const String icCustomerServiceMob =
      'assets/icons/customersupport_mobile.svg';
  static const String icCustomerServiceMain =
      'assets/icons/customer_supportsvgicon.svg';
  static const String icAboutNewLogo = 'assets/icons/YunicornAboutLogo.svg';
  static const String icHomeRupees = 'assets/icons/ic_home_rupees.svg';
  static const String icEmptyWalletTick =
      'assets/icons/ic_empty_wallet_tick.svg';
  static const String icCameraVectorOne = 'assets/icons/vector1.svg';
  static const String icCameraVectorTwo = 'assets/icons/vector2.svg';
  static const String icCameraVectorThree = 'assets/icons/vector3.svg';
  static const String icCameraVectorFour = 'assets/icons/vector4.svg';
  static const String icNotificationIconDark =
      'assets/icons/notification_icon_darkmode.svg';
  static const String icNotificationIconLight =
      'assets/icons/notification_icon_lightmode.svg';
  static const String userIcons = 'assets/icons/user.svg';
  static const String icEmpyProfileLightMode =
      'assets/icons/empty_profile_lm.svg';
  static const String icEmpyProfileDarkMode =
      'assets/icons/empty_profile_dm.svg';
  static const String icGift = 'assets/icons/ic_gift.svg';
  static const String icReinvestment= 'assets/icons/ic_reinvestment.svg';
  static const String icPdfIcon= 'assets/icons/ic_pdfIcon.svg';
  static const String icExcel= 'assets/icons/ic_excel.svg';
  static const String singleUser = 'assets/icons/single_user.svg';
  static const String multiUser = 'assets/icons/group.svg';
  static const String icEdit = 'assets/icons/ic_edit.svg';
  static const String icDelete = 'assets/icons/ic_delete.svg';
  static const String icNewSearch = 'assets/icons/new_search_icon.svg';
  static const String icUpload = 'assets/icons/ic_upload.svg';
  static const String icNewFilterIcon = 'assets/icons/ic_new_filter_icon.svg';
  static const String icNewInvestmentIcon = 'assets/icons/ic_new_investment_icon.svg';
  static const String icNewInvestmentReturn = 'assets/icons/ic_new_investment_return.svg';
  static const String icAddIcon = 'assets/icons/ic_addIcon.svg';
  static const String icMore = 'assets/icons/ic_more.svg';
  static const String icLess = 'assets/icons/ic_less.svg';
  static const String icCash = 'assets/icons/ic_cash.svg';
  static const String icOnline = 'assets/icons/ic_online.svg';
  static const String icHybrid = 'assets/icons/ic_hybrid.svg';

  static const String icWithdrawalSelected = 'assets/icons/ic_withdrawal_nav_select.svg';
  static const String icWithdrawalUnSelected = 'assets/icons/ic_withdrawal_nav_unselect.svg';
  static const String icExport = 'assets/icons/ic_export.svg';
  static const String icFilter = 'assets/icons/ic_filter.svg';
  static const String icTopCardTw = 'assets/icons/ic_amount.svg';
  static const String icTopCardTa = 'assets/icons/ic_topcard_tn.svg';
  static const String moneyPlant = 'assets/icons/ic_money_plant.svg';
  static const String moneyHand = 'assets/icons/ic_money_hand.svg';
  static const String icSchedule = 'assets/icons/ic_schedule.svg';
  static const String icSearchIcon = 'assets/icons/ic_search_icon.svg';
  static const String icDashboard = 'assets/icons/ic_dashboard.svg';
  static const String icDashboardSelected = 'assets/icons/ic_dashboard_selected.svg';
  static const String icCommission = 'assets/icons/ic_commission.svg';
  static const String icCommissionSelected = 'assets/icons/ic_commission_selected.svg';
  static String get icEmptyProfileIcon =>
      isDark ? icEmpyProfileDarkMode : icEmpyProfileLightMode;

  static String get icNotificationIcon =>
      isDark ? icNotificationIconDark : icNotificationIconLight;

  static String get icVerticalLineIcon =>
      isDark ? _icVerticalLineIconDark : _icVerticalLineIcon;

  static String get verticalLine_ThinEdge =>
      isDark ? _icVerticalLine_ThinEdge : _icVerticalLineDark_ThinEdge;
}
