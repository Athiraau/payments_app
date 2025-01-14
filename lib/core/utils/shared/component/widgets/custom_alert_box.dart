import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/styles/colors.dart';
import 'custom_button.dart'; // Import your CustomButton
import 'custom_text.dart'; // Import your CustomText

class CustomAlertDialog {
  static void showCustomAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    required final bool isActionTrue
  }) {
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
            isActionTrue?Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the end
              children: [
                if (cancelText != null)
                  CustomButton(
                    text: cancelText ?? 'Cancel',
                    txtColor: Colors.white,
                    btnColor: AppColor.pdfBtn,
                    borderRadious: 8,
                    paddingVal: 5,
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel();
                      }
                      Navigator.of(context).pop(false);
                    },
                  ),
                const SizedBox(width: 8),
                CustomButton(
                  text: confirmText ?? 'OK',
                  txtColor: Colors.white,
                  btnColor: AppColor.excelBtn,
                  borderRadious: 8,
                  paddingVal: 5,
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm();
                    }
                    GoRouter.of(context).pop(false);
                  },
                ),
              ],
            ):SizedBox(),
          ],
        );
      },
    );
  }
}
