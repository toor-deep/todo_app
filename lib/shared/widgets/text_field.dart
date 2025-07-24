import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../design-system/app_colors.dart';
import '../../design-system/styles.dart';
import '../app_constants.dart';

class TextFieldClass extends StatelessWidget {
  final String label;
  final bool? isPassword;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextStyle? style;
  final int? maxLines;

  const TextFieldClass({
    super.key,
    required this.label,
    this.isPassword,
    this.validator,
    this.controller,
    this.style,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTextField(label, isPassword: isPassword ?? false);
  }

  Widget _buildTextField(String label, {bool isPassword = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty) ...[
        Text(
          label,
          style:
              style ?? TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),
      ],
      Spacing.h2,
      Container(
        constraints: BoxConstraints(minHeight: 46.h),
        // padding: EdgeInsets.symmetric(vertical: 8.h),
        child: TextFormField(
          validator: validator,
          controller: controller,
          style: TextStyles.inter12Regular,
          minLines: 1,
          maxLines: maxLines ?? 1,
          textAlignVertical: TextAlignVertical.top,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorStyle: TextStyles.inter12Regular.copyWith(color: Colors.red),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 12.w,
            ),
            suffixIcon: isPassword
                ? Icon(Icons.visibility_off, color: kGreyDarkColor)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kContainerBgColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kContainerBgColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kLightPrimaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),

              borderSide: BorderSide(color: kGreyDarkColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kLightPrimaryColor),
            ),
          ),
        ),
      ),
    ],
  );
}
