import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/shared/app_constants.dart';
import 'package:todo/shared/widgets/elevated_button.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime selectedDate) onNext;

  const DatePickerBottomSheet({
    super.key,
    this.initialDate,
    required this.onNext,
  });

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 39.h),
            Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timelapse),
                Text(
                  "Select Due Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacing.h16,
            Divider(color: kContainerBgColor),
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: _selectedDate,
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, _) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(8),
                ),

                selectedDecoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Spacing.h20,
            Row(
              spacing: 24.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppElevatedButton(
                    radius: 12,
                    backgroundColor: kContainerBgColor,
                    onPressed: () => Navigator.pop(context),
                    text: "Back",
                    textStyle: TextStyles.inter16Regular.copyWith(
                      color: kGreyDarkColor,
                    ),
                  ),
                ),
                Expanded(
                  child: AppElevatedButton(
                    radius: 12,
                    backgroundColor: kPrimaryColor,
                    textStyle: TextStyles.inter16Regular.copyWith(
                      color: Colors.white,
                    ),
                    text: "Next",
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onNext(_selectedDate);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
