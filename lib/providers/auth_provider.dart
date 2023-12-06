import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthProvider with ChangeNotifier {
  String? _token = null;

  String? get token {
    if (_token != null && _token!.isNotEmpty) {
      return _token;
    }
    return '';
  }

  bool get isAuth {
    print(token?.isNotEmpty);
    if (token!.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login(String phoneNumber, String password) async {
    final url = Uri.parse('http://$host/api/admin/login');
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
      print(_token);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void logout() {
    _token = '';
    notifyListeners();
  }
}
