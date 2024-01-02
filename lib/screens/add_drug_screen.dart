import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart' as date;
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../widgets/side_menu.dart';
import '../models/category.dart';
import '../models/tag.dart';
import '../providers/drugs_provider.dart';
import '../providers/categories_provider.dart';

DateTime? pickedDate;
Uint8List selectedImage = Uint8List(8);
int? selectedTag;
List<int> selectedCategories = [];
final Map<String, dynamic> _data = {
  'tagId': selectedTag,
  'price': '',
  'quantity': '',
  'expiryDate': date.DateFormat('yyyy-MM-dd').format(pickedDate!),
  'dose': '',
  'categories': selectedCategories,
  'image': selectedImage,
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

class AddDrugScreen extends StatefulWidget {
  static const routeName = '/add-drug';

  @override
  State<AddDrugScreen> createState() => _AddDrugScreenState();
}

class _AddDrugScreenState extends State<AddDrugScreen> {
  int _currentStep = 0;
  bool didSelect = false;
  bool _isLoading = false;

  void _pickImage() async {
    final data = ImagePicker();
    final file = await data.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _isLoading = true);
      var selected = await file.readAsBytes();
      setState(() {
        _isLoading = false;
        selectedImage = selected;
        didSelect = true;
      });
    }
  }

  List<Step> steps(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final List<Tag> tags = Provider.of<DrugsProvider>(context).tags;
    final List<Category> categories =
        Provider.of<CategoriesProvider>(context).categories;

    return [
      Step(
        isActive: _currentStep == 0,
        title: const Text('Arabic Info'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
            FieldItem(
              'الوصف',
              'hint',
              'descriptionAR',
              maxLines: 12,
              arabic: true,
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 1,
        title: const Text('English Info'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FieldItem(
                  'Scientific name',
                  'hint',
                  'scientificNameEN',
                ),
                FieldItem(
                  'Trade name',
                  'hint',
                  'tradeNameEN',
                ),
                FieldItem(
                  'Company name',
                  'hint',
                  'companyEN',
                ),
                FieldItem(
                  'Dose unit',
                  'hint',
                  'doseUnitEN',
                ),
              ],
            ),
            FieldItem(
              'Description',
              'hint',
              'descriptionEN',
              maxLines: 12,
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 2,
        title: const Text('Other Info'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'Tag:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: width * 0.015,
                        color: primary,
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    DropdownButton<int>(
                      value: selectedTag,
                      hint: const Text('No tag selected'),
                      borderRadius: BorderRadius.circular(15),
                      focusColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      underline: Container(
                        height: 2,
                        color: primary,
                      ),
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.011,
                      ),
                      items: tags
                          .map(
                            (tag) => DropdownMenuItem<int>(
                              value: tag.id,
                              child: Text(tag.englishName),
                            ),
                          )
                          .toList(),
                      onChanged: (int? value) {
                        setState(() => selectedTag = value);
                      },
                    ),
                  ],
                ),
                FieldItem(
                  'Price',
                  'hint',
                  'price',
                ),
                FieldItem(
                  'Quantity',
                  'hint',
                  'quantity',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expiry Date:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: width * 0.015,
                        color: primary,
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.013),
                      height: height * 0.06,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.01,
                              ),
                              child: pickedDate == null
                                  ? Text(
                                      'No date picked yet',
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.9),
                                        fontSize: width * 0.011,
                                      ),
                                    )
                                  : Text(
                                      date.DateFormat('dd/MMM/yyyy')
                                          .format(pickedDate!),
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: width * 0.011,
                                      ),
                                    ),
                            ),
                            IconButton(
                              onPressed: () => showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              ).then((value) =>
                                  setState(() => pickedDate = value)),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: primary,
                                size: width * 0.015,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                FieldItem(
                  'Dose',
                  'hint',
                  'dose',
                ),
                Container(
                  width: width * 0.25,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                    color: Colors.transparent,
                  ),
                  child: MultiSelectDropDown(
                    // chipConfig: ChipConfig(backgroundColor: Colors.red),
                    hint: 'select categories',
                    hintStyle: TextStyle(fontSize: width * 0.01),
                    onOptionSelected: (value) {
                      value.forEach((element) {
                        print(element);
                        if (!selectedCategories.contains(element.value)) {
                          selectedCategories.add(element.value!.toInt());
                        } else {
                          // selectedCategories.removeWhere((cat) => cat == element.value);
                        }
                      });
                    },
                    onOptionRemoved: (value, valueItem) {
                      selectedCategories.removeWhere((cat) => cat == valueItem.value);
                      print(selectedCategories);
                    },
                    options: categories
                        .map(
                          (category) => ValueItem(
                            label: category.englishName,
                            value: category.id,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 3,
        title: const Text('Upload an Image'),
        content: Row(
          children: [
            !didSelect
                ? DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(15),
                    strokeCap: StrokeCap.round,
                    color: primary,
                    dashPattern: const [8, 8],
                    child: InkWell(
                      onTap: _pickImage,
                      child: Container(
                        height: height * 0.3,
                        width: height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 75,
                              color: primary,
                            ),
                            Text(
                              'Upload an Image',
                              style: TextStyle(
                                color: primary,
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : _isLoading
                    ? CircularProgressIndicator(color: primary)
                    : SizedBox(
                        height: height * 0.3,
                        width: height * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            selectedImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
          ],
        ),
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    Provider.of<DrugsProvider>(context).getTags();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _form.currentState?.dispose();
    super.dispose();
  }

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _form,
                          child: Stepper(
                            currentStep: _currentStep,
                            onStepCancel: () {
                              if (_currentStep > 0) {
                                setState(() => _currentStep--);
                              }
                            },
                            onStepContinue: () {
                              final isLast = _currentStep == 3;
                              if (isLast) {
                                print(selectedCategories);
                              } else {
                                setState(() => _currentStep++);
                              }
                            },
                            onStepTapped: (index) =>
                                setState(() => _currentStep = index),
                            steps: steps(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AddButton(),
                        ),
                      ],
                    ),
                  ),
                ),
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
  final String dataName;

  FieldItem(this.title, this.hint, this.dataName,
      {this.maxLines = 1, this.arabic = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    final constraints = BoxConstraints(
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
    if (!_form.currentState!.validate()) {
      return;
    }
    if (pickedDate == null) {
      _showDialog(context, 'Expiry date is required.');
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
