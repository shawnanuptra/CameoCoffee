import 'package:coffee_cameo/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../components/botnavbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      // make sure there is a user loggedIn
      loggedInUser = _auth.currentUser!;
      print(loggedInUser);
    } catch (e) {
      // if no user is logged in, loggedInUser = _auth.currentUser will return error
      // we can handle this error by redirecting to WelcomeScreen()

      // fixed bug
      // https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(kWelcomeScreen, (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: kMainScreenHorizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                        "Welcome, "
                        // "${loggedInUser.email}"
                        ,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.settings_outlined))
                ],
              ),
              const Divider(
                height: 2,
                color: Colors.black87,
                thickness: 2,
              ),

              Text("Rewards", style: Theme.of(context).textTheme.headlineSmall),

              // Rewards, inspired by Costa
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "1",
                            style: Theme.of(context).textTheme.headlineLarge,
                            children: [
                              TextSpan(
                                  text: '/8',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              TextSpan(
                                  text: ' rewards',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
