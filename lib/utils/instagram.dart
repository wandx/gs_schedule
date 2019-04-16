import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

final platform = const MethodChannel('tech.wandy.gs_schedule/instagram-bot');

Future<Null> makeSchedule(
    int requestCode, String accountList, String mediaList, DateTime d) async {
  await platform.invokeMethod("make-schedule", {
    "requestCode": requestCode,
    "accountList": accountList,
    "mediaList": mediaList,
    "year": d.year,
    "month": d.month,
    "date": d.day,
    "hour": d.hour,
    "min": d.minute,
  });
}

Future<bool> checkLogin(
    {@required String username, @required String password}) async {
  return await platform.invokeMethod(
      "check-login", {"username": username, "password": password});
}
