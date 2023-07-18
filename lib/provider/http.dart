import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:martes_emp_qr/src/constants/url.dart';

const _storage = FlutterSecureStorage();

Future<Response> postWithToken(String path, data) async {
  final token = await _storage.read(key: 'token');

  var finalUrl = Uri.parse('$baseUrl/$path');

  final encoding = Encoding.getByName('utf-8');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response resp = await http.post(
    finalUrl,
    headers: headers,
    encoding: encoding,
    body: data,
  );

  return resp;
}

Future<Response> getWithToken(String path) async {
  final token = await _storage.read(key: 'token');
  final url = Uri.parse('$baseUrl/$path');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response resp = await http.get(
    url,
    headers: headers,
  );

  return resp;
}
