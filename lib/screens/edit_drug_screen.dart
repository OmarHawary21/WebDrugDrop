import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '../widgets/side_menu.dart';

class EditDrugScreen extends StatefulWidget {
  static const routeName = '/edit-drug';

  @override
  State<EditDrugScreen> createState() => _EditDrugScreenState();
}

class _EditDrugScreenState extends State<EditDrugScreen> {
  bool _isEditingPrice = false;
  bool _isEditingQuantity = false;
  String _dateInitValue = '2024-02-13';
  String _priceInitValue = '16000';
  String _quantityInitValue = '15';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SideMenu(),
          ),
          SizedBox(width: width * 0.05),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(width * 0.01),
                        child: Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.01),
                            border: Border.all(color: primary, width: 2),
                          ),
                          child: Image.asset('assets/images/Login.png'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  borderRadius: BorderRadius.circular(15),
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
                                          textDirection: TextDirection.ltr,
                                          decoration: InputDecoration(
                                            constraints: BoxConstraints(
                                              maxWidth: width * 0.2,
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade900),
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
                                            _priceInitValue =
                                                newValue.toString();
                                            setState(
                                                () => _isEditingPrice = false);
                                          },
                                          // onSaved: (value) => _data[dataName] = value.toString(),
                                        ),
                                    )
                                    : InkWell(
                                        onTap: () => setState(
                                            () => _isEditingPrice = true),
                                        child: SizedBox(
                                          width: width * 0.2,
                                          child: Center(
                                            child: Text(
                                              _priceInitValue,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(),
                                ),
                                child: _isEditingQuantity
                                    ? Center(
                                      child: TextFormField(
                                          autofocus: true,
                                          textAlign: TextAlign.center,
                                          initialValue: _quantityInitValue,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textDirection: TextDirection.ltr,
                                          decoration: InputDecoration(
                                            constraints: BoxConstraints(
                                              maxWidth: width * 0.2,
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade900),
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
                                            _quantityInitValue =
                                                newValue.toString();
                                            setState(() =>
                                                _isEditingQuantity = false);
                                          },
                                          // onSaved: (value) => _data[dataName] = value.toString(),
                                        ),
                                    )
                                    : InkWell(
                                        onTap: () => setState(
                                            () => _isEditingQuantity = true),
                                        child: SizedBox(
                                          width: width * 0.2,
                                          child: Center(
                                            child: Text(
                                              _quantityInitValue,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  borderRadius: BorderRadius.circular(15),
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
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FieldItem('trade Name', 'hint', 'trade name'),
                          FieldItem(
                              'scientific Name', 'hint', 'scientific name'),
                          FieldItem('company Name', 'hint', 'company'),
                          FieldItem('dose unit', 'hint', 'dose unit'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldItem(
                            'الاسم العلمي',
                            'hint',
                            'الاسم العلمي',
                            arabic: true,
                          ),
                          FieldItem(
                            'الاسم التجاري',
                            'hint',
                            'الاسم التجاري',
                            arabic: true,
                          ),
                          FieldItem(
                            'الشركة المصنعة',
                            'hint',
                            'الشركة المصنعة',
                            arabic: true,
                          ),
                          FieldItem(
                            'الواحدة',
                            'hint',
                            'الواحدة',
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}

class FieldItem extends StatelessWidget {
  final bool arabic;
  final String title;
  final String hint;
  final int maxLines;
  final String value;

  FieldItem(this.title, this.hint, this.value,
      {this.maxLines = 1, this.arabic = false});

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
