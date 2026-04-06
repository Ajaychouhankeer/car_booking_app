import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constants/string_constants.dart';


class InputValidators {
  // 🔹 Email Validator
  static String? validateEmail(String? value, {String? emptyMessage}) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage ?? StringConstants.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return StringConstants.enterValidEmail;
    }

    return null;
  }

  // 🔹 Name Validator
  static String? validateName(
      String? value, {
        String? emptyMessage,
        String? lengthMessage,
      }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage ?? StringConstants.enterFullName;
    }

    final regex = RegExp(r'^[\p{L} ]+$', unicode: true);

    if (!regex.hasMatch(value.trim())) {
      return StringConstants.nameMustContainOnlyLetters;
    }

    if (value.trim().length < 2) {
      return lengthMessage ?? StringConstants.enterFullName;
    }

    return null;
  }

  // // 🔹 Validator Field
  // static String? validateField(String? value, {String? message}) {
  //   if (value == null || value.trim().isEmpty || value == ApiKeyConstants.selectInvestor) {
  //     return message ?? StringConstants.fieldIsRequired;
  //   }
  //   return null;
  // }









  // 🔹 Password Validator
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.passwordRequired;
    }

    if (value.length < 8) {
      return StringConstants.passwordMustBeAtLeast8Characters;
    }

    return null;
  }

  // 🔹 Phone Validator
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.mobileRequired;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return StringConstants.phoneMustBeAtLeast10Characters;
    }

    if (value.length != 10) {
      return StringConstants.phoneMustBeAtLeast10Characters;
    }

    return null;
  }

  // 🔹 Confirm Password Validator
  static String? validateConfirmPassword(
      String? value,
      String originalPassword,
      ) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.confirmPasswordIsRequired;
    }

    if (value != originalPassword) {
      return StringConstants.passwordMismatch;
    }

    return null;
  }
}
