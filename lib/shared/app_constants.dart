import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';


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

