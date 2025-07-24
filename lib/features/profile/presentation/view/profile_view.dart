
import 'package:flutter/material.dart';
import 'package:todo/design-system/styles.dart';

class ProfileView extends StatelessWidget {
  static const String path = '/profile';
  static const String name = 'profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text(
          'Profile View',
          style: TextStyles.inter14Bold
        ),
      ),
    );
  }
}