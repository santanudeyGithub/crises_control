import 'dart:convert';

import 'package:crises_control/src/core/constants.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:math' as math;
import 'package:crypto/crypto.dart';

class EncryptionHelper {
//for AES Algorithms
  static encrypt.Encrypted? encrypted;

  static void encryptAES(String plainText) {
    final key = encrypt.Key.fromUtf8(Keys.encryptionPassPhrase);
    final iv = encrypt.IV.fromLength(16);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    encrypted = encrypter.encrypt(plainText, iv: iv);
  }

  static createCryptoGuid({int bytes = 16}) {
    // code = getRandomString(128);
    math.Random rnd = math.Random();
    List<int> values = List<int>.generate(bytes, (i) => rnd.nextInt(256));
    return values.toString();
  }

  static String createCodeChallenge({required codeVerifier}) {
    var codeChallengeBytes = sha256.convert(codeVerifier).bytes;
    return base64.encode(codeChallengeBytes);
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
