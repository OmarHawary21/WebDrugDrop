import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../screens/edit_drug_screen.dart';

class DrugItem extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final String imageUrl;

  DrugItem(this.id, this.name, this.price, this.imageUrl);

  @override
  State<DrugItem> createState() => _DrugItemState();
}

class _DrugItemState extends State<DrugItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    return MouseRegion(
      onEnter: (value) => setState(() => _hover = true),
      onExit: (value) => setState(() => _hover = false),
      child: Container(
        decoration: BoxDecoration(
          color: secondary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/Login.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.08,
                      child: Text(
                        widget.name,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: primary,
                          fontSize: width * 0.013,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      '${widget.price} S.P',
                      style: TextStyle(
                        color: primary,
                        fontSize: width * 0.013,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _hover,
              child: FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primary.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _hover,
              child: FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: SizedBox(
                    height: height * 0.06,
                    width: width * 0.1,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        EditDrugScreen.routeName,
                        arguments: widget.id,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          'See Details!',
                          style: TextStyle(
                            fontSize: width * 0.011,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
