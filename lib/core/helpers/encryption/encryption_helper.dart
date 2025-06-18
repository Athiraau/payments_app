abstract class EncryptionHelper {
  String encryptData({required String data, required String baseKey, required String ivKey});
  String decryptData({required String data, required String baseKey, required String ivKey});
}