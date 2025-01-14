import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionValue {
  static final _key = encrypt.Key.fromUtf8("8080808080808080");
  static final _iv = encrypt.IV.fromUtf8("8080808080808080");

  static encrypt.Key get key => _key;
  static encrypt.IV get iv => _iv;

  // If string representation is needed:
  static String get keyAsString => _key.base64;
  static String get ivAsString => _iv.base64;
}
