import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

import 'encryption_helper.dart';
class AppEncryptionHelper implements EncryptionHelper {
  @override
  String encryptData({required String data, required String baseKey, required String ivKey}) {
    try {
      if (data.isEmpty) return '';

      final key = encrypt.Key.fromBase64(baseKey);
      final iv = encrypt.IV.fromBase64(ivKey);
      final cipher = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encrypted = cipher.encrypt(data, iv: iv);
      return encrypted.base64;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint("Encryption error: $e\nStack trace: $stackTrace");
      }
      throw Exception('Encryption failed: $e');
    }
  }

  @override
  String decryptData({required String data, required String baseKey, required String ivKey}) {
    try {
      if (data.isEmpty) return '';

      final key = encrypt.Key.fromBase64(baseKey);
      final iv = encrypt.IV.fromBase64(ivKey);
      final cipher = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encrypted = encrypt.Encrypted.fromBase64(data);
      final decrypted = cipher.decrypt(encrypted, iv: iv);
      return decrypted;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint("Decryption error: $e\nStack trace: $stackTrace");
      }
      throw Exception('Decryption failed: $e');
    }
  }
}