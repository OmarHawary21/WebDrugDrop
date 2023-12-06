import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../widgets/side_menu.dart';

class AddDrugScreen extends StatelessWidget {
  static const routeName = '/add-drug';

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: SlideInLeft(
        duration: const Duration(milliseconds: 1000),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SideMenu(),
            ),
            Expanded(
              flex: 6,
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Row(),
                    Column(),
                    AddButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
