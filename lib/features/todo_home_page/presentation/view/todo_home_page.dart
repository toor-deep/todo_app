import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/shared/app_icons.dart';
import 'package:todo/shared/assets/images.dart';
import 'package:todo/shared/extensions/date_extensions.dart';
import 'package:todo/shared/widgets/elevated_button.dart';

import '../../../../shared/app_constants.dart';
import '../../../../shared/network_provider/network_provider.dart';
import '../../../../shared/widgets/app_outlined_button.dart';
import '../../domain/entity/task_entity.dart';
import 'add_task/add_task_sheet.dart';
import 'add_task/task_item_view.dart';
import 'expandable_button.dart';

class ToDoHomePage extends StatefulWidget {
  static const String path = '/todo-home';
  static const String name = 'todo-home';

  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  List<String> categories = ["To-Do", "Habit", "Journal", "Note"];
  bool isExpanded = false;
  String selected = "To-Do";
  bool isEdit = false;
  late TaskProvider taskProvider;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    taskProvider = context.read<TaskProvider>();
    final connectivityProvider = context.read<ConnectivityProvider>();
    final isConnected = connectivityProvider.isConnected;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isConnected) {
        taskProvider.fetchTasks(userId);
      } else {
        taskProvider.loadLocalTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ExpandableFab(
        onAddTodo: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => NewTodoBottomSheet(),
          );
        },
        onAddNote: () => {},
        onAddJournal: () => {},
        onSetupHabit: () => {},
        onAddList: () => {},
      ),

      body: Consumer<TaskProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Text("Today", style: TextStyles.inter27Semi),
                Spacing.h8,
                Text(
                  DateTime.now().toFormattedString(),
                  style: TextStyles.inter16Regular.copyWith(
                    color: kGreyDarkColor,
                  ),
                ),
                Spacing.h16,
                Card(
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        taskProvider.fetchTasks(userId);
                      }
                      taskProvider.searchTasks(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: kContainerBgColor),
                      hintText: "Search Task",
                      hintStyle: TextStyles.inter14Regular.copyWith(
                        color: kContainerBgColor,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Spacing.h16,
                _buildCategoryButtons(),
                Spacing.h16,
                _listView(value.tasks),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        ...categories.map((label) {
          final bool isSelected = selected == label;

          return isSelected
              ? AppElevatedButton(
                  text: label,
                  onPressed: () {
                    setState(() => selected = label);
                  },
                  textStyle: TextStyles.inter12Regular,
                  width: 76.w,
                  height: 36.h,
                  backgroundColor: kPrimaryColor,
                )
              : AppOutlinedButton(
                  text: label,
                  onPressed: () {
                    setState(() => selected = label);
                  },
                  width: 76.w,
                  height: 36.h,
                  textStyle: TextStyles.inter12Regular.copyWith(
                    color: kGreyDarkColor,
                  ),
                  borderColor: kContainerBgColor,
                );
        }),
        InkWell(
          onTap: () {
            showPriorityFilterBottomSheet(context, (priority) {
              taskProvider.sortTasksByPriority(priority);
            });
          },

          child: AppIcon(AppIcons.filter),
        ),
      ],
    );
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
              padding: EdgeInsets.only(bottom: 20.h),
              child: TaskItemView(
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

  void showPriorityFilterBottomSheet(
    BuildContext context,
    Function(String) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              const Center(
                child: Text(
                  'Select Priority',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'High',
                  style: TextStyles.inter16Regular.copyWith(color: kRedColor),
                ),
                onTap: () {
                  onSelected('High Priority');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Medium',
                  style: TextStyles.inter16Regular.copyWith(
                    color: kYellowColor,
                  ),
                ),
                onTap: () {
                  onSelected('Medium Priority');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Low',
                  style: TextStyles.inter16Regular.copyWith(
                    color: kGreenAccent,
                  ),
                ),
                onTap: () {
                  onSelected('Low Priority');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Clear Filter'),
                onTap: () {
                  onSelected("");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
