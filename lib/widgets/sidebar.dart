import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var theme = Theme.of(context);
    return NavigationRail(
      unselectedIconTheme: IconThemeData(color: theme.colorScheme.background),
      unselectedLabelTextStyle: TextStyle(color: theme.colorScheme.background),
      selectedIconTheme:
          IconThemeData(color: theme.colorScheme.primary.withOpacity(0.5)),
      backgroundColor: theme.colorScheme.primary,
      destinations: [
        NavigationRailDestination(
            icon: IconButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              icon: Icon(Icons.menu),
              color: theme.colorScheme.background,
            ),
            label: Text('')),
        NavigationRailDestination(
          icon: Icon(
            Icons.account_circle,
            color: theme.colorScheme.background,
          ),
          label: Text(
            'Profile',
            style: TextStyle(
              color: theme.colorScheme.background,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.home,
            color: theme.colorScheme.background,
          ),
          label: Text(
            'Home',
            style: TextStyle(
              color: theme.colorScheme.background,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.add_circle,
            color: theme.colorScheme.background,
          ),
          label: Text(
            'Add Item',
            style: TextStyle(
              color: theme.colorScheme.background,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.settings,
            color: theme.colorScheme.background,
          ),
          label: Text(
            'Settings',
            style: TextStyle(
              color: theme.colorScheme.background,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.phone,
            color: theme.colorScheme.background,
          ),
          label: Text(
            'Contact Us',
            style: TextStyle(
              color: theme.colorScheme.background,
            ),
          ),
        ),
      ],
      selectedIndex: 0,
      extended: _isExpanded,
    );
  }
}
