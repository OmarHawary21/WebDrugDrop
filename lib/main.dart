import 'package:flutter/material.dart';

import 'screens/log_in_screen.dart';
import 'screens/add_drug_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DrugDrop',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 252, 252, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(3, 37, 78, 1),
          secondary: const Color.fromRGBO(219, 243, 250, 1),
        ),
        appBarTheme: AppBarTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          color: const Color.fromRGBO(230, 240, 255, 1),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(3, 37, 78, 1),
            fontSize: 20,
            fontFamily: 'PollerOne',
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => LogInScreen(),
        AddDrugScreen.routeName: (_) => AddDrugScreen(),
      },
    );
  }
}
