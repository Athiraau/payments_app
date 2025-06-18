import 'package:flutter/material.dart';

import '../../utils/config/styles/colors.dart';
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all(true),
      thickness: MaterialStateProperty.all(8.0),
      thumbColor: MaterialStateProperty.all(
          Colors.black.withOpacity(0.2)), // Set your desired color here
    ),
    useMaterial3: false,
    dataTableTheme: DataTableThemeData(
      headingTextStyle: _headTxtStyle,
      dataRowColor: MaterialStateProperty.all(Colors.white),
      dataTextStyle: _tableRowTxtStyle,
      dividerThickness: 0,
      headingRowColor:
      const MaterialStatePropertyAll(AppColor.drawerImgTileColor),
      headingRowHeight: 30,
      dataRowHeight: 30,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all(true),
      thickness: MaterialStateProperty.all(8.0),
      thumbColor:
      MaterialStateProperty.all(Colors.red), // Set your desired color here
    ),
    useMaterial3: false,
    dataTableTheme: DataTableThemeData(
      headingTextStyle: _headTxtStyle,
      dataRowColor: MaterialStateProperty.all(Colors.black87),
      dataTextStyle: _tableRowTxtStyle.copyWith(color: Colors.white),
      dividerThickness: 0,
      headingRowColor:
      const MaterialStatePropertyAll(AppColor.drawerImgTileColor), // Example for dark theme
      headingRowHeight: 30,
      dataRowHeight: 30,
    ),
  );
}

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.primaryColor,
);

const _tableRowTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.cardTitleSubColor,
);