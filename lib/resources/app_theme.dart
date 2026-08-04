import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.montserrat(
            fontSize: 24,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          titleSmall: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          bodySmall: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          labelSmall: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          labelMedium: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          labelLarge: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          displayLarge: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          displayMedium: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          displaySmall: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),

        // textTheme: TextTheme(
        //   titleLarge: TextStyle(
        //     fontFamily: 'Raleway',
        //     fontSize: 24.spMin,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        //   titleMedium: TextStyle(
        //     fontFamily: 'Raleway',
        //     fontSize: 18.spMin,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        //   titleSmall: TextStyle(
        //     fontFamily: 'Raleway',
        //     fontSize: 16.spMin,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        //   bodySmall: TextStyle(
        //     fontFamily: 'Raleway',
        //     fontSize: 12.spMin,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        //   labelSmall: TextStyle(
        //     fontFamily: 'Raleway',
        //     fontSize: 12.spMin,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        // ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          // iconTheme: IconThemeData(color: Colors.black, size: 24),
          backgroundColor: Colors.white,
          // elevation: 1,
          // shadowColor: Colors.gray,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          elevation: 3,
        ),
        // dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
      );

}

