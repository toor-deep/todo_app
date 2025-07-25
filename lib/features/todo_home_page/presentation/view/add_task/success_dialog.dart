import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';

import '../../../../../shared/app_constants.dart';
import '../../../../../shared/widgets/elevated_button.dart';

class AddTaskSuccessDialog {
  static void show({
    required BuildContext context,
    required TaskData taskData,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Preview', style: TextStyles.inter18Semi),
              Spacing.h8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.w,
                children: [
                  Icon(Icons.library_add_check, color: kGreyDarkColor),
                  Text("Interview with Alex", style: TextStyles.inter24Semi),
                ],
              ),
              Spacing.h16,
              Text(textAlign: TextAlign.center,
                "Plan questions, capture insights, and document key takeaways.",
                style: TextStyles.inter12Regular.copyWith(
                  color: kLightGreyColor,
                ),
              ),
              Spacing.h16,
              Divider(color: kContainerBgColor.withValues(alpha: 0.2)),
              Spacing.h16,
              _buildTaskDetails("Priority", taskData.taskPriority, Icons.flag),
              Spacing.h16,
              _buildTaskDetails("Due Date", taskData.taskDate, Icons.calendar_today),
              Spacing.h16,
              _buildTaskDetails("Time", taskData.taskTime, Icons.access_time),
              Spacing.h16,
              Divider(color: kContainerBgColor.withValues(alpha: 0.2)),
              Spacing.h16,

              _buttonRow(context),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTaskDetails(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 4.w,
          children: [
            Icon(icon, color: kGreyDarkColor, size: 20),
            Text(label, style: TextStyles.inter18Regular),
          ],
        ),
        Text(
          value,
          style: TextStyles.inter18Regular.copyWith(color: kGreyDarkColor),
        ),
      ],
    );
  }

  static Widget _buttonRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppElevatedButton(
            radius: 12,
            backgroundColor: kContainerBgColor,
            onPressed: () => Navigator.pop(context),
            text: "Back",
            textStyle: TextStyles.inter16Regular.copyWith(color: kPrimaryColor),
          ),
        ),
        Spacing.w16,
        Expanded(
          child: AppElevatedButton(
            radius: 12,
            backgroundColor: kPrimaryColor,
            textStyle: TextStyles.inter16Regular.copyWith(color: Colors.white),
            text: "Save",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}

class TaskData{
  final String taskName;
  final String taskDescription;
  final String taskPriority;
  final String taskDate;
  final String taskTime;
  final bool isCompleted;

  TaskData({
    required this.taskPriority,
    required this.taskDate,
    required this.taskName,
    required this.taskDescription,
    required this.taskTime,
     required this.isCompleted,
  });
}
