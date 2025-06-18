import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/styles/colors.dart';
import 'custom_text.dart';

class CustomAlertDialog {
  static void showCustomAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? cancelText,
    final VoidCallback? onCancelPressed,
  }) {
    final FocusNode focusNode = FocusNode();

    showDialog(
      barrierDismissible: false,
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
              child: Center(
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
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeyboardListener(
                  focusNode: focusNode,
                  autofocus: true,
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.enter) {
                      if (onCancelPressed != null) {
                        onCancelPressed();
                      }
                    }
                  },
                  child: ElevatedButton(
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
                ),
              ],
            ),
          ],
        );
      },
    ).then((_) {
      focusNode.dispose();
    });
  }
}
