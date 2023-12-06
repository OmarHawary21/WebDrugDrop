import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/log_in_screen.dart';
import 'screens/add_drug_screen.dart';
import 'providers/auth_provider.dart';

const String host = '192.168.43.239';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) => MaterialApp(
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
                  bottomRight: Radius.elliptical(100, 50),
                  bottomLeft: Radius.elliptical(100, 50),
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.25,
              color: const Color.fromRGBO(230, 240, 255, 1),
              titleTextStyle: const TextStyle(
                color: Color.fromRGBO(3, 37, 78, 1),
                fontSize: 20,
                fontFamily: 'PollerOne',
              ),
            ),
          ),
          // home: auth.isAuth ? AddDrugScreen() : LogInScreen(),
          home: AddDrugScreen(),
          routes: {
            LogInScreen.routeName: (_) => LogInScreen(),
            AddDrugScreen.routeName: (_) => AddDrugScreen(),
          },
        ),
      ),
    );
  }
}
