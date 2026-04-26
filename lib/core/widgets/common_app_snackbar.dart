import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum SnackBarType { info, success, error, warning, neutral }

class AppSnackBar {

  static void show({
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final config = _getConfig(type);

    Get.snackbar(
      "",
      "",
      titleText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(config.icon, color: config.color, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: config.textColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      messageText: const SizedBox.shrink(),
      backgroundColor: config.bgColor,
      padding: const EdgeInsets.only(left: 8, right: 12, top: 10, bottom: 4),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Icon(Icons.close, color: config.textColor),
      ),
    );
  }

  // Snackbar style config
  static _SnackbarConfig _getConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return _SnackbarConfig(
          icon: Icons.info,
          color: Colors.blue,
          bgColor: const Color(0xffe8f1ff),
          textColor: Colors.blue.shade700,
        );

      case SnackBarType.success:
        return _SnackbarConfig(
          icon: Icons.check_circle,
          color: Colors.blue,
          bgColor: const Color(0xffddf5df),
          textColor: Colors.blue.shade800,
        );

      case SnackBarType.error:
        return _SnackbarConfig(
          icon: Icons.error,
          color: Colors.red.shade700,
          bgColor: const Color(0xffffe0e0),
          textColor: Colors.red.shade800,
        );

      case SnackBarType.warning:
        return _SnackbarConfig(
          icon: Icons.warning,
          color: Colors.amber.shade800,
          bgColor: const Color(0xfffff5d6),
          textColor: Colors.amber.shade900,
        );

      case SnackBarType.neutral:
      default:
        return _SnackbarConfig(
          icon: Icons.info_outline,
          color: Colors.grey.shade800,
          bgColor: const Color(0xffe9e9e9),
          textColor: Colors.grey.shade900,
        );
    }
  }
}

class _SnackbarConfig {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final Color textColor;

  _SnackbarConfig({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.textColor,
  });
}
