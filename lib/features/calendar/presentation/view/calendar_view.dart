import 'package:flutter/cupertino.dart';

class CalendarView extends StatelessWidget{
  static const String path = '/calendar';
  static const String name = 'calendar';
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Calendar View'),
    );
  }
}