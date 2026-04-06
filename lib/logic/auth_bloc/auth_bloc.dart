import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_keys.dart';
import '../../data/networks/response/api_response.dart';
import '../../data/repositories/api_methods.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthState.initial()) {

    on<RegisterEvent>(_register);
    on<LoginEvent>(_login);
    on<TogglePasswordVisibilityEvent>(_togglePassword);
  }

  /// 🔹 REGISTER FUNCTION
  Future<void> _register(
      RegisterEvent event,
      Emitter<AuthState> emit,
      ) async {

    emit(state.copyWith(
      authResponse: const ApiResponse.loading(),
    ));

    try {
      final response = await ApiMethods.registerApi(
        bodyParams: event.body,
      );

      if (response != null && response.success == true) {

        emit(state.copyWith(
          authResponse: ApiResponse.completed(response),
        ));

      } else {

        emit(state.copyWith(
          authResponse: ApiResponse.error(
            response?.message ?? "Register Failed",
          ),
        ));
      }

    } catch (e) {

      emit(state.copyWith(
        authResponse: ApiResponse.error(e.toString()),
      ));
    }
  }

  /// 🔹 LOGIN FUNCTION
  Future<void> _login(
      LoginEvent event,
      Emitter<AuthState> emit,
      ) async {

    emit(state.copyWith(
      authResponse: const ApiResponse.loading(),
    ));

    try {
      final response = await ApiMethods.loginApi(
        bodyParams: event.body,
      );

      if (response != null && response.success == true) {

        /// 🔥 TOKEN SAVE
        final pref = await SharedPreferences.getInstance();

        await pref.setString(
          ApiKeyConstants.token,
          response.data?.token ?? "",
        );

        emit(state.copyWith(
          authResponse: ApiResponse.completed(response),
        ));

      } else {

        emit(state.copyWith(
          authResponse: ApiResponse.error(
            response?.message ?? "Login Failed",
          ),
        ));
      }

    } catch (e) {

      emit(state.copyWith(
        authResponse: ApiResponse.error(e.toString()),
      ));
    }
  }

  /// 🔹 PASSWORD TOGGLE (SUPER CLEAN NOW)
  void _togglePassword(
      TogglePasswordVisibilityEvent event,
      Emitter<AuthState> emit,
      ) {

    emit(state.copyWith(
      isPasswordHidden: !state.isPasswordHidden,
    ));
  }
}



// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../core/constants/api_keys.dart';
// import '../../data/repositories/authentication/auth_repository.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository repository;
//
//   AuthBloc(this.repository) : super(AuthInitial()) {
//
//
//     /// REGISTER
//     on<RegisterEvent>((event, emit) async {
//       emit(AuthLoading());
//
//       try {
//         final response = await repository.register(event.body);
//
//         if (response != null && response.success == true) {
//           emit(AuthSuccess(response));
//         } else {
//           emit(AuthError(response?.message ?? "Register Failed"));
//         }
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//
//     /// LOGIN
//     on<LoginEvent>((event, emit) async {
//       emit(AuthLoading());
//
//       try {
//         final response = await repository.login(event.body);
//
//         if (response != null && response.success == true) {
//
//           /// 🔥 TOKEN SAVE (FIXED)
//           final pref = await SharedPreferences.getInstance();
//
//           await pref.setString(
//             ApiKeyConstants.token,
//             response.data?.token ?? "",
//           );
//
//           print("✅ SAVED TOKEN: ${response.data?.token}");
//           emit(AuthSuccess(response));
//         } else {
//           emit(AuthError(response?.message ?? "Login Failed"));
//         }
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//
//
//     on<TogglePasswordVisibilityEvent>((event, emit) {
//       final current = state;
//
//       if (current is AuthLoading) {
//         emit(AuthLoading(isPasswordHidden: !current.isPasswordHidden));
//       } else if (current is AuthSuccess) {
//         emit(AuthSuccess(current.model,
//             isPasswordHidden: !current.isPasswordHidden));
//       } else if (current is AuthError) {
//         emit(AuthError(current.message,
//             isPasswordHidden: !current.isPasswordHidden));
//       } else {
//         emit(AuthInitial(isPasswordHidden: !current.isPasswordHidden));
//       }
//     });
//
//   }
//
// }