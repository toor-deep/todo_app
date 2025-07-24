import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/design-system/styles.dart';

import 'app_colors.dart';


ThemeData get lightTheme => ThemeData(
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kPrimaryColor,
      ),

      textTheme: GoogleFonts.nunitoTextTheme(),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: Colors.grey), // Border color
        checkColor: const WidgetStatePropertyAll(
            Colors.white), // Color of the check mark
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kPrimaryColor; // Active state color (when selected)
          }
          return Colors.white; // Inactive state color (when not selected)
        }),
      ),
      listTileTheme:
          ListTileThemeData(selectedTileColor: kPrimaryColor.withValues(alpha: 0.1)),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(color: kLightGreyColor,
      thickness: 1
      ),
      switchTheme: SwitchThemeData(
        trackColor: const WidgetStatePropertyAll(kLightGreyColor),
      ),
      scaffoldBackgroundColor: Colors.white,
      cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: kPrimaryColor, applyThemeToAll: true),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14)))),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return kPrimaryColor; // Active color
          }
          return Colors.grey; // Passive color
        }),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyles.inter14Bold.copyWith(color: kGreyDarkColor)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: kPrimaryColor),
      tabBarTheme: const TabBarThemeData(
          labelColor: kPrimaryColor,
          indicatorColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.fromLTRB(8, 5.0, 0, 5.0),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          isDense: false,
          suffixIconColor: Colors.grey),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyles.inter14Bold),
         )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: const WidgetStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0))),
              elevation: const WidgetStatePropertyAll(0.0),
              fixedSize: WidgetStatePropertyAll(Size.fromHeight(40.h)))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              textStyle: const WidgetStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0))),
              elevation: const WidgetStatePropertyAll(0.0),
              fixedSize: WidgetStatePropertyAll(Size.fromHeight(30.h)))),
      useMaterial3: false,
    );

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  primaryColor: Colors.blue[900],
);

ThemeData staffLightTheme = lightTheme.copyWith(
  checkboxTheme: CheckboxThemeData(
    checkColor: const WidgetStatePropertyAll(Colors.blue),
    fillColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return Colors.blue;
      }
      return null;
    }),
  ),
);

