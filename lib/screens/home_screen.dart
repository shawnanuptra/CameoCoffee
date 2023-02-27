import 'package:flutter/material.dart';
import '../components/botnavbar.dart';

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

