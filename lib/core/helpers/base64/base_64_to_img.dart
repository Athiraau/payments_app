import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
class Base64ToImage {
  static Widget convertBase64ToImg({required String base64String}) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes);
  }
}
//usage  base64ToImage.convertBase64ToImg(base64String: base64String)