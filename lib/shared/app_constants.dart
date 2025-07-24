import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../design-system/styles.dart';

final appNavigationKey = GlobalKey<NavigatorState>();
const kAppName = 'PropertySelling';
final getIt = GetIt.instance;

//Spacings
class Spacing {
  static SizedBox h4 = SizedBox(height: 4.h);
  static SizedBox h2 = SizedBox(height: 2.h);
  static SizedBox h6 = SizedBox(height: 6.h);
  static SizedBox h8 = SizedBox(height: 8.h);
  static SizedBox h9 = SizedBox(height: 9.h);
  static SizedBox h10 = SizedBox(height: 10.h);
  static SizedBox h12 = SizedBox(height: 12.h);
  static SizedBox h13 = SizedBox(height: 13.h);
  static SizedBox h14 = SizedBox(height: 14.h);
  static SizedBox h15 = SizedBox(height: 15.h);
  static SizedBox h16= SizedBox(height: 16.h);
  static SizedBox h17= SizedBox(height: 17.h);
  static SizedBox h18= SizedBox(height: 18.h);
  static SizedBox h20= SizedBox(height: 20.h);
  static SizedBox h24 = SizedBox(height: 24.h);
  static SizedBox h28 = SizedBox(height: 28.h);

  static SizedBox w4 = SizedBox(width: 4.w);
  static SizedBox w6 = SizedBox(width: 6.w);
  static SizedBox w8 = SizedBox(width: 8.w);
  static SizedBox w9 = SizedBox(width: 9.w);
  static SizedBox w10 = SizedBox(width: 10.w);
  static SizedBox w12= SizedBox(width: 12.w);
  static SizedBox w14= SizedBox(width: 14.w);
  static SizedBox w16 = SizedBox(width: 16.w);
  static SizedBox w17 = SizedBox(width: 17.w);
  static SizedBox w18 = SizedBox(width: 18.w);
  static SizedBox w20 = SizedBox(width: 20.w);
  static SizedBox w24 = SizedBox(width: 24.w);
  static SizedBox w28 = SizedBox(width: 28.w);
}

// Padding
class AppPadding {
  static contentPadding() {
    return const EdgeInsets.all(12.0);
  }

  static EdgeInsets horizontalPadding() {
    return const EdgeInsets.symmetric(horizontal: 24.0);
  }
}

// Color schemes
final shiftColors = [
  const Color(0xFFFFA185),
  const Color(0xFFC3CD70),
  const Color(0xFF2AAC9F),
  const Color(0xFF848CB8),
  const Color(0xFFB75779),
  const Color(0xFFE86969),
  const Color(0xFFB4978D),
  const Color(0xFFDFB16D),
  const Color(0xFFAACB89),
  const Color(0xFF18B4C9),
  const Color(0xFFAE99D1),
  const Color(0xFFE16B92),
  const Color(0xFFF3766D),
  const Color(0xFFCDAC8B),
  const Color(0xFFE2BE50),
  const Color(0xFF74B976),
  const Color(0xFF4FB1DE),
  const Color(0xFFBD84C8),
  const Color(0xFFF184AB),
  const Color(0xFF6EA9DB),
  const Color(0xFFF0957A),
  const Color(0xFFD2B97F),
  const Color(0xFF85C187),
  const Color(0xFF7BBBEA),
  const Color(0xFFD39CDD),
  const Color(0xFFF7817B),
  const Color(0xFF84B3CD),
];

final colorSchemes = [
  const Color(0xFFFFA185),
  const Color(0xFFC3CD70),
  const Color(0xFF2AAC9F),
  const Color(0xFF848CB8),
  const Color(0xFFB75779),
  const Color(0xFFE86969),
  const Color(0xFFB4978D),
  const Color(0xFFDFB16D),
  const Color(0xFFAACB89),
  const Color(0xFF18B4C9),
  const Color(0xFFAE99D1),
  const Color(0xFFE16B92),
  const Color(0xFFF3766D),
  const Color(0xFFCDAC8B),
  const Color(0xFFE2BE50),
  const Color(0xFF74B976),
  const Color(0xFF4FB1DE),
  const Color(0xFFBD84C8),
  const Color(0xFFF184AB),
  const Color(0xFF6EA9DB),
  const Color(0xFFF0957A),
  const Color(0xFFD2B97F),
  const Color(0xFF85C187),
  const Color(0xFF7BBBEA),
  const Color(0xFFD39CDD),
  const Color(0xFFF7817B),
  const Color(0xFF84B3CD),
];

String colorToHex(Color color, {bool leadingHashSign = true}) {
  return '${leadingHashSign ? '#' : ''}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}