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


