import 'package:coffee_cameo/screens/item_screen.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';

import '../components/botnavbar.dart';
import '../components/menu_components.dart';
import '../model/item_class.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final int _selectedIndex = 2;

  late final List<Item> items = [
    Item('Espresso1', 'description', 3, 'category', 'itemSettings'),
    Item('Espresso2', 'description', 3, 'category', 'itemSettings'),
    Item('Espresso3', 'description', 3, 'category', 'itemSettings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Title and search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    mainAxisSize: MainAxisSize.max,
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

                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return MenuItem(
                            item: items[index],
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ItemScreen(items[index])));
                            },
                          );
                        },
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
