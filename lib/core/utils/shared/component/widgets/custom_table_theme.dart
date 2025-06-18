import 'package:flutter/material.dart';

import '../../../config/styles/colors.dart';

class CustomTableTheme extends StatelessWidget {
  final Widget child;

  const CustomTableTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scrollbarTheme: const ScrollbarThemeData(
            thickness: MaterialStatePropertyAll(10),
            thumbColor: MaterialStatePropertyAll(AppColor.drawerColor),
            trackColor: MaterialStatePropertyAll(AppColor.drawerColor)),
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
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: AppColor.card5),
        ),
      ),
      child: child,
    );
  }
}

class CustomMainTableTheme extends StatelessWidget {
  final Widget child;

  const CustomMainTableTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(AppColor.primaryColor),
          )),
          cardTheme: CardTheme(
              color: AppColor.tableHeaderColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black.withOpacity(0.05)),
          dataTableTheme: DataTableThemeData(
            headingTextStyle: _headTxtStyle,
            dataRowColor: MaterialStateProperty.all(Colors.white),
            dataTextStyle: _tableRowTxtStyle,
            dividerThickness: 0,
          ),
          tooltipTheme: const TooltipThemeData(
              textStyle: _tableRowTxtStyle,
              decoration: BoxDecoration(color: Colors.white)),
          scrollbarTheme: const ScrollbarThemeData(
              thickness: MaterialStatePropertyAll(10),
              thumbColor: MaterialStatePropertyAll(AppColor.drawerColor),
              trackColor: MaterialStatePropertyAll(AppColor.drawerColor)),

          canvasColor: AppColor.drawerImgTileColor,
          textTheme: const TextTheme(
             bodySmall: TextStyle(color:AppColor.primaryColor,fontFamily: 'poppinsRegular')),
        ),
        child: child);
  }
}

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.primaryColor,
);
const _tableRowTxtStyle = TextStyle(
    fontFamily: 'poppinsRegular',
    fontSize: 10,
    color: AppColor.cardTitleSubColor);
