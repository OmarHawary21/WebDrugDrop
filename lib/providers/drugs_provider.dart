import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import '../main.dart';
import '../models/drug.dart';

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  List<Drug> _drugs = [];

  List<Drug> get drugs {
    return [..._drugs];
  }

  Future<void> addDrug(Map<String, dynamic> data) async {
    final url = Uri.parse('http://$host/api/drug/create');

    try {
      final response = await http.put(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, dynamic>{
            'tag_id': '1',
            'price': data['price'],
            'quantitiy': data['quantity'],
            'expiry_date': data['expiryDate'],
            'dose': data['dose'],
            'img': null,
            'scientific_name_ar': data['scientificNameAR'],
            'trade_name_ar': data['tradeNameAR'],
            'company_ar': data['companyAR'],
            'description_ar': data['descriptionAR'],
            'dose_unit_ar': data['doseUnitAR'],
            'scientific_name_en': data['scientificNameEN'],
            'trade_name_en': data['tradeNameEN'],
            'company_en': data['companyEN'],
            'description_en': data['descriptionEN'],
            'dose_unit_en': data['doseUnitEN'],
            'category': [1, 2],
          }));
      final responseData = json.decode(response.body);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchDrugsEnglish() async {
    final url = Uri.parse('http://$host/api/drug/get?lang_code=en');
    print(url);
    print('$token------------------');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final responseData = json.decode(response.body);
    if (responseData['Status'] == 'Success') {
      List<dynamic> fetchedDrugs = responseData['Data'];
      for (var drug in fetchedDrugs) {
        _drugs.add(Drug(
        id: drug['id'].toString(),
        tagId: drug['tag_id'].toString(),
        imgUrl: drug['img_url'].toString(),
        dose: drug['dose'].toString(),
        quantity: drug['quantitiy'].toString(),
        price: drug['price'].toString(),
        expiryDate: drug['expiry_date'],
        englishTradeName: drug['trade_name'],
        englishScientificName: drug['scientific_name'],
        englishCompany: drug['company'],
        englishDoseUnit: drug['dose_unit']
      ));
      }
      print(_drugs);
    } else {
      throw Exception(responseData['Message']);
    }
    print(json.decode(response.body));
  }
}
