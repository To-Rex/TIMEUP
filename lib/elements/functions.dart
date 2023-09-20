
import 'package:flutter/material.dart';
class Toast {
  static void showToast(BuildContext context, String message, Color color, Color white) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        closeIconColor: Colors.white,
        backgroundColor: color,
        showCloseIcon: true,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}