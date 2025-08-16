import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/features/todo_home_page/presentation/view/add_task/success_dialog.dart';
import 'package:todo/features/todo_home_page/presentation/view/utils/task_utils.dart';
import 'package:todo/shared/widgets/elevated_button.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/app_constants.dart';
import '../../../../../shared/network_provider/network_provider.dart';
import '../../../domain/entity/task_entity.dart';

class TaskItemView extends StatelessWidget {
  final TaskEntity taskData;
  final bool? isCalendarViewItem;
  final Function(bool) onEdit;

  const TaskItemView({Key? key, required this.taskData,this.isCalendarViewItem, required this.onEdit}) : super(key: key);

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
    return Skeleton.leaf(
      enabled: true,
      child: Container(
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

                ],
              ),
              InkWell(
                onTapDown: (TapDownDetails details) {
                  _showPopupMenu(context, details.globalPosition);
                },
                child: Icon(Icons.more_horiz, color: Colors.white),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _column() {
    final parsedDate = DateTime.parse(taskData.dueDate);
    final formattedDate = DateFormat('EEE, dd MMM yyyy').format(parsedDate);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(),
          Spacing.h8,
          Text(
            taskData.description,
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
                  Text(taskData.dueTime, style: TextStyles.inter13Regular),
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
              Skeleton.leaf(
                child: Container(
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
              ),
              Spacing.w8,
              Expanded(
                child: Text(
                  taskData.title,
                  style: TextStyles.inter18Semi.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Skeleton.leaf(
          child: AppElevatedButton(
            height: 26.h,
            width: 78.w,
            radius: 50,
            textStyle: TextStyles.inter12Regular.copyWith(color: Colors.white),
            text: taskData.isCompleted ? "Completed" : "To-Do",
            onPressed: () {},
            backgroundColor: taskData.isCompleted ? kGreenAccent : kBlueColor,
          ),
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
          child: InkWell(
            onTap: (){
              final taskProvider = context.read<TaskProvider>();
              final isConnected = context.read<ConnectivityProvider>().isConnected;
              if(isConnected){

              taskProvider.deleteTask(taskData.id??"",isCalendarViewItem??false);}
              else{
                taskProvider.deleteLocalTask(taskData.id??"", isCalendarView: isCalendarViewItem??false);
              }
              context.pop();
            },
            child: Row(
              children: [
                Icon(CupertinoIcons.delete, color: kRedColor,size: 16,),
                Spacing.w8,
                Text('Delete'),
              ],
            ),
          ),
        ),
      ],
    );

    if (selected == 'edit') {
    } else if (selected == 'delete') {
    }
  }


}


