import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/category.dart';
import '../models/drug.dart';

class CategoriesProvider with ChangeNotifier {
  final String token;

  CategoriesProvider(this.token);

  List<Category> _categories = [];
  List<Drug> _categoryDrugs = [];

  List<Category> get categories {
    return [..._categories];
  }

  List<Drug> get categoryDrugs {
    return [..._categoryDrugs];
  }

  Category findById(int id){
    return _categories.firstWhere((cat) => cat.id == id);
  }

  Future<void> getCategories() async {
    final url = Uri.parse('http://$host/api/admin/category/get');

    final response = await http.get(url, headers: {
      // 'ngrok-skip-browser-warning': '1',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final data = json.decode(response.body);
    final categories = data['Data'] as List<dynamic>;
    final List<Category> temp = [];
    categories.forEach((category) {
      temp.add(
          Category(category['id'], category['en_name'], category['ar_name']));
    });
    _categories = temp;
  }

  Future<void> getCategoryDrugs(int id) async {
    final url =
        Uri.parse('http://$host/api/admin/drug/get/category/$id?lang_code=en');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    final responseData = data['Data'] as List<dynamic>;
    List<Drug> temp = [];
    responseData.forEach((drug) {
      temp.add(Drug(
        id: drug['id'],
        tagId: drug['tag_id'],
        imgUrl: drug['img_url'].toString(),
        dose: drug['dose'],
        quantity: drug['quantity'],
        price: drug['price'],
        expiryDate: drug['expiry_date'],
        englishTradeName: drug['trade_name'],
        englishScientificName: drug['scientific_name'],
        englishCompany: drug['company'],
        englishDoseUnit: drug['dose_unit'],
      ));
    });
    _categoryDrugs = temp;
  }
}
