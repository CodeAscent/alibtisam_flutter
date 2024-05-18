import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData kAppThemeLight() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    dialogTheme: DialogTheme(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: null,
      helperMaxLines: null,
      isDense: true,
      contentPadding: EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kgreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kgreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kgreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kgreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor()),
  );
}
