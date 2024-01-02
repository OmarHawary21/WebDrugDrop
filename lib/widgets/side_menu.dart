import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'logo.dart';
import '../screens/add_drug_screen.dart';
import '../screens/home_screen.dart';
import '../screens/log_in_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth_provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    );
    return Drawer(
      backgroundColor: primary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(flex: 1),
            SizedBox(
              height: size.height * 0.15,
              child: Logo(),
            ),
            const Spacer(flex: 2),
            ListTile(
              hoverColor: secondary.withOpacity(0.2),
              shape: shape,
              leading: Icon(
                Icons.home,
                color: secondary,
                size: MediaQuery.of(context).size.width * 0.018,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: secondary,
                  fontSize: MediaQuery.of(context).size.width * 0.01,
                ),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName),
            ),
            const Spacer(flex: 1),
            ListTile(
              hoverColor: secondary.withOpacity(0.2),
              shape: shape,
              leading: Icon(
                Icons.medical_services,
                color: secondary,
                size: MediaQuery.of(context).size.width * 0.018,
              ),
              title: Text(
                'Add Drug',
                style: TextStyle(
                  color: secondary,
                  fontSize: MediaQuery.of(context).size.width * 0.01,
                ),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(AddDrugScreen.routeName),
            ),
            const Spacer(flex: 1),
            ListTile(
              hoverColor: secondary.withOpacity(0.2),
              shape: shape,
              leading: Icon(
                Icons.local_shipping,
                color: secondary,
                size: MediaQuery.of(context).size.width * 0.018,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  color: secondary,
                  fontSize: MediaQuery.of(context).size.width * 0.01,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
            ),
            const Spacer(flex: 5),
            ListTile(
              hoverColor: secondary.withOpacity(0.2),
              shape: shape,
              leading: Icon(
                Icons.logout,
                color: secondary,
                size: MediaQuery.of(context).size.width * 0.018,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: secondary,
                  fontSize: MediaQuery.of(context).size.width * 0.01,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LogInScreen.routeName, (route) => false);
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
