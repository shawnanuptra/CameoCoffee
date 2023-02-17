import 'package:coffee_cameo/firebase_options.dart';
import 'package:coffee_cameo/screens/home_screen.dart';
import 'package:coffee_cameo/screens/login_screen.dart';
import 'package:coffee_cameo/screens/signup_screen.dart';
import 'package:coffee_cameo/screens/welcome_screen.dart';
import 'package:coffee_cameo/util/constants.dart';
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
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),

        // Default Font Family
        fontFamily: 'Quattrocento',

        textTheme: const TextTheme(
          // for titles/logo work
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSerifDisplay',
          ),
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
        ).apply(bodyColor: Colors.black87, displayColor: Colors.black87),

        // primarySwatch: Colors.brown,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/home":
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case "/welcome":
            return MaterialPageRoute(
                builder: (context) => const WelcomeScreen());
          case "/login":
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case "/signup":
            return MaterialPageRoute(
                builder: (context) => const SignUpScreen());
          default:
            return MaterialPageRoute(
                builder: (context) => const WelcomeScreen());
        }
      },
      // home: HomeScreen(),
    );
  }
}
