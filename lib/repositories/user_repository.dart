import 'dart:convert';

import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/models/user.dart';
import 'package:meta/meta.dart';
import 'package:gs_schedule/constants/global_constant.dart';
import 'package:gs_schedule/utils/request.dart' as request;
import 'package:gs_schedule/utils/prefs.dart' show persistToken,removeToken;

Future<bool> login({@required Credential credential}) async {
  final _response = await request.request(
    type: RequestType.POST,
    path: "/auth/login",
    body: credential.toMap(),
  );

  if (_response.statusCode != 200) {
    return false;
  }

  final body = jsonDecode(_response.body);
  await persistToken(token: body["data"]["token"] as String);

  return true;
}

Future<bool> logout() async {
  final _response = await request.authRequest(
    type: RequestType.POST,
    path: "/auth/logout",
  );

  if(_response.statusCode != 200){
    return false;
  }

  await removeToken();
  return true;
}

Future<User> me() async{
  final _response = await request.authRequest(
    type: RequestType.GET,
    path: "/auth/me",
  );

  if(_response.statusCode != 200){
    return null;
  }

  final _body = jsonDecode(_response.body);
  return User.fromJson(_body["data"]);
}

Future<List<Account>> getAccounts() async{
  final _response = await request.authRequest(
    type: RequestType.GET,
    path: "/user/account",
  );

  if(_response.statusCode != 200){
    return [];
  }

  final _body = jsonDecode(_response.body);
  final _data = _body["data"]["accounts"];
  return _data.map<Account>((json) => Account.fromJson(json)).toList();
}

Future<bool> storeAccount({@required Map<String,dynamic> body}) async{
  final _response = await request.authRequest(
    type: RequestType.POST,
    path: "/user/account/store",
    body: body,
  );

  final _body = jsonDecode(_response.body);

  if(_response.statusCode == 422){
    throw Exception(_body.errors);
  }

  if(_response.statusCode != 200){
    return false;
  }

  return true;
}

Future<bool> deleteAccount({@required String id}) async{
  final _response = await request.authRequest(
    type: RequestType.POST,
    path: "/user/account/$id/delete",
  );

  return _response.statusCode == 200;
}

Future<Map<String, dynamic>> storeSchedule({@required Map<String,dynamic> body}) async {
  final _response = await request.authRequest(
    type: RequestType.POST,
    path: "/media/store-schedule",
    body: body,
  );

  if (_response.statusCode == 200) {
    final parsed = json.decode(_response.body);
    return parsed["data"];
  }

  return null;
}
