import 'package:flutter/material.dart';

import '../components/botnavbar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              // vertical: MediaQuery.of(context).size.height / 10,
              vertical: 50,
              horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Text(
                    'Rewards',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
              const Divider(
                height: 2,
                color: Colors.black87,
                thickness: 2,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy 8 get next one free!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        width: 300,
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(
                            8,
                            (index) => Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Theme.of(context).colorScheme.background),
                              child: Text('${index}'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scan to earn rewards!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Flexible(
                        child: SizedBox.square(
                          // width: 150,
                          // height: 200,
                          // size: Size.fromWidth(double.infinity),
                          dimension: 300,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
