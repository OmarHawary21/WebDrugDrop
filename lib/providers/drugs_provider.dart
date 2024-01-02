import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/drug.dart';
import '../models/tag.dart';

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  List<Drug> _drugs = [
    Drug(id: 1, tagId: 1, imgUrl: 'imgUrl', dose: 100, quantity: 15, price: 15000, expiryDate: 'expiryDate'),
  ];

  List<Tag> _tags = [];

  List<Drug> get drugs {
    return [..._drugs];
  }

  List<Tag> get tags {
    return [..._tags];
  }

  Future<void> addDrug(Map<String, dynamic> data) async {
    final url = Uri.parse('http://$host/api/drug/create');
    var request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile.fromBytes('img_url', data['image']));
    request.fields['tagId'] = 'tagId';
    request.headers[''] = '';

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
            'quantity': data['quantity'],
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

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final responseData = json.decode(response.body);
    if (responseData['Status'] == 'Success') {
      List<dynamic> fetchedDrugs = responseData['Data'];
      List<Drug> temp = [];
      for (var drug in fetchedDrugs) {
        temp.add(Drug(
            id: drug['id'],
            tagId: drug['tag_id'],
            imgUrl: drug['img_url'].toString(),
            dose: drug['dose'],
            quantity: drug['quantitiy'],
            price: drug['price'],
            expiryDate: drug['expiry_date'],
            englishTradeName: drug['trade_name'],
            englishScientificName: drug['scientific_name'],
            englishCompany: drug['company'],
            englishDoseUnit: drug['dose_unit']));
      }
      _drugs = temp;
    } else {
      throw Exception(responseData['Message']);
    }
  }

  Future<void> getTags() async {
    final url = Uri.parse('http://$host/api/admin/tag/get');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final data = json.decode(response.body);
    final tags = data['Data'] as List<dynamic>;
    final List<Tag> temp = [];
    tags.forEach((tag) {
      temp.add(Tag(tag['id'], tag['en_name'], tag['ar_name']));
    });
    _tags = temp;
    print(_tags);
  }
}
