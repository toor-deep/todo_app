import 'package:flutter/material.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';

class InputFields extends StatelessWidget {
  const InputFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'eg : Meeting with client',
            border: InputBorder.none,
            hintStyle: TextStyles.inter16Regular.copyWith(
              color: kLightGreyColor,
            ),
          ),
          style: TextStyles.inter16Regular,
          keyboardType: TextInputType.text,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Description',
            border: InputBorder.none,
            hintStyle: TextStyles.inter16Regular.copyWith(
              color: kLightGreyColor,
            ),
          ),
          style: TextStyles.inter16Regular,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
