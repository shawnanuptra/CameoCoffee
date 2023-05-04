import 'package:flutter/material.dart';

import '../util/constants.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: (_selectedIndex == 0)
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: (_selectedIndex == 1)
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border_outlined),
            label: 'Rewards'),
        BottomNavigationBarItem(
            icon: (_selectedIndex == 2)
                ? const Icon(Icons.coffee)
                : const Icon(Icons.coffee_outlined),
            label: 'Menu'),
        BottomNavigationBarItem(
            icon: (_selectedIndex == 3)
                ? const Icon(Icons.receipt)
                : const Icon(Icons.receipt_outlined),
            label: 'Activity'),
        BottomNavigationBarItem(
            icon: (_selectedIndex == 4)
                ? const Icon(Icons.settings)
                : const Icon(Icons.settings_outlined),
            label: 'Settings'),
      ],
      currentIndex: _selectedIndex,
      onTap: (int index) {
        switch (index) {
          // Home
          case 0:
            Navigator.of(context).pushReplacementNamed(kHomeScreen);
            break;
          // Menu
          case 1:
            Navigator.of(context).pushReplacementNamed(kRewardsScreen);
            break;
          // Menu
          case 2:
            Navigator.of(context).pushReplacementNamed(kMenuScreen);
            break;
          // Activity
          case 3:
            Navigator.of(context).pushReplacementNamed(kActivityScreen);
            break;
          // Setting
          case 4:
            Navigator.of(context).pushReplacementNamed(kSettingsScreen);
            break;
        }
      },
    );
  }
}
