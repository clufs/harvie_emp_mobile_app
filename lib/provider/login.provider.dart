import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:logger/logger.dart';
import 'package:martes_emp_qr/src/constants/url.dart';

class LoginProvider extends ChangeNotifier {
  late String name;
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String token) async {
    // var url =
    //     Uri.parse('http://192.168.1.5:3000/api/employee/check-status'); //Dev

    const String completeLink = '$baseUrl/api/employee/check-status';

    var url = Uri.parse(completeLink); //Prod

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response resp = await http.get(url, headers: headers);

    final body = json.decode(resp.body);

    if (resp.statusCode == 200) {
      name = body['name'];
      Map data = {
        'id': body['id'],
        'ownerId': body['owner']['id'],
        'name': body['name'],
        'token': body['token']
      };
      Logger().wtf(data);
      _saveToken(data);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> checkLogin() async {
    final token = await getToken();
    if (token == null) return false;

    bool isAuth = await login(token);
    if (isAuth) {
      return true;
    }
    return false;
  }

  static Future getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  Future _saveToken(Map data) async {
    await _storage.write(key: 'ownerId', value: data['ownerId']);
    await _storage.write(key: 'token', value: data['token']);
    await _storage.write(key: 'id', value: data['id']);
    await _storage.write(key: 'name', value: data['name']);
  }
}
