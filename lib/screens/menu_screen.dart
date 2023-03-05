import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/botnavbar.dart';
import '../components/menu_components.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title and search
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_outlined),
                  ),
                ],
              ),
            ),

            // categories heading
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        MenuCategory(title: 'Special'),
                        MenuCategory(title: 'Special'),
                        MenuCategory(title: 'Special'),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),

            // menu
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  // SPECIALS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMainScreenHorizontalPadding),
                        child: Text(
                          'Specials',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        height: 90,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: 30),
                            SpecialCard(text: 'Pumpkin Spiced Latte'),
                            SpecialCard(text: 'Pumpkin Spiced Latte'),
                            SpecialCard(text: 'Pumpkin Spiced Latte'),
                            SizedBox(width: 30),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // OTHER CATEGORIES
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMainScreenHorizontalPadding),
                        child: Text(
                          'Hot Drinks',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),

                      // List of Items
                      MenuItem(
                        name: 'Espresso',
                        price: 2,
                        description: 'Description of espresso',
                      ),
                      MenuItem(
                        name: 'Espresso',
                        price: 2,
                        description: 'Description of espresso',
                      ),
                      MenuItem(
                        name: 'Espresso',
                        price: 2,
                        description: 'Description of espresso',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
