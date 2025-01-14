import 'package:flutter/material.dart';

import '../../../config/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelTxt;
  final String hintTxt;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? labelTxtStyle;
  final TextStyle? hintTxtStyle;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    required this.labelTxt,
    required this.hintTxt,
    required this.controller,
    required this.keyboardType,
    required this.labelTxtStyle,
    required this.hintTxtStyle,
    required this.onChanged,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
          color: Colors.black, fontFamily: 'poppinsRegular', fontSize: 14),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        prefix: prefixIcon,
        fillColor: const Color(0xfff5f5f5),
        suffixIcon: suffixIcon,
        hintText: hintTxt,
        hintStyle: hintTxtStyle,
        contentPadding: const EdgeInsets.all(12),
        labelText: labelTxt,
        labelStyle: labelTxtStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColor.drawerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColor.dividerColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.dividerColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
