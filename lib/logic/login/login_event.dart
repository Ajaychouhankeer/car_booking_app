import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSelectLanguage extends LoginEvent {
  final Map<String, String> data;
  final String languageType;
  final String? countryCode;

  const LoginSelectLanguage({required this.languageType, required this.data,this.countryCode});

  @override
  List<Object?> get props => [languageType];
}


class LoginSelectLoginType extends LoginEvent {
  final String loginType;

  const LoginSelectLoginType({required this.loginType});

  @override
  List<Object?> get props => [loginType];
}

class LoginClickOnPassVisibility extends LoginEvent {
}

class LoginInitialise extends LoginEvent {
}

class LoginClickOnForgotPassword extends LoginEvent {
}

class LoginClickOnAgreeTermConditions extends LoginEvent {
}

class LoginClickOnLogin extends LoginEvent {
  final String email;
  final String password;

  LoginClickOnLogin({required this.email, required this.password});
}

class LoginAcceptAllTermsCondition extends LoginEvent {
}
class ShowInlineErrorMessage extends LoginEvent{}
class HideInlineErrorMessage extends LoginEvent{}