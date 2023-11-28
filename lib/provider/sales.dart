import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/http.dart';
import 'package:martes_emp_qr/src/constants/url.dart';

class SalesProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  List sales = [];
  // int totalCard = 0;
  // int totalCash = 0;
  // int totalTransf = 0;

  static String finalUrl = "$baseUrl/api/sales/get-sales-of-day-employee";

  var url = Uri.parse(finalUrl);

  Future<List> getSalesOfToday() async {
    final token = await _storage.read(key: 'token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Response resp = await http.get(url, headers: headers);
    Logger().wtf(json.decode(resp.body));

    sales = json.decode(resp.body);

    return sales;
  }

  Future<Map> getSale(String id) async {
    final toSend = json.encode({'id': id});
    Response resp = await postWithToken('api/sales/get-sale', toSend);
    final sale = json.decode(resp.body);

    Map<String, dynamic> order = {
      'total': sale["total"],
      'cart': json.decode(sale['cart'].toString())
    };
    return order;
  }
}
