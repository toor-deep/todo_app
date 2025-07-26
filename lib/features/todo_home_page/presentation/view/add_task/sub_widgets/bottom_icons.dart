import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/features/todo_home_page/presentation/view/add_task/sub_widgets/time_slot_picker.dart';
import 'package:todo/shared/toast_alert.dart';
import '../../../../../../design-system/app_colors.dart';
import '../../../../../../shared/app_constants.dart';
import '../../../../domain/entity/task_entity.dart';
import '../success_dialog.dart';
import 'date_picker.dart';

class BottomActions extends StatefulWidget {
  const BottomActions({super.key});

  @override
  State<BottomActions> createState() => _BottomActionsState();
}

class _BottomActionsState extends State<BottomActions> {
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (ctx) => DatePickerBottomSheet(
                      onNext: (selectedDate) {
                        setState(() {
                          _selectedDate = selectedDate;
                        });
                        showTimeDialog();
                      },
                    ),
                  );
                },
                child: Icon(Icons.calendar_month, color: kGreyDarkColor),
              ),
              Spacing.w12,
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  if (_selectedDate == null) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a date first.")),
                    );
                    return;
                  }

                  showTimeDialog();
                },
                child: Icon(Icons.timelapse, color: kGreyDarkColor),
              ),
              Spacing.w12,

              Builder(
                builder: (ctx) {
                  return GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      FocusScope.of(context).unfocus();

                      final selectedPriority = await showMenu<String>(
                        context: ctx,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          0,
                          0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        items: [
                          buildMenuItem(
                            "High Priority",
                            kRedColor,
                            Icons.warning,
                          ),
                          buildMenuItem(
                            "Medium Priority",
                            kYellowColor,
                            Icons.circle,
                          ),
                          buildMenuItem(
                            "Low Priority",
                            kGreenAccent,
                            Icons.check_box,
                          ),
                        ],
                      );

                      if (selectedPriority != null) {
                        setState(() {
                          _selectedPriority = selectedPriority;
                        });
                      }
                    },
                    child: Icon(Icons.flag, color: kGreyDarkColor),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              final provider = context.read<TaskProvider>();

              if (_selectedDate == null) {
                context.pop();
                showSnackbar("Please select a date");

                return;
              }

              if (_selectedTime == null) {
                context.pop();
                showSnackbar("Please select a time");

                return;
              }

              if (provider.titleController.text.isEmpty) {
                context.pop();
                showSnackbar("Please enter title");

                return;
              }

              if (provider.descriptionController.text.isEmpty) {
                context.pop();
                showSnackbar("Please enter description");

                return;
              }

              if (_selectedPriority == null) {
                context.pop();
                showSnackbar("Please select a priority");
                return;
              }

              context.pop();
              AddTaskSuccessDialog.show(
                context: context,
                taskData: TaskEntity(
                  title: provider.titleController.text,
                  description: provider.descriptionController.text,
                  dueDate: _selectedDate!.toIso8601String().split('T').first,
                  dueTime: _selectedTime ?? "",
                  taskPriority: _selectedPriority!,
                ),
              );
            },
            icon: Icon(Icons.send, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }

  void showTimeDialog() {
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TimeSlotPickerBottomSheet(
        selectedDate: _selectedDate!,
        onNext: (selectedTime) {
          setState(() {
            _selectedTime = selectedTime;
          });
          Navigator.of(context).pop(true);
        },
      ),
    ).then((value) {
      if (value == true) {

        Future.delayed(const Duration(milliseconds: 200), () async {
          final selectedPriority = await showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(100, 200, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            items: [
              buildMenuItem("High Priority", kRedColor, Icons.warning),
              buildMenuItem("Medium Priority", kYellowColor, Icons.circle),
              buildMenuItem("Low Priority", kGreenAccent, Icons.check_box),
            ],
          );

          if (selectedPriority != null) {
            setState(() {
              _selectedPriority = selectedPriority;
            });
          }

          context.pop();
        });
      }
    });
  }
}

PopupMenuItem<String> buildMenuItem(String label, Color color, IconData icon) {
  return PopupMenuItem<String>(
    value: label,
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        Spacing.w10,
        Text(label, style: TextStyles.inter16Regular.copyWith(color: color)),
      ],
    ),
  );
}
