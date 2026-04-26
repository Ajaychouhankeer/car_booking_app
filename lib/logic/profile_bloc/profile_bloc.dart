import 'package:bloc_project_basic/logic/profile_bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/navigations/navigation_service.dart';
import '../../data/repositories/api_methods.dart';
import '../../presentation/profile_screen/edit_profile_dialog.dart';
import '../../presentation/profile_screen/theme_setting_screen.dart';
import 'profile_state.dart';
import '../../router/app_router.dart';
import '../../core/constants/api_keys.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {

    /// 🔹 OPTION TAP HANDLER
    on<ProfileOptionTapped>(_handleProfileOptionTapped);

    /// 🔹 GET PROFILE API
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        final response = await ApiMethods.getProfileApi(
          userId: "",
        );

        if (response != null) {
          emit(ProfileLoaded(response));
        } else {
          emit(const ProfileError("No Data Found"));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

  }

  /// 🔹 HANDLE OPTIONS
  void _handleProfileOptionTapped(
      ProfileOptionTapped event,
      Emitter<ProfileState> emit,
      ) {
    switch (event.action) {

      case ProfileOptionAction.editProfile:
        final context = NavigationService.navigatorKey.currentContext!;
        final state = this.state;

        if (state is ProfileLoaded) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => EditProfileDialog(state: state),
          );
        }
        break;

      case ProfileOptionAction.changePassword:
        break;

      case ProfileOptionAction.myBookings:
        break;

      case ProfileOptionAction.favorites:
        break;

      case ProfileOptionAction.notifications:
        break;

      case ProfileOptionAction.helpFaq:
        NavigationService.pushNamed(AppRoutes.helpFaqScreen);
        break;

      case ProfileOptionAction.contactUs:
        NavigationService.pushNamed(AppRoutes.contactScreen);
        break;

      case ProfileOptionAction.aboutUs:
        NavigationService.pushNamed(AppRoutes.aboutScreen);
        break;

      case ProfileOptionAction.selectTheme:
        _selectThemeBottomSheet();
        break;

      case ProfileOptionAction.selectLanguage:
        NavigationService.pushNamed(
          AppRoutes.selectLanguage,
          arguments: {ApiKeyConstants.from: ApiKeyConstants.profile},
        );
        break;

      case ProfileOptionAction.logout:
        _logout();
        break;
    }
  }

  /// 🔹 THEME BOTTOM SHEET
  void _selectThemeBottomSheet() {
    final context = NavigationService.navigatorKey.currentContext!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
      isDark ? theme.colorScheme.surface : theme.scaffoldBackgroundColor,
      enableDrag: false,
      isDismissible: false,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => IntrinsicHeight(
        child: ThemeSettingScreen(),
      ),
    );
  }

  /// 🔹 LOGOUT
  void _logout() async {
    final context = NavigationService.navigatorKey.currentContext!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [

          /// ❌ CANCEL
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          /// ✅ LOGOUT
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final pref = await SharedPreferences.getInstance();

              /// 🔥 REMOVE ONLY TOKEN (SAFE WAY)
              await pref.remove(ApiKeyConstants.token);

              /// (Optional) agar sab clear karna ho
              // await pref.clear();

              /// 🔥 NAVIGATE TO LOGIN
              NavigationService.pushAndRemoveUntil(
                AppRoutes.login,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}




