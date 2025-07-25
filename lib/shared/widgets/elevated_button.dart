import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../design-system/styles.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? radius;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? widget;
  final double? height;
  final double? width;

  const AppElevatedButton({
    super.key,
    this.widget,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.height,
    this.width,
    this.radius =8,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?? 48.h,
      width: width?? double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 24),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 24),
          ),
        ),
        onPressed: onPressed,
        child:
            widget ??
            Text(
              text,
              style:
                  textStyle ??
                  TextStyles.inter14Semi.copyWith(color: Colors.white),
            ),
      ),
    );
  }
}
