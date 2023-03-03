import 'package:coffee_cameo/components/Buttons.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool _passwordVisible = false;

  void _togglePasswordVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      text: 'Welcome,\n',
                      children: [
                        TextSpan(
                            text: 'happy to have you back!',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                      style: Theme.of(context).textTheme.headlineLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  //todo: use validator

                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                      // else if ()
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
                    validator: (value) {
                      // validates if password is filled
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                      // else if ()
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
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0)),
                      ),
                      onPressed: () {
                        // todo: navigation for forgot password
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
              PrimaryButton(
                  onClick: () async {
                    //todo: add validation before signing up etc
                    //todo: add proper messages
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            kHomeScreen, (route) => false);
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          // email is in wrong format
                          case 'invalid-email':
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter a correct email'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ));
                            break;
                            // wrong password for the email
                          case 'wrong-password':
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Wrong password. Retry.'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ));
                            break;
                            // email not found
                          case 'user-not-found':
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No user found with this email. Sign up instead?'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ));
                            break;
                            // if there's connection problem
                          case 'network-failed':
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Network has failed, please try again.'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ));

                                break;


                        }
                        if (e.code == 'invalid-email') {}

                        // handle error: show error message or whatever

                        print(e);
                      }
                    }
                  },
                  text: 'Log In'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(kSignUpScreen);
                    },
                    child: const Text(
                      "Sign up here.",
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
