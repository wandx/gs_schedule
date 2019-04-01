import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future persistToken({@required String token}) async {
  await SharedPreferences.getInstance().then((SharedPreferences p) async {
    await p.setString("token", token);
  });
}

Future<String> getToken() async {
  return await SharedPreferences.getInstance().then((SharedPreferences p) {
    return p.getString("token");
  });
}

Future removeToken() async {
  await SharedPreferences.getInstance().then((SharedPreferences p) async {
    await p.remove("token");
  });
}

Future<bool> tokenExists() async {
  return SharedPreferences.getInstance().then((SharedPreferences p) {
    String token = p.getString("token");
    return token != null;
  });
}

Future persistKey() async {
  await SharedPreferences.getInstance().then((SharedPreferences p) async {
    if (p.getString("key") != null) {
      final cryptor = new PlatformStringCryptor();
      final String key = await cryptor.generateRandomKey();
      await p.setString("key", key);
    }
  });
}

Future<String> getKey() async {
  return await SharedPreferences.getInstance()
      .then((SharedPreferences p) async {
    if (p.getString("key") == null) {
      final cryptor = new PlatformStringCryptor();
      final String key = await cryptor.generateRandomKey();
      await p.setString("key", key);
    }

    return p.getString("key");
  });
}
