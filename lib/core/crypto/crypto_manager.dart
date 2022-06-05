import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptoManager {
  CryptoManager._();
  static String encryptData({required String data}) {
    //log('Data: ' + data);
    var bytes = utf8.encode(data);
    //log('Bytes: ' + bytes.toString());
    Digest encrytedBytes = sha256.convert(bytes);
    //log('Encrypted Bytes: ' + encrytedBytes.bytes.toString());
    var encryptedData = '$encrytedBytes';
    //log('Encypted Data: ' + encryptedData);
    return encryptedData;
  }

  static bool isEqualsEncryptedData(
      {required String data, required String encryptedData}) {
    var bytes = utf8.encode(data);
    var encrytedBytes = sha256.convert(bytes);
    var encryptedData = utf8.decode(encrytedBytes.bytes);
    return encryptedData == encryptedData;
  }
}
