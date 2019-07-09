import 'dart:convert';

import 'package:gs_schedule/models/media.dart';
import 'package:gs_schedule/utils/request.dart' show makeAuthRequest;
import 'package:http/http.dart' show Response;
import 'package:gs_schedule/constants/global_constant.dart';

Future<List<Media>> getMedia() async {
  return await makeAuthRequest(RequestType.GET, "/media")
      .then((Response r) async {
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      final media = parsed["data"]["media"];
      return media.map<Media>((json) => Media.fromJson(json)).toList();
    }

    throw Exception(r.body);
  });
}

Future storeMedia(Map<String, dynamic> body) async {
  await makeAuthRequest(RequestType.POST, "/media/store-media", body: body)
      .then((Response r) {
    if (r.statusCode != 200) {
      throw Exception(r.body);
    }
  });
}

Future<Map<String, dynamic>> storeSchedule(Map<String, dynamic> body) async {
  return await makeAuthRequest(RequestType.POST, "/media/store-schedule",
          body: body)
      .then((Response r) async {
    print(r.body);
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      return parsed["data"];
    }
    throw Exception(r.body);
  });
}

Future<String> deleteMedia(String id) async {
  return await makeAuthRequest(RequestType.DELETE, "/media/$id")
      .then((Response r) async {
    if (r.statusCode == 200) {
      final parsed = json.decode(r.body);
      final path = parsed["data"]["path"];
      return path;
    }

    throw Exception(r.body);
  });
}
