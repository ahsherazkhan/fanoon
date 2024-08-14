import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

final TextTheme lightTextTheme = TextTheme(
  //-----------DISPLAY-------------------------
  displayLarge: GoogleFonts.montserrat(
    fontSize: 57.sp,
    color: Colors.black,
  ),
  displayMedium: GoogleFonts.montserrat(
    fontSize: 45.sp,
    color: Colors.black,
  ),
  displaySmall: GoogleFonts.montserrat(
    fontSize: 36.sp,
    color: Colors.black,
  ),
  //------------------------------------------

  //----------HEADLINE-----------------------
  headlineLarge: GoogleFonts.montserrat(
    fontSize: 32.sp,
  ),
  headlineMedium: GoogleFonts.montserrat(
    fontSize: 28.sp,
  ),
  headlineSmall: GoogleFonts.montserrat(
    fontSize: 24.sp,
  ),
  //------------------------------------------

  //---------TITLE----------------------------
  titleLarge: GoogleFonts.montserrat(
    fontSize: 22.sp,
  ),
  titleMedium: GoogleFonts.montserrat(
      fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600),
  titleSmall: GoogleFonts.montserrat(
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 14.sp,
  ),
  //-------------------------------------------

  //----------BODY----------------------------
  bodyLarge: GoogleFonts.montserrat(
    fontSize: 16.sp,
  ),
  bodyMedium: GoogleFonts.montserrat(
    color: grey,
    fontSize: 14.sp,
  ),
  bodySmall: GoogleFonts.montserrat(
    fontSize: 12.sp,
    color: Colors.black,
  ),
  //-----------------------------------------

  //-----------LABLE--------------------------
  labelLarge: GoogleFonts.montserrat(
      fontSize: 12.sp, color: lightGrey, fontWeight: FontWeight.w500),
  labelMedium: GoogleFonts.montserrat(
      color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.w500),
  labelSmall: GoogleFonts.montserrat(
    color: grey,
    fontSize: 8.sp,
  ),
);

final TextTheme darkTextTheme = TextTheme(
  //-----------DISPLAY-------------------------
  displayLarge: GoogleFonts.montserrat(
    fontSize: 57.sp,
    color: Colors.white,
  ),
  displayMedium: GoogleFonts.montserrat(
    fontSize: 45.sp,
    color: Colors.white,
  ),
  displaySmall: GoogleFonts.montserrat(
    fontSize: 36.sp,
    color: Colors.white,
  ),
  //------------------------------------------

  //----------HEADLINE-----------------------
  headlineLarge: GoogleFonts.montserrat(
    fontSize: 32.sp,
  ),
  headlineMedium: GoogleFonts.montserrat(
    fontSize: 28.sp,
  ),
  headlineSmall: GoogleFonts.montserrat(
    fontSize: 24.sp,
  ),
  //------------------------------------------

  //---------TITLE----------------------------
  titleLarge: GoogleFonts.montserrat(
    fontSize: 22.sp,
  ),
  titleMedium: GoogleFonts.montserrat(
      fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600),
  titleSmall: GoogleFonts.montserrat(
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 14.sp,
  ),
  //-------------------------------------------

  //----------BODY----------------------------
  bodyLarge: GoogleFonts.montserrat(
    fontSize: 16.sp,
  ),
  bodyMedium: GoogleFonts.montserrat(
    color: grey,
    fontSize: 14.sp,
  ),
  bodySmall: GoogleFonts.montserrat(
    fontSize: 12.sp,
    color: Colors.white,
  ),
  //-----------------------------------------

  //-----------LABLE--------------------------
  labelLarge: GoogleFonts.montserrat(
      fontSize: 12.sp, color: lightGrey, fontWeight: FontWeight.w500),
  labelMedium: GoogleFonts.montserrat(
      color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w500),
  labelSmall: GoogleFonts.montserrat(
    color: grey,
    fontSize: 8.sp,
  ),
);

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      shadowColor: isDarkTheme ? Colors.black : Colors.grey,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:
              isDarkTheme ? const Color(0xff232323) : Colors.white),
      chipTheme: const ChipThemeData(
        shadowColor: red,
        backgroundColor: red,
      ),
      textTheme: isDarkTheme ? darkTextTheme : lightTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? const Color(0xff232323) : Colors.white,
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: red,
            secondary: red,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            primaryContainer:
                isDarkTheme ? const Color(0xff232323) : Colors.white,
            background: isDarkTheme ? const Color(0xff232323) : Colors.white,
          ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        focusColor: orange,
        floatingLabelStyle:
            isDarkTheme ? lightTextTheme.bodySmall : darkTextTheme.bodySmall,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: const BorderSide(
            color: orange,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: const BorderSide(
            color: grey,
            width: 2,
          ),
        ),
        helperStyle:
            isDarkTheme ? darkTextTheme.bodySmall : lightTextTheme.bodySmall,
        hintStyle: isDarkTheme
            ? darkTextTheme.bodySmall
            : lightTextTheme.bodySmall!
                .copyWith(color: Colors.black.withOpacity(0.5)),
        labelStyle: isDarkTheme ? darkTextTheme.bodySmall : lightTextTheme.bodySmall,
      ),
    );
  }
}
