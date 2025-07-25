import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../shared/app_constants.dart';
import '../add_task/all_tasks_calendar.dart';
import '../add_task/success_dialog.dart';
import '../add_task/task_item_view.dart';

class DateTasks extends StatelessWidget {
  static const String path = '/date-tasks';
  static const String name = 'date-tasks';
  final String date;

  const DateTasks({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacing.h20,

            AllTasksCalendarScreen(),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: TaskItemView(
                      onEdit: (data) {
                        // Handle edit
                      },
                      taskData: TaskData(
                        isCompleted: false,
                        taskName: "Task ${index + 1}",
                        taskDescription:
                        "This is the description for task ${index + 1}.",
                        taskTime: "10:00 AM",
                        taskDate: "2024-03-20",
                        taskPriority: 'Medium Priority',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
