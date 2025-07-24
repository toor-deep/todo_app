import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIcons {
logo,home,bell,calendar,user,orangelogo
}

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final double? height;
  final double? width;
  final Color? color;
  final Color? colorFilter;

  const AppIcon(this.icon,
      {super.key, this.size = 20, this.height,this.width,this.color, this.colorFilter});

  @override
  Widget build(BuildContext context) {
    String i = icon.name;
    String path = 'assets/icons/$i.svg';

    return SizedBox(
      width: width?? size,
      height:height?? size,
      child: SvgPicture.asset(
        path,
        width: size,
        height: size,
        color: color,
        fit: BoxFit.contain,
        colorFilter: colorFilter == null
            ? null
            : ColorFilter.mode(colorFilter!, BlendMode.srcIn),
      ),
    );
  }
}
