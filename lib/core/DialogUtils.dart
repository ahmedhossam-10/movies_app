import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  static void showMessage(
      BuildContext context,
      String message, {
        String title = "Message",
        String posActionName = "OK",
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (negActionName != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                negAction?.call();
              },
              child: Text(negActionName),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              posAction?.call();
            },
            child: Text(posActionName),
          ),
        ],
      ),
    );
  }
}
