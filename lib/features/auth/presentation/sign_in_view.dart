import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  static const String path = '/sign-in';
  static const String name = 'Sign In';

  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle sign-in logic here
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}