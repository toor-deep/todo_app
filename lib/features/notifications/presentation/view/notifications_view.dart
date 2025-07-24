
import 'package:flutter/material.dart';
import 'package:todo/design-system/styles.dart';

class NotificationsView extends StatelessWidget {
  static const String path = '/notifications';
  static const String name = 'notifications';
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Text(
          'No notifications yet.',
          style: TextStyles.inter14Bold
        ),
      ),
    );
  }
}