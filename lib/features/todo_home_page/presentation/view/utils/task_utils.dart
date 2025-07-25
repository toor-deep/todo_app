
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/design-system/app_colors.dart';

enum TaskPriority {
  high,
  medium,
  low,
}
extension GetColor on TaskPriority{
  Color get getColor {
    switch (this) {
      case TaskPriority.high:
        return  kRedColor;
      case TaskPriority.medium:
        return kYellowColor;
      case TaskPriority.low:
        return kGreenAccent;
    }
  }

}

extension GetPriorityEnum on String{
  TaskPriority? get getPriority {
    switch (this) {
      case "High Priority":
        return TaskPriority.high;
      case "Medium Priority":
        return TaskPriority.medium;
      case "Low Priority":
        return TaskPriority.low;
      default:
        return null;
    }
  }
}

extension GetPriorityIcon on TaskPriority {
  IconData get getIcon {
    switch (this) {
      case TaskPriority.high:
        return Icons.warning;
      case TaskPriority.medium:
        return CupertinoIcons.time;
      case TaskPriority.low:
        return Icons.check_box;
    }
  }
}