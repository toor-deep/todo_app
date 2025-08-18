import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../shared/app_constants.dart';
import '../../../../shared/assets/images.dart';
import '../../../../shared/network_provider/network_provider.dart';
import '../../../todo_home_page/domain/entity/task_entity.dart';
import '../../../todo_home_page/presentation/provider/task_provider.dart';
import '../../../todo_home_page/presentation/view/add_task/all_tasks_calendar.dart';
import '../../../todo_home_page/presentation/view/add_task/task_item_view.dart';

class CalendarView extends StatefulWidget {
  static const String path = '/date-tasks';
  static const String name = 'date-tasks';

  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late TaskProvider taskProvider;

  String selectedDate = DateTime.now().toString();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isConnected = false;

  @override
  void initState() {
    taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final connectivityProvider = context.read<ConnectivityProvider>();
     isConnected = connectivityProvider.isConnected;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isConnected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          taskProvider.fetchTasksByDate(selectedDate);
        });
      } else {
        taskProvider.getTasksByDate(selectedDate);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Spacing.h20,

                AllTasksCalendarScreen(
                  selectedDay: DateTime.now(),
                  tasks: value.tasksOfDate,
                  onDateChanged: (date) {
                    setDate(date);
                  },
                ),

                _listView(value.tasksOfDate),
              ],
            )
          ),
        );
      },
    );
  }

  void setDate(DateTime date) {
    setState(() {
      selectedDate = date.toString();
      if(isConnected){
        taskProvider.fetchTasksByDate(selectedDate);
      } else {
        taskProvider.getTasksByDate(selectedDate);
      }
    });
  }

  Widget _listView(List<TaskEntity> items) {
    if (items.isEmpty) {
      return Center(child: Image.asset(AppImages.empty));
    }
    return Expanded(
      child: Skeletonizer(
        enabled: false,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 20.h,left: 16.w,right: 16.w),
              child: TaskItemView(
                isCalendarViewItem: true,
                onEdit: (data) {},
                taskData: TaskEntity(
                  isCompleted: item.isCompleted,
                  title: item.title,
                  id: item.id,
                  description: item.description,
                  dueTime: item.dueTime,
                  dueDate: item.dueDate,
                  taskPriority: item.taskPriority,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
