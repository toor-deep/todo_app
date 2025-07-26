import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/shared/widgets/elevated_button.dart';
import 'package:todo/shared/app_constants.dart';

import 'package:intl/intl.dart';

import 'bottom_icons.dart';

class TimeSlotPickerBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String selectedTime) onNext;

  const TimeSlotPickerBottomSheet({
    super.key,
    required this.selectedDate,
    required this.onNext,
  });

  @override
  State<TimeSlotPickerBottomSheet> createState() =>
      _TimeSlotPickerBottomSheetState();
}

class _TimeSlotPickerBottomSheetState extends State<TimeSlotPickerBottomSheet> {
  String? _selectedTime;
  String? _confirmedTime;
  bool _use24hFormat = false;

  List<DateTime> _generateTimeSlots() {
    final List<DateTime> slots = [];
    DateTime start = DateTime(0, 0, 0, 9, 30);
    for (int i = 0; i < 9; i++) {
      slots.add(start);
      start = start.add(Duration(minutes: 30));
    }
    return slots;
  }

  String _formatTime(DateTime time) {
    return _use24hFormat
        ? DateFormat.Hm().format(time)
        : DateFormat.jm().format(time);
  }

  @override
  Widget build(BuildContext context) {
    final slots = _generateTimeSlots();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      _weekday(widget.selectedDate.weekday),
                      style: TextStyles.inter16Bold,
                    ),

                    Spacing.h4,
                    Text(_formattedDate(widget.selectedDate)),
                  ],
                ),
                SizedBox(width: 42.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() => _use24hFormat = false);
                      },
                      child: Container(
                        height: 29.h,
                        width: 53.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          color: _use24hFormat ? Colors.white : kPrimaryColor,
                          border: Border.all(
                            color: _use24hFormat
                                ? kContainerBgColor
                                : kPrimaryColor,
                          ),
                        ),
                        child: Text(
                          "12h",
                          style: TextStyle(
                            color: _use24hFormat ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() => _use24hFormat = true);
                      },
                      child: Container(
                        height: 29.h,
                        width: 53.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: _use24hFormat ? kPrimaryColor : Colors.white,
                          border: Border.all(
                            color: _use24hFormat
                                ? kPrimaryColor
                                : kContainerBgColor,
                          ),
                        ),
                        child: Text(
                          "24h",
                          style: TextStyle(
                            color: _use24hFormat ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: kContainerBgColor),

            Spacing.h16,
            _timeZone(),
            Spacing.h16,
            Divider(color: kContainerBgColor),

            _listView(slots),

            Spacing.h24,
            Row(
              children: [
                Expanded(
                  child: AppElevatedButton(
                    radius: 12,
                    backgroundColor: kContainerBgColor,
                    onPressed: () => Navigator.pop(context),
                    text: "Back",
                    textStyle: TextStyles.inter16Regular.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Spacing.w16,
                Expanded(
                  child: AppElevatedButton(
                    radius: 12,
                    backgroundColor: kPrimaryColor,
                    textStyle: TextStyles.inter16Regular.copyWith(
                      color: Colors.white,
                    ),
                    text: "Next",
                    onPressed: () {
                      if(_confirmedTime==null) return;

                      widget.onNext(_confirmedTime!);



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

  Widget _confirm(String time) {
    return Row(
      children: [
        Expanded(
          child: AppElevatedButton(
            radius: 10,
            backgroundColor: kLightBlackColor,
            onPressed: () => Navigator.pop(context),
            text: time,
            textStyle: TextStyles.inter16Regular.copyWith(color: Colors.white),
          ),
        ),
        Spacing.w16,
        Expanded(
          child: AppElevatedButton(
            radius: 10,
            backgroundColor: kPrimaryColor,
            textStyle: TextStyles.inter16Regular.copyWith(color: Colors.white),
            text: "Confirm",
            onPressed: () {
              setState(() {
                _confirmedTime = time;
                _selectedTime = time;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _timeZone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, color: kGreyDarkColor, size: 14),
        Spacing.w4,
        Text(
          "Indian Standard Time (UTC+05:30)",
          style: TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),

        Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 14,
          color: kGreyDarkColor,
        ),
      ],
    );
  }

  String _formattedDate(DateTime date) {
    return "${_month(date.month)} ${date.day}, ${date.year}";
  }

  String _weekday(int weekday) {
    return [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ][weekday - 1];
  }

  String _month(int month) {
    return [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ][month - 1];
  }

  Widget _listView(List<DateTime> slots) {
    return ListView.builder(
      itemCount: slots.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final time = _formatTime(slots[index]);
        final isSelected = _selectedTime == time;
        final isConfirmed = _confirmedTime == time;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
          child: Column(
            children: [
              if (isSelected && !isConfirmed)
                _confirm(time)
              else if (isConfirmed)
                Container(
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kLightGreyColor),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                      _confirmedTime = null;
                    });
                  },
                  child: Container(
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kContainerBgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kLightGreyColor),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
