import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class Sizes {
  static double hitScale = 1;

  static double get hit => 20 * hitScale;
}

class IconSizes {
  static const double scale = 1;
  static const double med = 24;
  static const double sm = 16;
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;

  // Regular paddings
  static double get xs => 4 * scale;

  static double get xms => 6 * scale;

  static double get sm => 8 * scale;

  static double get med => 12 * scale;

  static double get lg => 16 * scale;

  static double get xl => 32 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Paddings {
  static final contentPadding = EdgeInsets.all(Insets.med);
  static final horizontalPadding = EdgeInsets.symmetric(horizontal: Insets.med);
  static final horizontalLargePadding = EdgeInsets.symmetric(horizontal: Insets.lg);
  static final verticalPadding = EdgeInsets.symmetric(vertical: Insets.med);

  // Height Paddings
  static EdgeInsets get hxs => EdgeInsets.symmetric(vertical: Insets.xs);

  static EdgeInsets get hsm => EdgeInsets.symmetric(vertical: Insets.sm);

  static EdgeInsets get hmed => EdgeInsets.symmetric(vertical: Insets.med);

  static EdgeInsets get hlg => EdgeInsets.symmetric(vertical: Insets.lg);

  static EdgeInsets get hxl => EdgeInsets.symmetric(vertical: Insets.xl);
}

class TextStyles {
  static final _baseFont = GoogleFonts.inter();

  // 27
  static final inter27Regular = _baseFont.copyWith(fontSize: 27.sp, fontWeight: FontWeight.w400);
  static final inter27Semi = _baseFont.copyWith(fontSize: 27.sp, fontWeight: FontWeight.w600);
  static final inter27Bold = _baseFont.copyWith(fontSize: 27.sp, fontWeight: FontWeight.w700);

  // 20
  static final inter20Regular = _baseFont.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w400);
  static final inter20Semi = _baseFont.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static final inter20Bold = _baseFont.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700);
  // 24
  static final inter24Regular = _baseFont.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w400);
  static final inter24Semi = _baseFont.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600);
  static final inter24Bold = _baseFont.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700);

  // 18
  static final inter18Regular = _baseFont.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400);
  static final inter18Semi = _baseFont.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static final inter18Bold = _baseFont.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700);

  // 16
  static final inter16Regular = _baseFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400);
  static final inter16Semi = _baseFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static final inter16Bold = _baseFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700);

  // 14
  static final inter14Regular = _baseFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static final inter14Semi = _baseFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600);
  static final inter14Bold = _baseFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700);

  // 13
  static final inter13Regular = _baseFont.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
  static final inter13Semi = _baseFont.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600);
  static final inter13Bold = _baseFont.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w700);

  // 12
  static final inter12Regular = _baseFont.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static final inter12Semi = _baseFont.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600);
  static final inter12Bold = _baseFont.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w700);
}

