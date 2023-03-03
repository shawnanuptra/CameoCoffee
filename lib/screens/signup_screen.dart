import 'package:coffee_cameo/components/Buttons.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

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

  final _formKey = GlobalKey<FormState>();
  final _pass = TextEditingController();
  final _confPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 10,
            horizontal: 50.0),
        child: Form(
          key: _formKey,
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
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                      style: Theme.of(context).textTheme.headlineLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (EmailValidator.validate(value) == false) {
                        return 'Please enter a correct email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'latte.lover@coffee.com',
                        labelText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _pass,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
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
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confPass,
                    onChanged: (value) {
                      confPassword = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _confPass.value) {
                        return 'Passwords do not match.';
                      }
                      return null;
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
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              PrimaryButton(
                  onClick: () async {
                    //check if password and confPassword is the same, then try signing up to firebase
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            kHomeScreen, (route) => false);
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          // email is in wrong format
                          case 'invalid-email':
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please enter a correct email'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            break;
                          // if there's connection problem
                          case 'network-failed':
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Network has failed, please try again.'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            break;
                        }
                        print(e);
                      }
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
      ),
    );
  }
}
