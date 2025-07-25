import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/view/add_task/success_dialog.dart';
import 'package:todo/features/todo_home_page/presentation/view/utils/task_utils.dart';
import 'package:todo/shared/widgets/elevated_button.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/app_constants.dart';

class TaskItemView extends StatelessWidget {
  final TaskData taskData;
  final Function(bool) onEdit;

  const TaskItemView({Key? key, required this.taskData, required this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(children: [_container(context), _column()]),
      ),
    );
  }

  Widget _container(BuildContext context) {
    return Container(
      height: 41.h,

      decoration: BoxDecoration(
        color: taskData.taskPriority.getPriority?.getColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4.w,
              children: [
                Icon(Icons.flag_outlined, color: Colors.white, size: 16),
                Text(
                  taskData.taskPriority,
                  style: TextStyles.inter12Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
                // Icon(
                //   taskData.taskPriority.getPriority?.getIcon,
                //   size: 16,
                // ),
              ],
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(context, details.globalPosition);
              },
              child: Icon(Icons.more_horiz, color: Colors.white),
            )

          ],
        ),
      ),
    );
  }

  Widget _column() {
    final parsedDate = DateTime.parse(taskData.taskDate); // your string must be in ISO 8601 format
    final formattedDate = DateFormat('EEE, dd MMM yyyy').format(parsedDate);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          _row(),
          Spacing.h8,
          Text(
            "Plan questions, capture insights, and document key takeaways.",
            style: TextStyles.inter12Regular.copyWith(color: kLightGreyColor),
          ),
          Spacing.h12,
          Divider(
            color: kContainerBgColor.withValues(alpha: 0.2),
          ),
          Spacing.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 4.w,
                children: [
                  Icon(Icons.timer_sharp, color: kGreyDarkColor, size: 20),
                  Text(taskData.taskTime, style: TextStyles.inter13Regular),
                ],
              ),
              Text(
                formattedDate,
                style: TextStyles.inter13Regular.copyWith(color: kGreyDarkColor),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: taskData.taskPriority.getPriority!.getColor,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 6.h,
                  width: 6.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: taskData.taskPriority.getPriority?.getColor,
                  ),
                ),
              ),
              Spacing.w8,
              Expanded(
                child: Text(
                  taskData.taskName,
                  style: TextStyles.inter18Semi.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        AppElevatedButton(
          height: 26.h,
          width: 78.w,
          radius: 50,
          textStyle: TextStyles.inter12Regular.copyWith(color: Colors.white),
          text: taskData.isCompleted ? "Completed" : "To-Do",
          onPressed: () {},
          backgroundColor: taskData.isCompleted ? kGreenAccent : kBlueColor,
        ),
      ],
    );
  }

  void _showPopupMenu(BuildContext context, Offset position) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'edit',
          child: InkWell(
            onTap: () {
              onEdit(true);
            },
            child: Row(
              children: [
                Icon(Icons.edit, color: kRedColor,size: 16,),
                Spacing.w8,
                Text('Edit'),
              ],
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(CupertinoIcons.delete, color: kRedColor,size: 16,),
              Spacing.w8,
              Text('Delete'),
            ],
          ),
        ),
      ],
    );

    if (selected == 'edit') {
    } else if (selected == 'delete') {
    }
  }


}


