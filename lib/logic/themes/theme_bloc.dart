import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_keys.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/theme_pre_helper.dart';
import '../../router/app_router.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDark: false)) {
    on<LoadList>(_onLoadList);
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<ThemeApply>(_onThemeApply);
    on<ResetSelfInvestorMode>((event, emit){
      emit(state.copyWith(isInvestorMode: true));
    });
    on<ToggleSelfInvestorMode>((event, emit) {
      if(!event.isSelfMode){
        emit(state.copyWith(isInvestorMode: !state.isInvestorMode));
        if(state.isInvestorMode){
          NavigationService.pushReplacementNamed(AppRoutes.splash);
        }else{
          NavigationService.pushReplacementNamed(AppRoutes.splash);
        }
      }
    });
  }

  Future<void> _onLoadList(LoadList event, Emitter<ThemeState> emit) async {
    emit(
      state.copyWith(
        themeList: [
          ApiKeyConstants.light,
          ApiKeyConstants.dark,
          ApiKeyConstants.systemDefault,
        ],
      ),
    );
  }


  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final savedTheme = await ThemePrefHelper.getSelectedTheme();

    final isDarkStored = await ThemePrefHelper.getTheme();
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isSystemDark = brightness == Brightness.dark;

    bool finalIsDark = isDarkStored;

    if (state.selectedTheme == ApiKeyConstants.systemDefault) {
      finalIsDark = isSystemDark;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();

    emit(
      state.copyWith(
        isDark: finalIsDark,
        selectedTheme: savedTheme,
      ),
    );
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(selectedTheme: event.theme));
  }

  Future<void> _onThemeApply(ThemeApply event, Emitter<ThemeState> emit) async {
    bool newIsDark = state.isDark;

    if (state.selectedTheme == ApiKeyConstants.light) {
      newIsDark = false;
      await ThemePrefHelper.setTheme(false);
      await ThemePrefHelper.setSelectedTheme(ApiKeyConstants.light);
    } else if (state.selectedTheme == ApiKeyConstants.dark) {
      newIsDark = true;
      await ThemePrefHelper.setTheme(true);
      await ThemePrefHelper.setSelectedTheme(ApiKeyConstants.dark);
    } else if (state.selectedTheme == ApiKeyConstants.systemDefault) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      newIsDark = brightness == Brightness.dark;
      await ThemePrefHelper.setTheme(newIsDark);
      await ThemePrefHelper.setSelectedTheme(ApiKeyConstants.systemDefault);
    }

    final oldIsDark = state.isDark;

    emit(state.copyWith(isDark: newIsDark));

    final themeChanged = oldIsDark != newIsDark;

    if (themeChanged) {
      if(state.isInvestorMode){
        NavigationService.pushReplacementNamed(AppRoutes.splash);
      }else{
        NavigationService.pushReplacementNamed(AppRoutes.splash);
      }
    } else {
      NavigationService.pop();
    }
  }
}
