import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/sidebar.dart';

class AddDrugScreen extends StatelessWidget {
  static const routeName = '/add-drug';

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var _constaints = BoxConstraints(
      maxHeight: media.size.height * 0.055,
      maxWidth: media.size.width * 0.2,
    );
    return Scaffold(
      body: Stack(
        children: [
          SlideInLeft(
            duration: Duration(milliseconds: 1000),
            child: Row(
              children: [
                DashboardScreen(),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: _form,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(
                                      child: Text('Scientific Name: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            filled: true,
                                            hintText: 'Paracetamol',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(
                                      child: Text('Company Name: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: 'Unipharma',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(child: Text('Expiry date: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: 'dd/MM/yyyy',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(
                                      child: Text('Quantity available: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: '30 piece',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: media.size.width * 0.02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(
                                      child: Text('Economic Name: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: 'Unadol',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(child: Text('Category: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: 'Analgesics',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(child: Text('Price: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: '5000 SP',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const FittedBox(
                                      child: Text('Dose: ')),
                                  SizedBox(
                                    width: media.size.width * 0.01,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            fillColor: const Color.fromRGBO(
                                                230, 240, 255, 1),
                                            filled: true,
                                            hintText: '500 ml',
                                            constraints: _constaints,
                                            isDense: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AddButton(),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.2,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const FittedBox(
          child: Text(
            'Add',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
