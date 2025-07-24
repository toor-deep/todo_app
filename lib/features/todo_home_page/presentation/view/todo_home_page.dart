import 'package:flutter/material.dart';
import 'package:todo/design-system/styles.dart';

class ToDoHomePage extends StatelessWidget {
  static const String path = '/todo-home';
  static const String name = 'todo-home';
  const ToDoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Center(
        child: Text(
          'Welcome to the To-Do List App!',
          style: TextStyles.inter14Bold
        ),
      ),
    );
  }
}