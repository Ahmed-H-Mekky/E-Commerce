import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  List<dynamic> listData = [];
  Future<dynamic> getData({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return listData = jsonDecode(response.body);
    } else {
      throw Exception(
        'Ther is a problem with status code ${response.statusCode} with ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> postAddProduct({
    required String url,
    @required String? token,
    @required Map<String, dynamic>? bodyData,
  }) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      header.addAll({'Authorization': 'Bearer$token'});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(bodyData),
      headers: header,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Ther is a problem with status code ${response.statusCode} with ${jsonDecode(response.body)}',
      );
    }
  }
}
