import 'package:coffee_cameo/components/Buttons.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String email = '';
  String password = '';
  String confPassword = '';

  void _togglePasswordVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleConfPasswordVisible() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery
                .of(context)
                .size
                .height / 10,
            horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                    text: 'Hello there,\n',
                    children: [
                      TextSpan(
                          text: 'Excited to work with you!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall),
                    ],
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge),
                textAlign: TextAlign.center,
              ),
            ),
            //todo: use validator
            Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'latte.lover@coffee.com',
                      labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                //todo: use validator
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: _passwordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisible,
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    confPassword = value;
                  },
                  obscureText: _confirmPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: _toggleConfPasswordVisible,
                      icon: Icon(_confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            PrimaryButton(
                onClick: () async {
                  //todo: add validation before signing up etc
                  try {
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(kHomeScreen, (route) => false);
                  } catch (e) {
                    // handle error: show error message or whatever
                    print(e);
                  }
                },
                text: 'Sign Up'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(kLogInScreen);
                  },
                  child: const Text(
                    "Log in here.",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
