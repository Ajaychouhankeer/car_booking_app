import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiLogger {
  static void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) {
    if (!kDebugMode) return;

    print("\x1B[33m========== API REQUEST ==========\x1B[0m"); // Yellow
    print("\x1B[36mMethod: $method\x1B[0m"); // Cyan
    print("\x1B[36mURL: $url\x1B[0m"); // Cyan
    if (headers != null && headers.isNotEmpty) {
      const encoder = JsonEncoder.withIndent('  ');
      print("\x1B[35mHeaders: ${encoder.convert(headers)}\x1B[0m"); // Magenta
    }
    if (body != null) {
      const encoder = JsonEncoder.withIndent('  ');
      print("\x1B[32mBody: ${encoder.convert(body)}\x1B[0m"); // Green
    }
    print("\x1B[33m===============================\x1B[0m");
  }

  static void logResponse({
    required int statusCode,
    dynamic responseBody,
  }) {
    if (!kDebugMode) return;

    print("\x1B[34m========== API RESPONSE ==========\x1B[0m"); // Blue
    print("\x1B[36mStatus Code: $statusCode\x1B[0m"); // Cyan
    if (responseBody != null) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        dynamic parsed = responseBody;
        if (responseBody is String) parsed = jsonDecode(responseBody);
        print("\x1B[32mResponse: ${encoder.convert(parsed)}\x1B[0m"); // Green
      } catch (e) {
        print("\x1B[32mResponse: $responseBody\x1B[0m");
      }
    }
    print("\x1B[34m===============================\x1B[0m");
  }

  static void logError({
    required String message,
    int? statusCode,
    dynamic errorBody,
  }) {
    if (!kDebugMode) return;

    print("\x1B[31m========== API ERROR ==========\x1B[0m"); // Red
    if (statusCode != null) {
      print("\x1B[36mStatus Code: $statusCode\x1B[0m"); // Cyan
    }
    print("\x1B[31mError Message: $message\x1B[0m"); // Red
    if (errorBody != null) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        dynamic parsed = errorBody;
        if (errorBody is String) parsed = jsonDecode(errorBody);
        print("\x1B[35mError Body: ${encoder.convert(parsed)}\x1B[0m"); // Magenta
      } catch (e) {
        print("\x1B[35mError Body: $errorBody\x1B[0m"); // Magenta
      }
    }
    print("\x1B[31m===============================\x1B[0m");
  }
}
