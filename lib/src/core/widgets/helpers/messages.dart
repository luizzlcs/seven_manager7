import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

sealed class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        backgroundColor: const Color(0XFF842439),
        message: message,
      ),
    );
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: const Color.fromARGB(255, 14, 124, 172),
        message: message,
      ),
    );
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        backgroundColor: const Color(0XFF237D68),
        message: message,
      ),
      animationDuration: const Duration(seconds: 2),
    );
  }
}
