import 'package:encrypt/encrypt.dart';

String encrypt(String plainText) {
  final key = Key.fromUtf8('t6w9z\$C&F)J@NcRfUjWnZr4u7x!A%D*G');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}
