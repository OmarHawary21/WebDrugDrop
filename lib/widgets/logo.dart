import 'dart:math';

import 'package:flutter/material.dart';

import '../icons/my_flutter_app_icons.dart';

class Logo extends StatelessWidget{
  final Color color;

  Logo({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'DrugDrop',
            style: TextStyle(
              color: color,
              fontSize: MediaQuery.of(context).size.width * 0.015,
              fontFamily: 'PollerOne',
            ),
          ),
          const SizedBox(width: 5),
          Transform.rotate(
            angle: 30 * pi / 180,
            child: Icon(
              MyFlutterApp.pills,
              color: const Color.fromRGBO(68, 191, 219, 1),
              size: MediaQuery.of(context).size.width * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}