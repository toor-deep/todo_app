import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';
import 'package:todo/features/todo_home_page/presentation/view/utils/task_utils.dart';

import '../../../../../shared/app_constants.dart';

class AllTasksCalendarScreen extends StatefulWidget {
  final DateTime? selectedDay;
  final Function(DateTime) onDateChanged;
  final List<TaskEntity> tasks;

  const AllTasksCalendarScreen({
    Key? key,
    required this.onDateChanged,
    required this.tasks,
    this.selectedDay,
  }) : super(key: key);

  @override
  State<AllTasksCalendarScreen> createState() => _AllTasksCalendarScreenState();
}

class _AllTasksCalendarScreenState extends State<AllTasksCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    if (widget.selectedDay != null) {
      _selectedDay = widget.selectedDay;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('dd MMMM yyyy').format(_selectedDay ?? _focusedDay),
              style: TextStyles.inter18Semi
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
      rowHeight: 100.h,
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
          widget.onDateChanged(_selectedDay ?? DateTime.now());
        });
      },
      daysOfWeekVisible: false,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: TextStyle(fontSize: 14.sp),
        todayDecoration:  BoxDecoration(
          color: isSameDay(_selectedDay, DateTime.now())? kPrimaryColor : kContainerBgColor,
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

  Widget _buildDayCell(
    DateTime day, {
    bool isSelected = false,
    bool isToday = false,
  }) {
    final dayAbbr = DateFormat.E().format(day);
    final dayNum = day.day.toString();
    final shouldHighlightAsToday = isToday && !isSelected;

    final bgColor = isSelected
        ? kPrimaryColor
        : shouldHighlightAsToday
        ? kContainerBgColor
        : kGreyWhiteColor;

    final textColor = isSelected || shouldHighlightAsToday
        ? Colors.white
        : Colors.black;

    return SizedBox(
      height: 120.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayAbbr,
                  style: TextStyle(color: textColor, fontSize: 12.sp),
                ),
                Spacing.h4,
                Text(
                  dayNum,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacing.h4,

          if (isSameDay(day, _selectedDay)) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.tasks.take(5)
                  .map(
                    (task) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color:
                            task.taskPriority.getPriority?.getColor ??
                            Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
