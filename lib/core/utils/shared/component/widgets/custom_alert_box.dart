import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/styles/colors.dart';
import 'custom_button.dart'; // Import your CustomButton
import 'custom_text.dart'; // Import your CustomText

class CustomAlertDialog {
  static void showCustomAlertDialog(
      {required BuildContext context,
      required String title,
      required String message,
      String? cancelText,
      required final dynamic Function()? onCancelPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: CustomText(
              text: title,
              fontSize: 18,
              fontFamily: 'poppinsSemiBold',
              fontWeight: FontWeight.bold,
              color: AppColor.cardTitleColor,
            ),
          ),
          content: Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
              maxHeight: 100,
            ),
            child: SingleChildScrollView(
              child: CustomText(
                text: message,
                fontFamily: 'poppinsRegular',
                maxLines: 2,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                color: AppColor.cardTitleSubColor,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.drawerImgTileColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onCancelPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      cancelText ?? 'Ok',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
