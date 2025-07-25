import 'package:flutter/material.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/view/add_task/sub_widgets/time_slot_picker.dart';
import '../../../../../../design-system/app_colors.dart';
import '../../../../../../shared/app_constants.dart';
import 'date_picker.dart';

class BottomActions extends StatefulWidget {
  const BottomActions({super.key});

  @override
  State<BottomActions> createState() => _BottomActionsState();
}

class _BottomActionsState extends State<BottomActions> {
  DateTime? _selectedDate;
  String? _selectedTime;

  void _showPriorityMenu(BuildContext context, Offset offset) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        _buildMenuItem("High Priority", kRedColor, Icons.warning),
        _buildMenuItem("Medium Priority", kYellowColor, Icons.circle),
        _buildMenuItem("Low Priority", kGreenAccent, Icons.check_box),
      ],
    );

    if (result != null) {
      print("Selected Priority: $result");
    }
  }

  PopupMenuItem<String> _buildMenuItem(String label, Color color, IconData icon) {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (ctx) => DatePickerBottomSheet(
                    onNext: (selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                      print("Due Date: $_selectedDate");
                    },
                  ),
                );
              },
              child: Icon(Icons.calendar_month, color: kGreyDarkColor),
            ),
            Spacing.w12,
            GestureDetector(
              onTap: () {
                if (_selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a date first.")),
                  );
                  return;
                }

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => TimeSlotPickerBottomSheet(
                    selectedDate: _selectedDate!,
                    onNext: (selectedTime) {
                      setState(() {
                        _selectedTime = selectedTime;
                      });
                      print("Selected Time: $_selectedTime");
                    },
                  ),
                );
              },
              child: Icon(Icons.timelapse, color: kGreyDarkColor),
            ),
            Spacing.w12,
            Builder(
              builder: (ctx) {
                return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showPriorityMenu(ctx, details.globalPosition);
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
            print("Date: $_selectedDate, Time: $_selectedTime");
          },
          icon: Icon(Icons.send, color: kPrimaryColor),
        ),
      ],
    );
  }
}
