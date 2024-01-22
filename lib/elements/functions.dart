import 'package:flutter/material.dart';

class Toast {
  static void showToast(
      BuildContext context, String message, Color color, Color white) {
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

class Loading {
  static void showLoading(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        surfaceTintColor: Colors.white,
        content: SizedBox(
          width: w * 0.1,
          height: w * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                width: w * 0.1,
                height: w * 0.1,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: w * 0.07,
              ),
              Text(
                'Iltimos kuting...',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }
}


class ShowDialogWidget {
  static void show(BuildContext context, String title, String message, Function() onPressed) {
    final w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        surfaceTintColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: w * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            width: w * 0.2,
            height: w * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              },
              child: Center(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: w * 0.03,
                    color: Colors.white,
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
