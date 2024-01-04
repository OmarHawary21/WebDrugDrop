import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/drug.dart';
import '../models/tag.dart';

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  Drug _drugInfo = Drug(id: 0, tagId: 0, imgUrl: '', dose: 0, quantity: 0, price: 0, expiryDate: '');

  List<Drug> _drugs = [];

  List<Drug> _searchedDrugs = [];

  List<Tag> _tags = [];

  Drug get drugInfo {
    return _drugInfo;
  }

  List<Drug> get drugs {
    return [..._drugs];
  }

  List<Drug> get searchedDrugs {
    return [..._searchedDrugs];
  }

  List<Tag> get tags {
    return [..._tags];
  }

  Future<void> getResult(String value) async {
    print('getting results');
    var url;
    print('$value');

    url = Uri.http(
        host, '/api/search/drug', {'lang_code': 'en', 'search': value});

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<Drug> loadedDrugs = [];
      if (extractedData == Null) {
        return;
      }
      print(extractedData);

      extractedData['Data'].forEach((drug) {
        loadedDrugs.add(
          Drug(
              id: drug['id'],
              englishTradeName: drug['trade_name'],
              englishScientificName: drug['scientific_name'],
              englishCompany: drug['company'],
              tagId: drug['tag_id'],
              dose: drug['dose'],
              englishDoseUnit: drug['dose_unit'],
              price: drug['price'],
              quantity: drug['quantity'],
              expiryDate: drug['expiry_date'].toString(),
              imgUrl: drug['img_url'] ?? 'null'),
        );
      });
      _searchedDrugs = loadedDrugs;

      notifyListeners();
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }

  Future<void> addDrug(Map<String, dynamic> data) async {
    final url = Uri.parse('http://$host/api/admin/drug/create');

    Map<String, String> headers = {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    List<int> catList = data['categories'] as List<int>;

    Map<String, String> body = {
      '_method': 'PUT',
      'tag_id': data['tagId'].toString(),
      'price': data['price'].toString(),
      'quantity': data['quantity'].toString(),
      'expiry_date': data['expiryDate'],
      'dose': data['dose'].toString(),
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
    };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.fields.addAll(body);
    for (int i = 0; i < catList.length; i++) {
      request.fields['category[$i]'] = catList[i].toString();
    }

    request.files.add(http.MultipartFile.fromBytes(
      'img_url',
      data['image'],
      filename: 'pop_cat.png',
    ));

    final response = await request.send();

    final responseBytes = await response.stream.toBytes();
    final responseData = String.fromCharCodes(responseBytes);

    // try {
    //   final response = await http.put(
    //     url,
    //     headers: {
    //       'Content-type': 'multipart/form-data',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token',
    //     },
    //     body: jsonEncode(
    //       <String, dynamic>{
    //         'tag_id': '1',
    //         'price': '1600',
    //         'quantity': '15',
    //         'expiry_date': '2024-12-31',
    //         'dose': '100',
    //         'scientific_name_ar': 'عمر',
    //         'trade_name_ar': 'عمر',
    //         'company_ar': 'هواري',
    //         'description_ar': 'عمر',
    //         'dose_unit_ar': 'مل',
    //         'scientific_name_en': 'Omar',
    //         'trade_name_en': 'Omar',
    //         'company_en': 'Hawary',
    //         'description_en': 'Omar',
    //         'dose_unit_en': 'ml',
    //         'category': '1',
    //         'tag_id': data['tagId'],
    //         'price': data['price'],
    //         'quantity': data['quantity'],
    //         'expiry_date': data['expiryDate'],
    //         'dose': data['dose'],
    //         'img': data['image'],
    //         'scientific_name_ar': data['scientificNameAR'],
    //         'trade_name_ar': data['tradeNameAR'],
    //         'company_ar': data['companyAR'],
    //         'description_ar': data['descriptionAR'],
    //         'dose_unit_ar': data['doseUnitAR'],
    //         'scientific_name_en': data['scientificNameEN'],
    //         'trade_name_en': data['tradeNameEN'],
    //         'company_en': data['companyEN'],
    //         'description_en': data['descriptionEN'],
    //         'dose_unit_en': data['doseUnitEN'],
    //         'category': data['categories'],
    //       },
    //     ),
    //   );
    //   final responseData = json.decode(response.body);
    //   print(responseData);
    // } catch (error) {
    //   print(error);
    //   rethrow;
    // }
  }

  Future<void> updateDrug(int id, Map<String, dynamic> data) async {
    final url = Uri.parse('http://$host/api/admin/drug/update/$id');

    Map<String, String> headers = {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    List<int> catList = data['categories'] as List<int>;

    Map<String, String> body = {
      '_method': 'PATCH',
      'price': data['price'].toString(),
      'quantity': data['quantity'].toString(),
      'expiry_date': data['expiry_date'],
      'description_ar': data['description_ar'],
      'description_en': data['description_en'],
    };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.fields.addAll(body);
    for (int i = 0; i < catList.length; i++) {
      request.fields['category[$i]'] = catList[i].toString();
    }

    // request.files.add(http.MultipartFile.fromBytes(
    //   'img_url',
    //   data['image'],
    //   filename: 'pop_cat.png',
    // ));

    final response = await request.send();

    final responseBytes = await response.stream.toBytes();
    final responseData = String.fromCharCodes(responseBytes);

    print(responseData);
  }

  Future<void> fetchDrugsEnglish() async {
    final url = Uri.parse('http://$host/api/drug/get?lang_code=en');

    final response = await http.get(url, headers: {
      // 'ngrok-skip-browser-warning': '1',
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
            quantity: drug['quantity'],
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

  Future<void> getDrugDetails(int id) async {
    final url = Uri.parse('http://$host/api/drug/get/$id?lang_code=en');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'content-type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    final drugData = data['Data'];
    print(data);

    _drugInfo = Drug(
      id: drugData['id'],
      tagId: drugData['tag_id'],
      imgUrl: drugData['img_url'].toString(),
      dose: drugData['dose'],
      quantity: drugData['quantity'],
      price: drugData['price'],
      expiryDate: drugData['expiry_date'],
      englishTradeName: drugData['trade_name_en'],
      englishScientificName: drugData['scientific_name_en'],
      englishCompany: drugData['company_en'],
      englishDoseUnit: drugData['dose_unit_en'],
      englishDescription: drugData['description_en'],
      arabicTradeName: drugData['trade_name_ar'],
      arabicScientificName: drugData['scientific_name_ar'],
      arabicCompany: drugData['company_ar'],
      arabicDoseUnit: drugData['dose_unit_ar'],
      arabicDescription: drugData['description_ar'],
    );
  }

  Future<void> getTags() async {
    final url = Uri.parse('http://$host/api/admin/tag/get');

    final response = await http.get(url, headers: {
      // 'ngrok-skip-browser-warning': '1',
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
  }
}
