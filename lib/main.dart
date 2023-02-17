import 'package:coffee_cameo/firebase_options.dart';
import 'package:coffee_cameo/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.brown,

        // Default Font Family
        fontFamily: 'Quattrocento',

        textTheme: const TextTheme(
          // for titles/logo work
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSerifDisplay',
          ),
        ),

        primarySwatch: Colors.brown,
      ),
      home: const LoginScreen(),
    );
  }
}
