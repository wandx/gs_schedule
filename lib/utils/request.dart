import 'dart:convert';

import 'package:gs_schedule/utils/config.dart' show baseUrl;
import 'package:gs_schedule/utils/prefs.dart' show getToken;
import 'package:http/http.dart' show Client, Response;
import 'package:gs_schedule/constants/global_constant.dart';
import 'package:meta/meta.dart';

String _setUrl(path) {
  return baseUrl + path;
}

Future<Response> request({
  @required RequestType type,
  @required String path,
  Map<String, dynamic> body,
}) async {
  final _client = Client();
  final _url = _setUrl(path);
  final _body = jsonEncode(body);
  Response _response;

  final _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  switch (type) {
    case RequestType.POST:
      _response = await _client.post(_url, headers: _headers, body: _body);
      break;
    case RequestType.PATCH:
      _response = await _client.patch(_url, headers: _headers, body: _body);
      break;
    case RequestType.DELETE:
      _response = await _client.delete(_url, headers: _headers);
      break;
    default:
      _response = await _client.get(_url, headers: _headers);
      break;
  }

  print(_response.body);
  return _response;
}

Future<Response> authRequest({
  @required RequestType type,
  @required String path,
  Map<String, dynamic> body,
}) async {
  final _client = Client();
  final _url = _setUrl(path);
  final _body = jsonEncode(body);
  final _token = await getToken();
  Response _response;

  if (_token == null) {
    throw Exception("Token not exists");
  }

  final _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $_token"
  };

  switch (type) {
    case RequestType.POST:
      _response = await _client.post(_url, headers: _headers, body: _body);
      break;
    case RequestType.PATCH:
      _response = await _client.patch(_url, headers: _headers, body: _body);
      break;
    case RequestType.DELETE:
      _response = await _client.delete(_url, headers: _headers);
      break;
    default:
      _response = await _client.get(_url, headers: _headers);
      break;
  }

  print(_response.body);
  return _response;
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
      response = await client.post(_setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.PATCH:
      response = await client.patch(_setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.DELETE:
      response = await client.delete(_setUrl(path), headers: headers);
      break;
    default:
      response = await client.get(_setUrl(path), headers: headers);
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
      response = await client.post(_setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.PATCH:
      response = await client.patch(_setUrl(path),
          headers: headers, body: json.encode(body));
      break;
    case RequestType.DELETE:
      response = await client.delete(_setUrl(path), headers: headers);
      break;
    default:
      response = await client.get(_setUrl(path), headers: headers);
      break;
  }

  client.close();

  return response;
}
