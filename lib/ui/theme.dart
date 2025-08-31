import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryClr,
      brightness: Brightness.light,
    ),
    primaryColor: primaryClr,
    scaffoldBackgroundColor: white,
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme(),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryClr,
      brightness: Brightness.dark,
    ),
    primaryColor: darkGreyClr,
    scaffoldBackgroundColor: darkGreyClr,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme(),
  );
}

TextStyle get headlineStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subHeadlineStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get bodyTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get bodyTextStyle2 {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
  );
}
