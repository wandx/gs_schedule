import 'dart:convert';

import 'package:gs_schedule/utils/config.dart' show baseUrl;
import 'package:gs_schedule/utils/prefs.dart' show getToken;
import 'package:http/http.dart' show Client, ClientException, Response;

enum RequestType { POST, GET, DELETE, PATCH }

String setUrl(path) {
  return baseUrl + path;
}

Future<Response> makeRequest(RequestType type, String path,
    {Map<String, dynamic> body}) async {
  var client = new Client();
  Response response;

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.PATCH:
      response = await client.patch(setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.DELETE:
      response = await client.delete(setUrl(path), headers: headers);
      break;
    default:
      response = await client.get(setUrl(path), headers: headers);
      break;
  }

  client.close();

  return response;
}

Future<Response> makeAuthRequest(RequestType type, String path,
    {Map<String, dynamic> body}) async {
  var client = new Client();
  Response response;

  final token = await getToken();

  if (token == null) {
    throw Exception("Token not exists");
  }

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.PATCH:
      response = await client.patch(setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.DELETE:
      response = await client.delete(setUrl(path), headers: headers);
      break;
    default:
      response = await client.get(setUrl(path), headers: headers);
      break;
  }

  client.close();

  return response;
}
