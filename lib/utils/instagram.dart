import 'package:flutter/services.dart';

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
