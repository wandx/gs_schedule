import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:gs_schedule/utils/prefs.dart' show getKey;

class Account {
  final String id;
  final String username;
  final String password;
  final String description;

  Account({this.id, this.username, this.password, this.description});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json["id"],
      username: json["username"],
      password: json["password"],
      description: json["description"],
    );
  }

  toJson() {
    return {
      "id": this.id,
      "username": this.username,
      "password": this.password,
      "description": this.description
    };
  }

  Future<String> encrypt(String str) async {
    final c = new PlatformStringCryptor();
    final key = await getKey();

    return await c.encrypt(str, key);
  }

  Future<String> decrypt(String hash) async {
    final c = new PlatformStringCryptor();
    final key = await getKey();

    try {
      final String decrypted = await c.decrypt(hash, key);
      return decrypted;
    } on MacMismatchException {
      throw Exception("errr");
      // unable to decrypt (wrong key or forged data)
    }
  }
}
