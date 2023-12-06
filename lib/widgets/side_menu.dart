import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_drug_drop/widgets/logo.dart';

import '../providers/auth_provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: primary,
      child: Column(
        children: [
          AppBar(
            title: Logo(),
            automaticallyImplyLeading: false,
          ),
          SizedBox(height: size.height * 0.01),
          Card(
            color: primary,
            elevation: 2,
            child: ListTile(
              leading: Icon(
                Icons.medical_services,
                color: secondary,
              ),
              title: Text(
                'Add Drug',
                style: TextStyle(color: secondary),
              ),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Card(
            color: primary,
            elevation: 2,
            child: ListTile(
              leading: Icon(
                Icons.local_shipping,
                color: secondary,
              ),
              title: Text(
                'Orders',
                style: TextStyle(color: secondary),
              ),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Card(
            color: primary,
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.logout, color: secondary,),
              title: Text(
                'Logout',
                style: TextStyle(color: secondary),
              ),
              onTap: () => Provider.of<AuthProvider>(context, listen: false).logout(),
            ),
          ),
        ],
      ),
    );
  }
}
