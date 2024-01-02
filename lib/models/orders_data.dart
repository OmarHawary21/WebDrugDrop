import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Order with ChangeNotifier {
  final String id;
  final String name;
  final String phoneNumber;
  final String location;
  final DateTime date;
  final String price;
  String state;
  bool isPaid = false;

  Order({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.date,
    required this.price,
    required this.isPaid,
    required this.state,
  });

  Future<void> sendOrderStatus(String state) async {
    final url = Uri.parse('https://example.com/orders/$id/$state');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': state}),
    );
    if (response.statusCode == 200) {
      print('Order status updated successfully.');
    } else {
      print('Failed to update order status.');
    }
  }

  void _setPayStatus(bool newPayStatus) {
    isPaid = newPayStatus;
    notifyListeners();
  }

  Future<void> togglePayStatus() async {
    final oldStatus = isPaid;
    var url = Uri.https(
        'flutter-update-a1142-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products/$id.json');
    isPaid = true;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode({'ispaid': isPaid}),
      );
      if (response.statusCode >= 400) {
        _setPayStatus(oldStatus);
        // throw HttpException('Could not added to favorites!');
      }
    } catch (error) {
      _setPayStatus(oldStatus);
    }
  }
}
