import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../core/routing.dart';


void showToast(BuildContext context,
    {required String title,
    required String description,
    ToastificationType? type,
    String? id}) async {
  toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(title),
      description: Text(description),
      type: type);
}

void showSnackbar(String? text, {bool error = false}) {
  ScaffoldMessenger.of(appNavigationKey.currentContext!).clearSnackBars();

  Color? alertColor;
  if (error) {
    alertColor = Colors.red;
  }

  ScaffoldMessenger.of(appNavigationKey.currentContext!).showSnackBar(SnackBar(
      backgroundColor: alertColor,
      content: Text(
        '$text',
      )));
}

