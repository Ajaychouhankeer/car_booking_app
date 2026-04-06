import 'package:bloc_project_basic/logic/profile_bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/navigations/navigation_service.dart';
import '../../data/repositories/api_methods.dart';
import '../../presentation/profile_screen/edit_profile_dialog.dart';
import '../../presentation/profile_screen/theme_setting_screen.dart';
import 'profile_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/navigations/navigation_service.dart';
import '../../router/app_router.dart';
import '../../core/constants/api_keys.dart';


import 'profile_state.dart';
import '../../presentation/profile_screen/theme_setting_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/navigations/navigation_service.dart';
import '../../data/repositories/api_methods.dart';
import '../../presentation/profile_screen/theme_setting_screen.dart';
import '../../router/app_router.dart';
import '../../core/constants/api_keys.dart';
import 'profile_state.dart';

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

      case ProfileOptionAction.bookingHistory:
        break;

      case ProfileOptionAction.favorites:
        break;

      case ProfileOptionAction.notifications:
        break;

      case ProfileOptionAction.helpFaq:
        break;

      case ProfileOptionAction.contactUs:
        break;

      case ProfileOptionAction.aboutUs:
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
  void _logout() {
    // NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
  }
}





// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(const ProfileState()) {
//     on<ProfileOptionTapped>(_handleProfileOptionTapped);
//
//     on<GetProfileEvent>((event, emit) async {
//       emit(ProfileLoading());
//
//       try {
//         final response = await ApiMethods.getProfileApi(
//           userId: "", // 👈 agar required nahi hai to ignore
//         );
//
//         if (response != null) {
//           emit(ProfileLoaded(response));
//         } else {
//           emit(ProfileError("No Data Found"));
//         }
//       } catch (e) {
//         emit(ProfileError(e.toString()));
//       }
//     });
//   }
//
//   void _handleProfileOptionTapped(
//       ProfileOptionTapped event,
//       Emitter<ProfileState> emit,
//       ) {
//     switch (event.action) {
//
//       case ProfileOptionAction.editProfile:
//       // TODO: Navigate
//         break;
//
//       case ProfileOptionAction.changePassword:
//       // TODO
//         break;
//
//       case ProfileOptionAction.myBookings:
//       // TODO
//         break;
//
//       case ProfileOptionAction.bookingHistory:
//       // TODO
//         break;
//
//       case ProfileOptionAction.favorites:
//       // TODO
//         break;
//
//       case ProfileOptionAction.notifications:
//       // TODO
//         break;
//
//       case ProfileOptionAction.helpFaq:
//       // TODO
//         break;
//
//       case ProfileOptionAction.contactUs:
//       // TODO
//         break;
//
//       case ProfileOptionAction.aboutUs:
//       // TODO
//         break;
//
//       case ProfileOptionAction.selectTheme:
//         _selectThemeBottomSheet();
//         break;
//
//       case ProfileOptionAction.selectLanguage:
//         NavigationService.pushNamed(
//           AppRoutes.selectLanguage,
//           arguments: {ApiKeyConstants.from: ApiKeyConstants.profile},
//         );
//         break;
//
//       case ProfileOptionAction.logout:
//         _logout();
//         break;
//     }
//   }
//
//   void _selectThemeBottomSheet() {
//     final context = NavigationService.navigatorKey.currentContext!;
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor:
//       isDark ? theme.colorScheme.surface : theme.scaffoldBackgroundColor,
//       enableDrag: false,
//       isDismissible: false,
//       useSafeArea: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) =>IntrinsicHeight (child: ThemeSettingScreen()),
//     );
//   }
//
//
//   void _logout() {
//    // NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
//   }
// }
//













// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(ProfileInitial()) {
//
//     // 🔹 Load Profile
//     on<LoadProfileEvent>((event, emit) async {
//       emit(ProfileLoading());
//
//       try {
//         // अभी dummy data (API बाद में connect करेंगे)
//         await Future.delayed(const Duration(seconds: 1));
//
//         emit(ProfileLoaded(
//           name: "Ajay Chouhan",
//           email: "ajay123@gmail.com",
//           phone: "9876543210",
//         ));
//
//       } catch (e) {
//         emit(ProfileError("Failed to load profile"));
//       }
//     });
//
//     // 🔹 Logout
//     on<LogoutEvent>((event, emit) async {
//       // यहाँ बाद में token remove करेंगे
//       emit(ProfileInitial());
//     });
//
//
//     void _selectAppThemeBottomSheet() {
//       final context = NavigationService.navigatorKey.currentContext!;
//       final theme = Theme.of(context);
//       final isDark = theme.brightness == Brightness.dark;
//
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: isDark
//             ? theme.colorScheme.surface
//             : theme.scaffoldBackgroundColor,
//         enableDrag: false,
//         isDismissible: false,
//         useSafeArea: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         builder: (context) => IntrinsicHeight(child: ThemeSettingScreen()),
//       );
//     }
//   }
// }