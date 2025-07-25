import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/shared/widgets/elevated_button.dart';
import 'package:todo/shared/widgets/app_outlined_button.dart';

import '../../../../shared/app_constants.dart';

class ExpandableFab extends StatefulWidget {
  final VoidCallback onAddTodo;
  final VoidCallback onAddNote;
  final VoidCallback onAddJournal;
  final VoidCallback onSetupHabit;
  final VoidCallback onAddList;

  const ExpandableFab({
    super.key,
    required this.onAddTodo,
    required this.onAddNote,
    required this.onAddJournal,
    required this.onSetupHabit,
    required this.onAddList,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> {
  bool _isOpen = false;

  void _closeMenu() {
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isOpen)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppOutlinedButton(
                  text: "Setup Journal",
                  onPressed: () {
                    widget.onAddJournal();
                    _closeMenu();
                  },
                  height: 36.h,
                  width: double.infinity,
                  borderColor: kPrimaryColor,
                  textStyle: TextStyle(fontSize: 13, color: kPrimaryColor),
                ),
                Spacing.h10,
                AppOutlinedButton(
                  text: "Setup Habit",
                  onPressed: () {
                    widget.onSetupHabit();
                    _closeMenu();
                  },
                  height: 36.h,
                  width: double.infinity,
                  borderColor: kPrimaryColor,
                  textStyle: TextStyle(fontSize: 13, color: kPrimaryColor),
                ),
                Spacing.h10,

                AppElevatedButton(
                  text: "Add List",
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    widget.onAddList();
                    _closeMenu();
                  },
                  height: 36.h,
                  // width: double.infinity,
                  textStyle: TextStyle(fontSize: 13),
                ),
                Spacing.h10,

                AppElevatedButton(
                  text: "Add Note",
                  backgroundColor: kPrimaryColor,

                  onPressed: () {
                    widget.onAddNote();
                    _closeMenu();
                  },
                  height: 36.h,
                  // width: double.infinity,
                  textStyle: TextStyle(fontSize: 13),
                ),
                Spacing.h10,
                AppElevatedButton(
                  text: "Add Todo",
                  backgroundColor: kPrimaryColor,

                  onPressed: () {
                    widget.onAddTodo();
                    _closeMenu();
                  },
                  height: 36.h,
                  // width: double.infinity,
                  textStyle: TextStyle(fontSize: 13),
                ),
                Spacing.h10,
              ],
            ),
          FloatingActionButton(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_isOpen ? 8 : 50),
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            onPressed: () => setState(() => _isOpen = !_isOpen),
            backgroundColor: kPrimaryColor,
            child: Icon(_isOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
    );
  }
}
