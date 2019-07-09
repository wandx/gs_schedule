import 'dart:convert';

import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/models/user.dart';
import 'package:gs_schedule/utils/prefs.dart' show persistToken, removeToken;
import 'package:gs_schedule/utils/request.dart'
    show makeAuthRequest, makeRequest;
import 'package:http/http.dart' show Response;
import 'package:gs_schedule/constants/global_constant.dart';

Future<Null> login(Credential credential) async {
  return await makeRequest(
    RequestType.POST,
    "/auth/login",
    body: credential.toJson(),
  ).then((Response r) async {
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      final token = parsed["data"]["token"] as String;
      await persistToken(token: token);
    }
  }).catchError((error) {
    throw Exception(error);
  });
}

Future<bool> logout() async {
  return await makeAuthRequest(RequestType.POST, "/auth/logout")
      .then((Response r) async {
    if (r.statusCode == 200) {
      removeToken();
      return true;
    }
    return false;
  }).catchError((error) {
    throw Exception(error);
  });
}

Future<User> me() async {
  return await makeAuthRequest(RequestType.GET, "/auth/me")
      .then((Response r) async {
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      final data = parsed["data"];
      print(data);
      return User.fromJson(data);
    }
  }).catchError((error) {
    throw Exception(error);
  });
}

Future<List<Account>> getAccount() async {
  return await makeAuthRequest(RequestType.GET, "/user/account")
      .then((Response r) async {
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      final accounts = parsed["data"]["accounts"];

      return accounts.map<Account>((json) => Account.fromJson(json)).toList();
    }

    throw Exception("No data");
  });
}

Future<Null> removeAccount(String id) async {
  await makeAuthRequest(RequestType.POST, "/user/account/$id/delete")
      .then((Response r) {
    print(r.body);
    if (r.statusCode != 200) {
      throw Exception(r.body);
    }
  });
}

Future<Null> storeAccount(Map<String, dynamic> body) async {
  await makeAuthRequest(RequestType.POST, "/user/account/store", body: body)
      .then((Response r) async {
    if (r.statusCode != 201) {
      throw Exception(r.body);
    }
  });
}
