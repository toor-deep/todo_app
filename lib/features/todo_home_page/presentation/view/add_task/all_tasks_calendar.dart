import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo/design-system/app_colors.dart';

import '../../../../../shared/app_constants.dart';

class AllTasksCalendarScreen extends StatefulWidget {
  const AllTasksCalendarScreen({Key? key}) : super(key: key);

  @override
  State<AllTasksCalendarScreen> createState() => _AllTasksCalendarScreenState();
}

class _AllTasksCalendarScreenState extends State<AllTasksCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> _tasks = {
    DateTime(2024, 4, 18): [
      {
        "priority": "High",
        "title": "Interview with Alex",
        "time": "10:30 AM",
        "type": "To-Do",
        "color": Colors.red,
      },
      {
        "priority": "Medium",
        "title": "Marketing Strategy",
        "time": "11:30 AM",
        "type": "To-Do",
        "color": Colors.orange,
      },
    ],
    DateTime(2024, 4, 19): [
      {
        "priority": "Low",
        "title": "Product Meeting",
        "time": "08:30 AM",
        "type": "To-Do",
        "color": Colors.green,
      },
    ],
  };

  List<Map<String, dynamic>> getTasksForDay(DateTime day) {
    return _tasks[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  @override
  Widget build(BuildContext context) {
    final tasks = getTasksForDay(_selectedDay ?? _focusedDay);

    return Column(
      children: [
        _buildCalendar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('dd MMMM yyyy').format(_selectedDay ?? _focusedDay),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2030),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerVisible: true,
      calendarFormat: CalendarFormat.week,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      daysOfWeekVisible: false,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: TextStyle(fontSize: 14.sp),
        todayDecoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isSelected: false);
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isToday: true);
        },
        selectedBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isSelected: true);
        },
      ),
    );
  }
  Widget _buildDayCell(DateTime day, {bool isSelected = false, bool isToday = false}) {
    final tasksForThisDay = getTasksForDay(day);
    final hasTask =true;

    final dayAbbr = DateFormat.E().format(day); // e.g., Mon
    final dayNum = day.day.toString();

    final bgColor = isSelected
        ? kPrimaryColor
        : isToday
        ? kPrimaryColor
        : kGreyWhiteColor;

    final textColor = isSelected || isToday ? Colors.white : Colors.black;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50.w,
          // height: 80.h,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dayAbbr, style: TextStyle(color: textColor, fontSize: 12.sp)),
                 Spacing.h4,
                Text(dayNum, style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Spacing.h4,
        if (hasTask)
          Container(
            width: 6.w,
            height: 6.w,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }


}
