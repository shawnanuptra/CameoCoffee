import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Column(
          children: [
            // Bot Nav Bar
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

class BotNavBar extends StatelessWidget {
  const BotNavBar({
    Key? key,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex, super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.coffee_outlined), label: 'Menu'),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined), label: 'Activity'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: 'Settings'),
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
            Navigator.of(context).pushReplacementNamed(kMenuScreen);
            break;
          // Activity
          case 2:
            Navigator.of(context).pushReplacementNamed(kActivityScreen);
            break;
          // Setting
          case 3:
            Navigator.of(context).pushReplacementNamed(kSettingsScreen);
            break;
        }
      },
    );
  }
}
