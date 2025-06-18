import 'package:flutter/material.dart';

class CustomCalendarTheme {
  static const Color primaryColor = Color(0xFF051645); // Main color used (example: purple)
  static const Color secondaryColor = Colors.white; // Background color
  static const Color accentColor = Colors.blue; // Accent color for selected elements
  static const Color unselectedColor = Colors.black54; // Color for unselected days
  static const Color todayColor = Color(0xFFBB86FC); // Color for today's date

  static Widget customCalendarTheme(BuildContext context, final Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(primaryColor),
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          yearBackgroundColor: MaterialStateProperty.all(secondaryColor),
          yearStyle: const TextStyle(
            color: primaryColor,
            fontFamily: 'poppinsSemiBold',
            fontSize: 16,
          ),
          rangePickerHeaderHelpStyle: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'poppinsSemiBold',
          ),
          rangePickerHeaderHeadlineStyle: const TextStyle(
            color: primaryColor,
            fontFamily: 'poppinsSemiBold',
            fontSize: 22,
          ),
          rangePickerHeaderBackgroundColor: secondaryColor,
          rangePickerHeaderForegroundColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: const TextStyle(
              color: primaryColor,
              fontFamily: 'poppinsRegular',
              fontSize: 14,
            ),
            helperStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'poppinsSemiBold',
              fontSize: 12,
            ),
            hintStyle: const TextStyle(
              color: unselectedColor,
              fontFamily: 'poppinsSemiBold',
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'poppinsSemiBold',
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          yearForegroundColor: MaterialStateProperty.all(Colors.black),
          headerHelpStyle: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'poppinsSemiBold',
          ),
          rangePickerBackgroundColor: secondaryColor,
          backgroundColor: secondaryColor,
          weekdayStyle: const TextStyle(
            color: primaryColor,
            fontFamily: 'poppinsSemiBold',
            fontSize: 14,
          ),
          dayForegroundColor: MaterialStateProperty.all(Colors.black),
          dayOverlayColor: MaterialStateProperty.all(secondaryColor),
          dividerColor: Colors.grey[300],
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryColor),
            textStyle: MaterialStateProperty.all(TextStyle(
              color: Colors.white,
              fontFamily: 'poppinsRegular',
              fontSize: 16,
            )),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            )),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.red),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
              fontFamily: 'poppinsRegular',
              fontSize: 16,
            )),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            )),
          ),
          todayBackgroundColor: MaterialStateProperty.all(todayColor),
          todayForegroundColor: MaterialStateProperty.all(Colors.white),
          dayStyle: TextStyle(
            fontFamily: 'poppinsRegular',
            color: Colors.black, // Selected day color
            fontSize: 14,
          ),
          headerBackgroundColor: primaryColor,
          headerForegroundColor: Colors.white,
          headerHeadlineStyle: TextStyle(
            fontFamily: 'poppinsBold',
            fontSize: 26,
          ),
        ),
      ),
      child: child,
    );
  }
}