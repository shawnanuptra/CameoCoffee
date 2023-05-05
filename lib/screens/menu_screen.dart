import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_cameo/model/menu_item_model.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:coffee_cameo/util/extension.dart';
import 'package:flutter/material.dart';

import '../components/botnavbar.dart';
import '../components/menu_components.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    const int _selectedIndex = 2;

    final List<MenuItem> menuItems = [];
    final Set<String> categories = {};

    Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        fetchMenu() async {
      var a = await db
          .collection(kMenuCollection)
          .get()
          .then((event) => event.docs);
      return a;
    }

    List<Widget> _getCatWidgets(Set<String> categories) {
      List<Widget> catWidgets = <Widget>[
        SizedBox(width: 10),
        MenuCategory(title: 'All'), // added manually bc no Special category
        SizedBox(width: 5),
        MenuCategory(title: 'Special'),
      ];

      categories.forEach((element) {
        catWidgets.add(SizedBox(width: 5));
        catWidgets.add(MenuCategory(title: element.capitalizeWord()));
      });
      catWidgets.add(SizedBox(width: 10));

      return catWidgets;
    }

    return FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      future: fetchMenu(),
      builder: (context,
          AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              snapshot) {
        if (snapshot.hasData) {
          var x = snapshot.data;
          if (x!.isNotEmpty) {
            for (var a in x) {
              var item = MenuItem.fromMap(a.data());
              print(a.data());
              menuItems.add(item);
              categories.add(item.category);
            }
          }
          Set<MenuItem> specials =
              menuItems.where((e) => e.special == true).toSet();

          return Scaffold(
            bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Title and search
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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

                  // Categories heading
                  SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1,
                          height: 2,
                          color: Colors.black87,
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Row(
                                children: _getCatWidgets(categories),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          height: 2,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        // SPECIALS
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kMainScreenHorizontalPadding,
                                ),
                                child: Text(
                                  'Specials',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: specials.length,
                                  itemBuilder: (context, index) {
                                    return MenuListTile(
                                      item: specials.elementAt(index),
                                      onClick: () {},
                                    );
                                  }),
                            ],
                          ),
                        ),

                        // CATEGORIES AUTO GENERATE AND CHILDREN
                        ListView.builder(
                            itemCount: categories.length,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, catIndex) {
                              String category = categories.elementAt(catIndex);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              kMainScreenHorizontalPadding),
                                      child: Text(
                                        category.capitalizeWord(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: menuItems
                                            .where(
                                                (e) => e.category == category)
                                            .toSet()
                                            .length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, itemIndex) {
                                          return MenuListTile(
                                              item: menuItems
                                                  .where((e) =>
                                                      e.category == category)
                                                  .toSet()
                                                  .elementAt(itemIndex));
                                        }),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            bottomNavigationBar: BotNavBar(selectedIndex: _selectedIndex),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
