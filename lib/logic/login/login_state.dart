import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/get_langauge/get_langauge_model.dart';
import '../../data/models/get_model/login_model.dart';
import '../../data/networks/response/api_response.dart';

class LoginState extends Equatable {
  final bool showInlineErrorMessage;
  final String loginType;
  final String language;
  final bool checkedTermsCondition;
  final bool visible;
  final bool isSubmitting;
  final bool showTermsSheet;
  final ApiResponse<List<LanguageData>> languageList;
  final ApiResponse<LoginModel>? loginResponse;


  const LoginState({
    required this.loginType,
    required this.language,
    required this.checkedTermsCondition,
    required this.visible,
    required this.isSubmitting,
    required this.languageList,
    required this.showTermsSheet,
    required this.loginResponse,
    required this.showInlineErrorMessage,

  });

  factory LoginState.initial() {
    return const LoginState(
      loginType: '',
      language: 'en',
      checkedTermsCondition: false,
      visible: false,
      isSubmitting: false,
      languageList: const ApiResponse.initial(),
      showTermsSheet: false,
      loginResponse: const ApiResponse.initial(),
      showInlineErrorMessage: false,

    );
  }

  LoginState copyWith({
    bool? showInlineErrorMessage,
    String? loginType,
    String? language,
    bool? checkedTermsCondition,
    bool? visible,
    bool? isSubmitting,
    bool? showTermsSheet,
    ApiResponse<List<LanguageData>>? languageList,
    ApiResponse<LoginModel>? loginResponse,

  }) {
    return LoginState(
      showInlineErrorMessage: showInlineErrorMessage ?? this.showInlineErrorMessage,
      loginType: loginType ?? this.loginType,
      language: language ?? this.language,
      checkedTermsCondition:
      checkedTermsCondition ?? this.checkedTermsCondition,
      visible: visible ?? this.visible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      languageList: languageList ?? this.languageList,
      showTermsSheet: showTermsSheet ?? this.showTermsSheet,
      loginResponse: loginResponse ?? this.loginResponse,

    );
  }

  @override
  List<Object?> get props => [
    loginType,
    language,
    checkedTermsCondition,
    visible,
    isSubmitting,
    languageList,
    showTermsSheet,
    loginResponse,
    showInlineErrorMessage,
  ];
}
