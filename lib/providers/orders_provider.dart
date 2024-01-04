import 'dart:js_interop';

import 'package:drugdrop_web/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/orders_data.dart';

class OrdersProvider with ChangeNotifier {
  final String token;
  OrdersProvider(this.token);
  List<Order> _orders = [];

  List<Order> get allOrders {
    return [..._orders];
  }

  Order findOrderById(int id) {
    return _orders.firstWhere((drug) => drug.id == id);
  }

  List<Order> get preparingOrders {
    return _orders.where((order) => order.state == 'pending').toList();
  }

  List<Order> get onGoingOrders {
    return _orders.where((order) => order.state == 'on going').toList();
  }

  List<Order> get deliveredOrders {
    return _orders.where((order) => order.state == 'done').toList();
  }

  Future<void> fetchOrders() async {
    final url = Uri.http(host, '/api/admin/order/get');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final List<Order> loadedOrders = [];
    final fetchedOrders = json.decode(response.body) == null
        ? null
        : json.decode(response.body) as Map<String, dynamic>;
    if (fetchedOrders == null) {
      return;
    }
    print(fetchedOrders);
    fetchedOrders['Data'].forEach((orderData) {
      loadedOrders.add(Order(
        id: orderData['id'],
        name: orderData['name'],
        phoneNumber: orderData['phone_number'],
        location: orderData['location'],
        price: orderData['total_price'],
        date: orderData['created_at'],
        isPaid: orderData['is_paid'],
        state: orderData['status'].toString(),
      ));
      print('${orderData['status']}-------------------------------');
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> updateOrderStatus(int id, String status) async {
    final url =
        Uri.http(host, '/api/admin/order/update/$id', {'lang_code': 'en'});

    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'status': status,
    });
    final data = json.decode(response.body);

    final responseData = data['Status'];
    print(responseData);
    if (responseData == 'Success') {
      final editedOrder = findOrderById(id);
      editedOrder.state = status;
      deliveredOrders.add(editedOrder);
      notifyListeners();
    }
  }

  Future<void> updateOrderPayment(int id, bool payment) async {
    final url = Uri.http(host, '/api/admin/order/update/$id');

    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'is_paid': payment.toString(),
    });
    final data = json.decode(response.body);
    print(data);
    final responseData = data['Status'];

    if (responseData == 'Success') {
      final editedOrder = findOrderById(id);
      editedOrder.isPaid = true;
      deliveredOrders.add(editedOrder);
      notifyListeners();
    }
  }
}
