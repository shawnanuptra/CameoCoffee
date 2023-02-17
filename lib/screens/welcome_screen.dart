import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: kScaffoldPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Image.asset('assets/icon.png'),
                height: 150,
                width: 150,
              ),
            ),
            RichText(
              text: TextSpan(
                  text: 'Cameo',
                  children: [
                    TextSpan(
                      text: 'Coffee',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: kSecondaryColor),
                    ),
                  ],
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: kPrimaryColor)),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              onClick: () {},
              text: 'Login',
            ),
            SecondaryButton(onClick: () {}, text: 'Sign up')
          ],
        ),
      ),
    );
  }
}