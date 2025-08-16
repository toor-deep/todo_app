import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformAlert {
  static Future showPlatformDialog(
      BuildContext context,
      String title,
      String content,
      String leftButton,
      String rightButton, {
        required VoidCallback onLeftButtonPressed,
        required VoidCallback onRightButtonPressed,
      }) {
    if (Platform.isIOS) {
      return  showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(leftButton),
              onPressed: () {
                onLeftButtonPressed();
              },
            ),
            CupertinoDialogAction(
              child: Text(rightButton),
              onPressed: () {
                onRightButtonPressed();
              },
            ),
          ],
        ),
      );
    } else {
      return    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(leftButton),
              onPressed: () {
                onLeftButtonPressed();
              },
            ),
            TextButton(
              child: Text(rightButton),
              onPressed: () {
                onRightButtonPressed();
              },
            ),
          ],
        ),
      );
    }
  }
}
