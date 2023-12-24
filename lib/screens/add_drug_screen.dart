import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/side_menu.dart';
import '../providers/drugs_provider.dart';

final Map<String, dynamic> _data = {
  'tagId': '',
  'price': '',
  'quantity': '',
  'expiryDate': '',
  'dose': '',
  'image': '',
  'scientificNameAR': '',
  'tradeNameAR': '',
  'companyAR': '',
  'descriptionAR': '',
  'doseUnitAR': '',
  'scientificNameEN': '',
  'tradeNameEN': '',
  'companyEN': '',
  'descriptionEN': '',
  'doseUnitEN': '',
};

final _form = GlobalKey<FormState>();

class AddDrugScreen extends StatelessWidget {
  static const routeName = '/add-drug';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            transform: Matrix4.translationValues(width * 0.12, 0, 0),
            child: SvgPicture.asset(
              'assets/images/Pharmacist.svg',
              height: double.infinity,
              width: double.infinity,
              color: Colors.white.withOpacity(0.05),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 1000),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SideMenu(),
                ),
                SizedBox(width: width * 0.05),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Form(
                      key: _form,
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Add a new drug:',
                              style: TextStyle(
                                fontSize: width * 0.015,
                                color: primary,
                                fontFamily: 'PollerOne',
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FieldItem('Scientific name', 'hint',
                                        'scientificNameEN'),
                                    FieldItem(
                                        'Trade name', 'hint', 'tradeNameEN'),
                                    FieldItem(
                                        'Company name', 'hint', 'companyEN'),
                                    FieldItem(
                                        'Dose unit', 'hint', 'doseUnitEN'),
                                    FieldItem(
                                      'Description',
                                      'hint',
                                      'descriptionEN',
                                      maxLines: 4,
                                      maxHeight: 0.09,
                                    ),
                                    FieldItem('Quantity available', 'hint',
                                        'quantity'),
                                    FieldItem('Price', 'hint', 'price'),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FieldItem(
                                      'الاسم العلمي',
                                      'hint',
                                      'scientificNameAR',
                                      arabic: true,
                                    ),
                                    FieldItem(
                                      'الاسم التجاري',
                                      'hint',
                                      'tradeNameAR',
                                      arabic: true,
                                    ),
                                    FieldItem(
                                      'الشركة المصنعة',
                                      'hint',
                                      'companyAR',
                                      arabic: true,
                                    ),
                                    FieldItem(
                                      'الواحدة',
                                      'hint',
                                      'doseUnitAR',
                                      arabic: true,
                                    ),
                                    FieldItem(
                                      'الوصف',
                                      'hint',
                                      'descriptionAR',
                                      maxLines: 4,
                                      maxHeight: 0.09,
                                      arabic: true,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        FieldItem('Expiry date', 'hint',
                                            'expiryDate'),
                                        FieldItem('Dose', 'hint', 'dose'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            AddButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.05),
              ],
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
  final String hint;
  final int maxLines;
  final double maxHeight;
  final String dataName;

  FieldItem(this.title, this.hint, this.dataName,
      {this.maxLines = 1, this.maxHeight = 0.045, this.arabic = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    final constraints = BoxConstraints(
      maxHeight: media.size.height * maxHeight,
      maxWidth: media.size.width * 0.15,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: media.size.height * 0.013),
      child: arabic
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textDirection: TextDirection.rtl,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    constraints: constraints,
                    hintText: hint,
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(color: Colors.grey.shade900),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'This field is required';
                    }
                  },
                  onSaved: (value) => _data[dataName] = value.toString(),
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
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textDirection: TextDirection.ltr,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    constraints: constraints,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey.shade900),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'This field is required';
                    }
                  },
                  onSaved: (value) => _data[dataName] = value.toString(),
                ),
              ],
            ),
    );
  }
}

class AddButton extends StatefulWidget {
  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _isLoading = false;

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'An error Occurred',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  void add() async {
    if (!_form.currentState!.validate()){
      return;
    }
    _form.currentState!.save();
    setState(() => _isLoading = true);
    await Provider.of<DrugsProvider>(context, listen: false)
        .addDrug(_data)
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => _showDialog(context, 'Something went wrong'),
        );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              strokeCap: StrokeCap.round,
            ),
          )
        : ElevatedButton(
            onPressed: add,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 16),
            ),
          );
  }
}
