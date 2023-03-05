import 'package:coffee_cameo/components/Buttons.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/botnavbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _selectedIndex = 3;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Column(
          children: [
            Text('My Profile', style: Theme.of(context).textTheme.headlineLarge,),
             PrimaryButton(
                onClick: () {
                  _auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(kWelcomeScreen, (route) => false);
                },
                text: 'Sign Out'),
          ],
        ),
      ),
    );
  }
}
