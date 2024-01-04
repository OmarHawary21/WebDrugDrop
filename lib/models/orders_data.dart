import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Order with ChangeNotifier {
  final int id;
  final String name;
  final String phoneNumber;
  final String location;
  final String date;
  final int price;
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
}
