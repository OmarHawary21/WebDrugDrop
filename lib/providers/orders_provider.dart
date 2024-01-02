import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/orders_data.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [
    Order(
        id: '1',
        name: 'taghreed',
        phoneNumber: '0957515618',
        location: 'damascus alabbasin',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'Preparing'),
    Order(
        id: '2',
        name: 'jeeda',
        phoneNumber: '0957515617',
        location: 'damascus almazeh',
        date: DateTime.now(),
        price: '55 ',
        isPaid: false,
        state: 'Preparing'),
    Order(
        id: '3',
        name: 'omar',
        phoneNumber: '0957515664',
        location: 'damascus almedan',
        date: DateTime.now(),
        price: '58 ',
        isPaid: false,
        state: 'Preparing'),
    Order(
        id: '4',
        name: 'omran',
        phoneNumber: '0957515611',
        location: 'damascus almhajren',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'Preparing'),
    Order(
        id: '5',
        name: 'taghreed',
        phoneNumber: '0957515618',
        location: 'damascus alabbasin',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'Preparing'),
    Order(
      id: '6',
      name: 'jeeda',
      phoneNumber: '0957515617',
      location: 'damascus almazeh',
      date: DateTime.now(),
      price: '55 ',
      isPaid: false,
      state: 'Preparing',
    ),
    Order(
        id: '7',
        name: 'omar',
        phoneNumber: '0957515618',
        location: 'damascus almedan',
        date: DateTime.now(),
        price: '58 ',
        isPaid: false,
        state: 'Preparing'),
    Order(
        id: '8',
        name: 'taghreed',
        phoneNumber: '0957515618',
        location: 'damascus alabbasin',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'on Going'),
    Order(
        id: '9',
        name: 'jeeda',
        phoneNumber: '0957515617',
        location: 'damascus almazeh',
        date: DateTime.now(),
        price: '55 ',
        isPaid: false,
        state: 'Delivered'),
    Order(
        id: '10',
        name: 'omar',
        phoneNumber: '0957515664',
        location: 'damascus almedan',
        date: DateTime.now(),
        price: '58 ',
        isPaid: false,
        state: 'Delivered'),
    Order(
        id: '11',
        name: 'omran',
        phoneNumber: '0957515611',
        location: 'damascus almhajren',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'Delivered'),
    Order(
        id: '12',
        name: 'taghreed',
        phoneNumber: '0957515618',
        location: 'damascus alabbasin',
        date: DateTime.now(),
        price: '55 ',
        isPaid: true,
        state: 'Delivered'),
    Order(
        id: '13',
        name: 'jeeda',
        phoneNumber: '0957515617',
        location: 'damascus almazeh',
        date: DateTime.now(),
        price: '55 ',
        isPaid: false,
        state: 'Delivered'),
  ];

  List<Order> get allOrders {
    return [..._orders];
  }

  List<Order> get preparingOrders {
    return _orders.where((order) => order.state == 'Preparing').toList();
  }

  List<Order> get onGoingOrders {
    return _orders.where((order) => order.state == 'on Going').toList();
  }

  List<Order> get deliveredOrders {
    return _orders.where((order) => order.state == 'Delivered').toList();
  }

  Future<void> fetchOrders() async {
    // final url = Uri.parse(
    //     'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final url = Uri.parse(
        'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final fetchedOrders = json.decode(response.body) == null
        ? null
        : json.decode(response.body) as Map<String, dynamic>;
    if (fetchedOrders == null) {
      return;
    }
    fetchedOrders.forEach((orderId, orderData) {
      loadedOrders.add(Order(
        id: orderId,
        name: orderData['name'],
        phoneNumber: orderData['phone_number'],
        location: orderData['location'],
        price: orderData['price'],
        date: DateTime.parse(orderData['time']),
        isPaid: orderData['ispaid'],
        state: orderData['state'],
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
