import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/features/todo_home_page/presentation/utils/utils.dart';
import 'package:todo/shared/extensions/date_extensions.dart';
import '../../../../../shared/app_constants.dart';
import '../../../../../shared/network_provider/network_provider.dart';
import '../../../../../shared/widgets/elevated_button.dart';
import '../../../../notifications/core.dart';
import '../../../../notifications/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

class AddTaskSuccessDialog {
  static void show({
    required BuildContext context,
    required TaskEntity taskData,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
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
                children: [
                  Icon(Icons.library_add_check, color: kGreyDarkColor),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      taskData.title,
                      style: TextStyles.inter24Semi,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Spacing.h16,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 280.w),
                child: Text(
                  taskData.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyles.inter12Regular.copyWith(
                    color: kLightGreyColor,
                  ),
                ),
              ),
              Spacing.h16,
              Divider(color: kContainerBgColor.withOpacity(0.2)),
              Spacing.h16,
              _buildTaskDetails("Priority", taskData.taskPriority, Icons.flag),
              Spacing.h16,
              _buildTaskDetails(
                "Due Date",
                DateTime.parse(taskData.dueDate).toFormattedString(),
                Icons.calendar_today,
              ),
              Spacing.h16,
              _buildTaskDetails("Time", taskData.dueTime, Icons.access_time),
              Spacing.h16,
              Divider(color: kContainerBgColor.withOpacity(0.2)),
              Spacing.h16,
              _buttonRow(context, taskData),
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
          children: [
            Icon(icon, color: kGreyDarkColor, size: 20),
            SizedBox(width: 8.w),
            Text(label, style: TextStyles.inter18Regular),
          ],
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyles.inter18Regular.copyWith(color: kGreyDarkColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static Widget _buttonRow(BuildContext context, TaskEntity data) {
    final taskProvider = context.read<TaskProvider>();
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
        Consumer<TaskProvider>(
          builder: (context, value, child) {
            return Expanded(
              child: AppElevatedButton(
                radius: 12,
                backgroundColor: kPrimaryColor,
                textStyle: TextStyles.inter16Regular.copyWith(
                  color: Colors.white,
                ),
                widget: value.isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : null,

                text: "Save",
                onPressed: () {
                  final isConnected = context.read<ConnectivityProvider>().isConnected;

                  final scheduledTime = parseDueDateTime(data.dueDate, data.dueTime);

                  if (isConnected) {
                    taskProvider.addTask(
                      TaskEntity(
                        title: data.title,
                        description: data.description,
                        taskPriority: data.taskPriority,
                        dueDate: data.dueDate,
                        dueTime: data.dueTime,
                      ),
                          () async {
                        NotificationService.showLocalNotification(
                          title: '✅ Task Created',
                          body: 'Your new task "${data.title}" has been created!',
                        );
                        await NotificationService.scheduleReminder(
                          title: "Task Reminder",
                          body: "Don't forget to complete your task!",
                          scheduledTime: DateTime.now().add(Duration(minutes: 2)),
                        );
                      },
                    );
                  } else {
                    taskProvider.addLocalTask(
                      TaskEntity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: data.title,
                        description: data.description,
                        taskPriority: data.taskPriority,
                        dueDate: data.dueDate,
                        dueTime: data.dueTime,
                        syncAction: SyncAction.create.name,
                        isSynced: false,
                      ),
                          () async {
                        NotificationService.showLocalNotification(
                          title: '✅ Task Created',
                          body: 'Your new task "${data.title}" has been created!',
                        );
                        await NotificationService.scheduleReminder(
                          title: "Task Reminder",
                          body: "Don't forget to complete your task!",
                          scheduledTime: scheduledTime,
                        );
                      },
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
