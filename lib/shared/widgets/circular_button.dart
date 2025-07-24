import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final BoxBorder? border;

  const CircularIconButton({
    Key? key,
    required this.icon,
    this.size = 49,
    this.iconSize = 14,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
