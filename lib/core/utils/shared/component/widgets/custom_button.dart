import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? txtColor;
  final Color? btnColor;
  final double? borderRadious;
  final double? fontSize;
  final double? width;
  final double? height;
  final Function() onPressed;
  final Function(bool)? onHover;
  final Widget? customWidget;
  final Widget? progress;
  final double? paddingVal;
  const CustomButton({
    Key? key,
    this.text,
    this.txtColor,
    this.btnColor,
    this.fontSize,
    this.width,
    this.height,
    required this.onPressed,
    this.borderRadious,
    this.onHover,
    this.customWidget,
    this.paddingVal,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadious ?? 0),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadious ?? 0),
        onTap: onPressed,
        onHover: onHover,
        splashColor: Colors.black.withOpacity(0.3),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadious ?? 0),
            color: btnColor ?? Colors.black,
          ),
          child: customWidget == null
              ? Center(
                  child: Padding(
                    padding:
                        EdgeInsets.all(paddingVal == null ? 0 : paddingVal!),
                    child: progress == null
                        ? CustomText(
                            text: text ?? '',
                            fontSize: fontSize ?? 13,
                            fontFamily: 'poppinsRegular',
                            color: txtColor ?? Colors.white,
                          )
                        : progress,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customWidget!,
                    const SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: text ?? '',
                      fontSize: fontSize ?? 13,
                      fontFamily: 'poppinsRegular',
                      color: txtColor ?? Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
