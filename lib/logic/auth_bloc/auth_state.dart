import '../../data/models/get_model/login_model.dart';


import '../../data/models/get_model/login_model.dart';
import '../../data/networks/response/api_response.dart';

class AuthState {
  final ApiResponse<LoginModel>? authResponse;
  final bool isPasswordHidden;

  const AuthState({
    this.authResponse,
    this.isPasswordHidden = true,
  });

  /// 🔹 Initial State
  factory AuthState.initial() {
    return const AuthState(
      authResponse: ApiResponse.initial(),
      isPasswordHidden: true,
    );
  }

  /// 🔹 CopyWith (VERY IMPORTANT)
  AuthState copyWith({
    ApiResponse<LoginModel>? authResponse,
    bool? isPasswordHidden,
  }) {
    return AuthState(
      authResponse: authResponse ?? this.authResponse,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }
}

// abstract class AuthState {
//   final bool isPasswordHidden;
//
//   const AuthState({this.isPasswordHidden = true});
// }
//
// class AuthInitial extends AuthState {
//   const AuthInitial({bool isPasswordHidden = true})
//       : super(isPasswordHidden: isPasswordHidden);
// }
//
// class AuthLoading extends AuthState {
//   const AuthLoading({bool isPasswordHidden = true})
//       : super(isPasswordHidden: isPasswordHidden);
// }
//
// class AuthSuccess extends AuthState {
//   final LoginModel model;
//
//   const AuthSuccess(this.model, {bool isPasswordHidden = true})
//       : super(isPasswordHidden: isPasswordHidden);
// }
//
// class AuthError extends AuthState {
//   final String message;
//
//   const AuthError(this.message, {bool isPasswordHidden = true})
//       : super(isPasswordHidden: isPasswordHidden);
// }




//abstract class AuthState {}
// class AuthInitial extends AuthState {}
//
// class AuthLoading extends AuthState {}
//
// class AuthSuccess extends AuthState {
//   final LoginModel model;
//
//   AuthSuccess(this.model);
// }
//
// class AuthError extends AuthState {
//   final String message;
//
//   AuthError(this.message);
// }