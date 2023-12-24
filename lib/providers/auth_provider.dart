import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthProvider with ChangeNotifier {
  late String _token = '';

  String get getToken {
    if (_token != null && _token!.isNotEmpty) {
      return _token;
    }
    return '';
  }

  bool get isAuth {
    return getToken != '';
  }

  Future<void> login(String phoneNumber, String password) async {
    final url = Uri.parse('http://$host/api/user/admin/login');
    try {
      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'phone_number': '09$phoneNumber',
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData == null) {
        throw Exception();
      }
      if (responseData['Status'] == 'Failed') {
        throw Exception('Failed');
      }
      _token = responseData['Data']['token'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('http://$host/api/user/logout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        },
      );
      final data = json.decode(response.body);
      print(data);
    } catch (error) {
      rethrow;
    }
    // _token = '';
    notifyListeners();
  }
}
