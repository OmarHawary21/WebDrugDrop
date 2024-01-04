import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_drug_drop/models/orders_data.dart';

import 'screens/log_in_screen.dart';
import 'screens/home_screen.dart';
import 'screens/category_drugs_screen.dart';
import 'screens/add_drug_screen.dart';
import 'screens/orders-screen.dart';
import 'screens/edit_drug_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/drugs_provider.dart';
import 'providers/categories_provider.dart';
import 'providers/orders_provider.dart';

const String  host = '192.168.43.239';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, DrugsProvider>(
          create: (_) => DrugsProvider(''),
          update: (_, auth, previous) => DrugsProvider(auth.getToken),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CategoriesProvider>(
          create: (_) => CategoriesProvider(''),
          update: (_, auth, previous) => CategoriesProvider(auth.getToken),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider(''),
          update: (_, auth, previous) => OrdersProvider(auth.getToken),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) {
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
            // home: HomeScreen(),
            home: auth.isAuth ? HomeScreen() : LogInScreen(),
            routes: {
              LogInScreen.routeName: (_) => LogInScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              CategoryDrugsScreen.routeName: (_) => CategoryDrugsScreen(),
              AddDrugScreen.routeName: (_) => AddDrugScreen(),
              OrdersScreen.routeName: (_) => OrdersScreen(),
              EditDrugScreen.routeName: (_) => EditDrugScreen(),
            },
          );
        },
      ),
    );
  }
}
