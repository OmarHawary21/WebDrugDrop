import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;
import 'package:provider/provider.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../main.dart';
import '../models/category.dart';
import '../widgets/side_menu.dart';
import '../providers/drugs_provider.dart';
import '../providers/categories_provider.dart';

class EditDrugScreen extends StatefulWidget {
  static const routeName = '/edit-drug';

  @override
  State<EditDrugScreen> createState() => _EditDrugScreenState();
}

class _EditDrugScreenState extends State<EditDrugScreen> {
  late final id = ModalRoute.of(context)!.settings.arguments as int;
  late final drug = Provider.of<DrugsProvider>(context).drugInfo;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isInit = false;

  bool _isEditingPrice = false;
  bool _isEditingQuantity = false;
  bool _isEditingDescriptionEN = false;
  bool _isEditingDescriptionAR = false;
  bool _isEditingCategories = false;
  late String _dateInitValue = drug.expiryDate;
  late String _priceInitValue = drug.price.toString();
  late String _quantityInitValue = drug.quantity.toString();
  late String _enDescription = drug.englishDescription.toString();
  late String _arDescription = drug.arabicDescription.toString();
  List<int> selectedCategories = [1, 2];
  late Map<String, dynamic> _data = {
    'price': _priceInitValue,
    'quantity': _quantityInitValue,
    'expiry_date': _dateInitValue,
    'description_ar': _enDescription,
    'description_en': _arDescription,
    'categories': selectedCategories,
  };

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<DrugsProvider>(context).getDrugDetails(id);
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final List<Category> categories =
        Provider.of<CategoriesProvider>(context).categories;
    print('http://$host/${drug.imgUrl}');

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SideMenu(),
                ),
                SizedBox(width: width * 0.05),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                borderRadius:
                                    BorderRadius.circular(width * 0.01),
                                child: Container(
                                  width: width * 0.2,
                                  height: width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.01),
                                    border:
                                        Border.all(color: primary, width: 2),
                                  ),
                                  child: drug.imgUrl == 'null' ||
                                          drug.imgUrl.isEmpty
                                      ? Image.asset('assets/images/Login.png')
                                      : Image.network(
                                          'http://$host/${drug.imgUrl}',
                                        ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Price:',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: width * 0.015,
                                          color: primary,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        height: height * 0.06,
                                        margin: EdgeInsets.symmetric(
                                          vertical: height * 0.01,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(),
                                        ),
                                        child: _isEditingPrice
                                            ? Center(
                                                child: TextFormField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.center,
                                                  initialValue: _priceInitValue,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  decoration: InputDecoration(
                                                    constraints: BoxConstraints(
                                                      maxWidth: width * 0.2,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade900),
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    border: InputBorder.none,
                                                  ),
                                                  validator: (input) {
                                                    if (input!.isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                  onFieldSubmitted: (newValue) {
                                                    _priceInitValue =
                                                        newValue.toString();
                                                    setState(() =>
                                                        _isEditingPrice =
                                                            false);
                                                  },
                                                  // onSaved: (value) => _data[dataName] = value.toString(),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () => setState(() =>
                                                    _isEditingPrice = true),
                                                child: SizedBox(
                                                  width: width * 0.2,
                                                  child: Center(
                                                    child: Text(
                                                      _priceInitValue,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: width * 0.015,
                                                        color: primary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Quantity:',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: width * 0.015,
                                          color: primary,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        height: height * 0.06,
                                        margin: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(),
                                        ),
                                        child: _isEditingQuantity
                                            ? Center(
                                                child: TextFormField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.center,
                                                  initialValue:
                                                      _quantityInitValue,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  decoration: InputDecoration(
                                                    constraints: BoxConstraints(
                                                      maxWidth: width * 0.2,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade900),
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    border: InputBorder.none,
                                                  ),
                                                  validator: (input) {
                                                    if (input!.isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                  onFieldSubmitted: (newValue) {
                                                    _quantityInitValue =
                                                        newValue.toString();
                                                    setState(() =>
                                                        _isEditingQuantity =
                                                            false);
                                                  },
                                                  // onSaved: (value) => _data[dataName] = value.toString(),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () => setState(() =>
                                                    _isEditingQuantity = true),
                                                child: SizedBox(
                                                  width: width * 0.2,
                                                  child: Center(
                                                    child: Text(
                                                      _quantityInitValue,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: width * 0.015,
                                                        color: primary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Date:',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: width * 0.015,
                                          color: primary,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        height: height * 0.06,
                                        margin: EdgeInsets.symmetric(
                                          vertical: height * 0.01,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(),
                                        ),
                                        child: InkWell(
                                          onTap: () => showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 365),
                                            ),
                                          ).then(
                                            (newDate) => setState(
                                              () => _dateInitValue =
                                                  date.DateFormat('yyyy-MM-dd')
                                                      .format(newDate!),
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: width * 0.2,
                                            child: Center(
                                              child: Text(
                                                _dateInitValue,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: width * 0.015,
                                                  color: primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceAround,
                                  //   children: [
                                  //     Text(
                                  //       'Categories:',
                                  //       style: TextStyle(
                                  //         fontFamily: 'Poppins',
                                  //         fontSize: width * 0.015,
                                  //         color: primary,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 20),
                                  //     Container(
                                  //       height: height * 0.06,
                                  //       margin: EdgeInsets.symmetric(
                                  //           vertical: height * 0.01),
                                  //       padding: EdgeInsets.symmetric(
                                  //         horizontal: width * 0.02,
                                  //       ),
                                  //       decoration: BoxDecoration(
                                  //         borderRadius:
                                  //         BorderRadius.circular(15),
                                  //         border: Border.all(),
                                  //       ),
                                  //       child: _isEditingCategories
                                  //           ? MultiSelectDropDown(
                                  //         hintStyle: TextStyle(fontSize: width * 0.01),
                                  //         onOptionSelected: (value) {
                                  //           value.forEach((element) {
                                  //             if (!selectedCategories.contains(element.value)) {
                                  //               selectedCategories.add(element.value!.toInt());
                                  //             }
                                  //           });
                                  //         },
                                  //         onOptionRemoved: (value, valueItem) {
                                  //           selectedCategories.removeWhere((cat) => cat == valueItem.value);
                                  //         },
                                  //         options: categories
                                  //             .map(
                                  //               (category) => ValueItem(
                                  //             label: category.englishName,
                                  //             value: category.id,
                                  //           ),
                                  //         )
                                  //             .toList(),
                                  //       )
                                  //           : InkWell(
                                  //         onTap: () => setState(() =>
                                  //         _isEditingCategories = true),
                                  //         child: SizedBox(
                                  //           width: width * 0.2,
                                  //           child: Center(
                                  //             child: Text(
                                  //               selectedCategories.toString(),
                                  //               textAlign:
                                  //               TextAlign.center,
                                  //               style: TextStyle(
                                  //                 fontFamily: 'Poppins',
                                  //                 fontSize: width * 0.015,
                                  //                 color: primary,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              const SizedBox(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Description:',
                                    maxLines: 6,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: width * 0.015,
                                      color: primary,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    height: height * 0.18,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(),
                                    ),
                                    child: _isEditingDescriptionEN
                                        ? Center(
                                            child: TextFormField(
                                              autofocus: true,
                                              maxLines: 6,
                                              textAlign: TextAlign.center,
                                              initialValue: _enDescription,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textDirection: TextDirection.ltr,
                                              decoration: InputDecoration(
                                                constraints: BoxConstraints(
                                                  maxWidth: width * 0.2,
                                                ),
                                                hintStyle: TextStyle(
                                                    color:
                                                        Colors.grey.shade900),
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                border: InputBorder.none,
                                              ),
                                              validator: (input) {
                                                if (input!.isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              onFieldSubmitted: (newValue) {
                                                _enDescription =
                                                    newValue.toString();
                                                setState(() =>
                                                    _isEditingDescriptionEN =
                                                        false);
                                              },
                                              // onSaved: (value) => _data[dataName] = value.toString(),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () => setState(() =>
                                                _isEditingDescriptionEN = true),
                                            child: SizedBox(
                                              width: width * 0.2,
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    _enDescription,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: width * 0.015,
                                                      color: primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: height * 0.18,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(),
                                    ),
                                    child: _isEditingDescriptionAR
                                        ? Center(
                                            child: TextFormField(
                                              autofocus: true,
                                              maxLines: 6,
                                              textAlign: TextAlign.center,
                                              initialValue: _arDescription,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                constraints: BoxConstraints(
                                                  maxWidth: width * 0.2,
                                                ),
                                                hintStyle: TextStyle(
                                                    color:
                                                        Colors.grey.shade900),
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                border: InputBorder.none,
                                              ),
                                              validator: (input) {
                                                if (input!.isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              onFieldSubmitted: (newValue) {
                                                _arDescription =
                                                    newValue.toString();
                                                setState(() =>
                                                    _isEditingDescriptionAR =
                                                        false);
                                              },
                                              // onSaved: (value) => _data[dataName] = value.toString(),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () => setState(() =>
                                                _isEditingDescriptionAR = true),
                                            child: SizedBox(
                                              width: width * 0.2,
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    _arDescription,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: width * 0.015,
                                                      color: primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'الوصف:',
                                    textDirection: TextDirection.rtl,
                                    maxLines: 6,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: width * 0.015,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FieldItem(
                                      'trade Name', drug.englishTradeName),
                                  FieldItem('scientific Name',
                                      drug.englishScientificName),
                                  FieldItem(
                                      'company Name', drug.englishCompany),
                                  FieldItem('dose unit', drug.englishDoseUnit),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FieldItem(
                                    'الاسم التجاري',
                                    drug.arabicTradeName,
                                    arabic: true,
                                  ),
                                  FieldItem(
                                    'الاسم العلمي',
                                    drug.arabicScientificName,
                                    arabic: true,
                                  ),
                                  FieldItem(
                                    'الشركة المصنعة',
                                    drug.arabicCompany,
                                    arabic: true,
                                  ),
                                  FieldItem(
                                    'الواحدة',
                                    drug.arabicDoseUnit,
                                    arabic: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: width * 0.265),
          _isSaving
              ? CircularProgressIndicator()
              : FloatingActionButton(
                  onPressed: () async {
                    setState(() => _isSaving = true);
                    await Provider.of<DrugsProvider>(context, listen: false)
                        .updateDrug(id, _data);
                    setState(() => _isSaving = false);
                  },
                  backgroundColor: const Color.fromRGBO(68, 191, 219, 1),
                  child: const Icon(
                    Icons.save,
                  ),
                ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('(DrugName)'),
                content: const Text('Are you sure about deleting this drug?'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class FieldItem extends StatelessWidget {
  final bool arabic;
  final String title;
  final int maxLines;
  final String value;

  FieldItem(this.title, this.value, {this.maxLines = 1, this.arabic = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: media.size.height * 0.013),
      child: arabic
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.17,
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        value,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: MediaQuery.of(context).size.width * 0.015,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  ':$title',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: media.size.width * 0.015,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$title:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: media.size.width * 0.015,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.17,
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        value,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: MediaQuery.of(context).size.width * 0.015,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
