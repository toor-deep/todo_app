import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/shared/app_icons.dart';
import 'package:todo/shared/widgets/circular_button.dart';
import 'package:todo/shared/widgets/elevated_button.dart';

import '../../../../shared/app_constants.dart';
import '../../../../shared/widgets/app_outlined_button.dart';
import 'add_task/add_task_sheet.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(
        onAddTodo: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const NewTodoBottomSheet(),
          );

        },
        onAddNote: () => print("Add Note"),
        onAddJournal: () => print("Add Journal"),
        onSetupHabit: () => print("Setup Habit"),
        onAddList: () => print("Setup Dashboard"),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Text("Today", style: TextStyles.inter27Semi),
            Spacing.h8,
            Text(
              "Mon 20 March 2024",
              style: TextStyles.inter16Regular.copyWith(color: kGreyDarkColor),
            ),
            Spacing.h16,
            Card(
              child: TextFormField(
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
          ],
        ),
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
        AppIcon(AppIcons.filter),
      ],
    );
  }

}
