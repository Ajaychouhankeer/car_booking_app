import 'dart:io';

import 'package:bloc/bloc.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_keys.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/widgets/common_app_snackbar.dart';

import '../../data/networks/response/api_response.dart';

import '../../router/app_router.dart';
import '../profile_bloc/profile_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginInitialise>(_loginInitialise);
    on<LoginSelectLanguage>(_loginSelectLanguage);
    on<LoginSelectLoginType>(_loginSelectLoginType);
    on<LoginClickOnPassVisibility>(_loginPasswordVisibility);
    on<LoginClickOnAgreeTermConditions>(_loginClickOnRememberMe);
   // on<LoginClickOnForgotPassword>(_loginClickOnForgotPassword);
    on<LoginClickOnLogin>(_loginClickOnLogin);
    on<LoginAcceptAllTermsCondition>(_loginAcceptAllTermCondition);
    on<ShowInlineErrorMessage>(
          (event, emit) => emit(state.copyWith(showInlineErrorMessage: true)),
    );
    on<HideInlineErrorMessage>(
          (event, emit) => emit(state.copyWith(showInlineErrorMessage: false)),
    );
  }

  void _loginInitialise(LoginInitialise event, Emitter<LoginState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(state.copyWith(language: pref.getString(ApiKeyConstants.languageKey),  loginResponse: ApiResponse.initial()));
  }

  void _loginSelectLanguage(
      LoginSelectLanguage event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(language: event.languageType));

    // SharedPreferences pref=await SharedPreferences.getInstance();
    // pref.setString(ApiKeyConstants.languageKey, event.languageType);
    // LanguageManager.changeLanguage(AppLanguage.hindi);
    // (context as Element).reassemble();
    // if(event.data[ApiKeyConstants.from]==StringConstants.login){
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   NavigationService.pushReplacementNamed(AppRoutes.bottomNav);
    // }else{
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   NavigationService.pop();
    // }
  }

  void _loginSelectLoginType(
      LoginSelectLoginType event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(loginType: event.loginType));
    NavigationService.pushNamed(AppRoutes.login);
  }

  void _loginPasswordVisibility(
      LoginClickOnPassVisibility event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(visible: !state.visible));
  }

  void _loginClickOnRememberMe(
      LoginClickOnAgreeTermConditions event,
      Emitter<LoginState> emit,
      ) {
    emit(
      state.copyWith(
        checkedTermsCondition: !state.checkedTermsCondition,
        showTermsSheet: false,
      ),
    );
  }

  // void _loginClickOnForgotPassword(
  //     LoginClickOnForgotPassword event,
  //     Emitter<LoginState> emit,
  //     ) {
  //   NavigationService.pushNamed(AppRoutes.forgotPassword);
  // }

  // void _loginClickOnLogin(
  //     LoginClickOnLogin event,
  //     Emitter<LoginState> emit,
  //     ) async
  // {
  //   emit(state.copyWith(loginResponse: const ApiResponse.loading()));
  //   try {
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     String? deviceName;
  //     String? deviceId;
  //     String? deviceType;
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       deviceName = androidInfo.model; // Example: "Pixel 4"
  //       deviceId = androidInfo.id;
  //       deviceType = 'android';
  //     } else if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       deviceName = iosInfo.name; // Example: "My iPhone"
  //       deviceId = iosInfo.identifierForVendor;
  //       deviceType = 'ios'; // Unique ID for iOS
  //     }
  //
  //     // final Map<String, String> bodyParam = {
  //     //   ApiKeyConstants.email: event.email,
  //     //   ApiKeyConstants.password: event.password,
  //     //   ApiKeyConstants.fcmToken: Platform.isIOS
  //     //       ? "fjklkadlkj"
  //     //       : (await FirebaseMessaging.instance.getToken()) ?? 'Not Found',
  //     //   ApiKeyConstants.deviceId: deviceId ?? 'fjkjkf',
  //     //   ApiKeyConstants.deviceName: deviceName ?? 'Not Found',
  //     //   ApiKeyConstants.deviceType: deviceType ?? 'android',
  //     // };
  //
  //     final Map<String, String> bodyParam = {
  //       ApiKeyConstants.email: event.email,
  //       ApiKeyConstants.password: event.password,
  //     };
  //
  //
  //     final loginModel = await ApiMethods.loginApi(bodyParams: bodyParam);
  //
  //     if (loginModel != null &&
  //         loginModel.data != null &&
  //         loginModel.data!.token != null) {
  //       if(loginModel.data!.user?.role?.name !="investor"){
  //         emit(
  //           state.copyWith(
  //             loginResponse: ApiResponse.completed(loginModel),
  //             showTermsSheet:loginModel.data!.firstTimeLogin??false,
  //           ),
  //         );
  //         if(loginModel.data!.firstTimeLogin??false){
  //           showModalBottomSheet(
  //             context: NavigationService.navigatorKey.currentContext!,
  //             isScrollControlled: true,
  //             isDismissible: false,
  //             backgroundColor: AppColors.scaffold,
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //             ),
  //             builder: (_) => SafeArea(
  //               child: IntrinsicHeight(child: const TermConditionBottomSheet()),
  //             ),
  //           );
  //         }else{
  //           final pref = await SharedPreferences.getInstance();
  //           pref.setString(ApiKeyConstants.token, loginModel.data!.token?.token ?? "",);
  //           pref.setString(ApiKeyConstants.email, loginModel.data!.user?.email ?? "");
  //           pref.setString(ApiKeyConstants.contactNo, loginModel.data!.user?.contactNo ?? "");
  //           pref.setBool(ApiKeyConstants.firstTimeLogin, loginModel.data!.firstTimeLogin ?? false);
  //           pref.setString(ApiKeyConstants.investorId, loginModel.data!.user?.id.toString() ?? "",);
  //           pref.setString(ApiKeyConstants.setMPin, loginModel.data!.user?.mpin ?? "",);
  //
  //           ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(
  //             NavigationService.navigatorKey.currentContext!,
  //           );
  //           profileBloc.add(ProfileDataFetching());
  //           NavigationService.pushAndRemoveUntil(
  //             AppRoutes.bottomNav,
  //           );
  //         }
  //
  //       }else{
  //         emit(
  //           state.copyWith(
  //             loginResponse: ApiResponse.error(
  //              StringConstants.unAuthorizedUser,
  //             ),
  //             showInlineErrorMessage: true,
  //           ),
  //         );
  //       }
  //
  //     } else {
  //       emit(
  //         state.copyWith(
  //           loginResponse: ApiResponse.error(
  //             loginModel?.message ?? StringConstants.someThingWrong,
  //           ),
  //           showInlineErrorMessage: true,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(loginResponse: ApiResponse.error(e.toString())));
  //     AppSnackBar.show(
  //       message: "${StringConstants.error}: ${e.toString()}",
  //       type: SnackBarType.error,
  //     );
  //   }
  // }

  void _loginClickOnLogin(
      LoginClickOnLogin event,
      Emitter<LoginState> emit,
      ) async {

    emit(state.copyWith(loginResponse: const ApiResponse.loading()));

    try {

      final pref = await SharedPreferences.getInstance();

      /// Get demo registered user
      String savedEmail = pref.getString("demo_email") ?? "";
      String savedPassword = pref.getString("demo_password") ?? "";

      /// Validate login
      if (event.email == savedEmail && event.password == savedPassword) {

        /// Save fake token so splash works
        // pref.setString(ApiKeyConstants.token, "demo_token_123");
        // pref.setString(ApiKeyConstants.email, savedEmail);
        // pref.setString(ApiKeyConstants.contactNo, "9999999999");
        // pref.setBool(ApiKeyConstants.firstTimeLogin, false);
        // pref.setString(ApiKeyConstants.investorId, "1");
        // pref.setString(ApiKeyConstants.setMPin, "1234");

        // emit(
        //   state.copyWith(
        //     loginResponse: ApiResponse.completed(),
        //     showInlineErrorMessage: false,
        //   ),
        // );

        /// Optional: load profile bloc
        ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(
          NavigationService.navigatorKey.currentContext!,
        );
       // profileBloc.add(ProfileDataFetching());

        /// Navigate to dashboard
        NavigationService.pushAndRemoveUntil(
          AppRoutes.mainScreen,
        );

      } else {

        /// Invalid credentials
        emit(
          state.copyWith(
            loginResponse: ApiResponse.error("Invalid demo credentials"),
            showInlineErrorMessage: true,
          ),
        );

      }

    } catch (e) {

      emit(state.copyWith(loginResponse: ApiResponse.error(e.toString())));

      AppSnackBar.show(
        message: "${StringConstants.error}: ${e.toString()}",
        type: SnackBarType.error,
      );

    }
  }

  void _loginAcceptAllTermCondition(
      LoginAcceptAllTermsCondition event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(isSubmitting: true));

    final loginModel = state.loginResponse?.data;

    if (loginModel != null && loginModel.data != null) {
      final pref = await SharedPreferences.getInstance();
      // pref.setString(ApiKeyConstants.token, loginModel.data!.token?.token ?? "",);
      // pref.setString(ApiKeyConstants.email, loginModel.data!.user?.email ?? "");
      // pref.setString(ApiKeyConstants.contactNo, loginModel.data!.user?.contactNo ?? "");
      // pref.setBool(ApiKeyConstants.firstTimeLogin, loginModel.data!.firstTimeLogin ?? false);
      // pref.setString(ApiKeyConstants.investorId, loginModel.data!.user?.id.toString() ?? "",);
      // pref.setString(ApiKeyConstants.setMPin, loginModel.data!.user?.mpin ?? "",);

      ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(
        NavigationService.navigatorKey.currentContext!,
      );
    //  profileBloc.add(ProfileDataFetching());
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        showTermsSheet: false,
        loginResponse: ApiResponse.initial(),
      ),
    );

    Map<String, String> data = {ApiKeyConstants.from: ApiKeyConstants.login};
    NavigationService.pushAndRemoveUntil(
      AppRoutes.selectLanguage,
      arguments: data,
    );
  }
}
