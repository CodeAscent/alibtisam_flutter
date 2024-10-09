import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

isAppThemeDark() {
  final themeController = Get.find<ThemeController>();
  return themeController.isDarkTheme();
}

ThemeData kAppThemeLight() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor(),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle:
                TextStyle(color: primaryColor(), fontWeight: FontWeight.w800))),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    dialogTheme: DialogTheme(
        // titleTextStyle: TextStyle(color: primaryColor()),
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
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    chipTheme: ChipThemeData(backgroundColor: Colors.white),
    cardTheme: CardTheme(
      color: kAppGreyColor(),
      surfaceTintColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
  );
}

ThemeData kAppThemeDark() {
  return ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor(),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    chipTheme: ChipThemeData(
        backgroundColor: kAppGreyColor(),
        labelStyle: TextStyle(color: Colors.white)),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(),
        menuStyle:
            MenuStyle(backgroundColor: WidgetStatePropertyAll(Colors.black)),
        textStyle: TextStyle(
          color: Colors.white,
        )),
    textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle:
                TextStyle(color: primaryColor(), fontWeight: FontWeight.w800))),
    brightness: Brightness.light,
    tabBarTheme: TabBarTheme(labelColor: Colors.white),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
    ),
    dialogTheme: DialogTheme(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      errorMaxLines: null,
      helperMaxLines: null,
      isDense: true,
      contentPadding: EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kAppGreyColor()),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    cardTheme: CardTheme(
      color: kAppGreyColor(),
      surfaceTintColor: Colors.black,
    ),
    listTileTheme: ListTileThemeData(textColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kAppGreyColor(),
            surfaceTintColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
  );
}
