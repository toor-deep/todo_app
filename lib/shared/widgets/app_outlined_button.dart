import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../design-system/styles.dart';

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? radius;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? widget;

  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.radius = 8,
    this.height,
    this.width,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? double.minPositive, // allow flexibility in Row/Wrap
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        onPressed: onPressed,
        child: widget ??
            Text(
              text,
              style: textStyle ??
                  TextStyles.inter14Semi.copyWith(
                    color: textColor ?? Colors.black,
                  ),
            ),
      ),
    );
  }
}
