import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_cameo/model/menu_item_model.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:coffee_cameo/util/extension.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen(this.item, {Key? key}) : super(key: key);

  final MenuItem item;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool userFavourite = false;

  void toggleFavourite() {
    setState(() {
      userFavourite = !userFavourite;
      // todo: add to userFavourites
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> fetchItemSettings() async {
      var a = await FirebaseFirestore.instance
          .collection(kItemSettingsCollection)
          .doc('settings')
          .get()
          .then((value) => value);
      return a;
    }

    Map<String, dynamic> itemSettings = widget.item.itemSettings.toMap();
    itemSettings.removeWhere((key, value) => value == null); // remove unused itemSettings
    Map<String, dynamic>? fireStoreData = {};

    print(itemSettings);
    return Scaffold(
      appBar: ItemAppBar(
          userFavourite: userFavourite, toggleFavourite: toggleFavourite),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Item',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        onPressed: () {
          // todo: add this to bag
        },
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.item.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Card(
                      child: SvgPicture.asset(
                          'assets/${widget.item.name.toKebabCase()}.svg'),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      color: Colors.yellow[100],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      widget.item.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: fetchItemSettings(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.data != null) {
                              fireStoreData = snapshot.data!.data();

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: itemSettings.keys.length,
                                itemBuilder: (context, index) {
                                  String currentSetting =
                                      itemSettings.keys.elementAt(index);
                                  if (fireStoreData![currentSetting] != null) {
                                    print(currentSetting);
                                    print(fireStoreData![currentSetting]);
                                    List<String> options = [];
                                    // manual casting to List<dynamic>
                                    List<dynamic> y =
                                        fireStoreData![currentSetting];

                                    // List<String> of options of itemSettings
                                    y.forEach((e) {
                                      options.add(e.toString());
                                    });

                                    return Column(
                                      children: [
                                        Text(
                                          currentSetting.capitalizeWord(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        CustomRadioButton(
                                          key: GlobalKey(),
                                          defaultSelected: options[0],
                                          enableShape: true,
                                          shapeRadius: 50,
                                          elevation: 0,
                                          // absoluteZeroSpacing: true,
                                          unSelectedColor:
                                              Theme.of(context).canvasColor,
                                          buttonValues: options,
                                          buttonLables: options,
                                          radioButtonValue: (value) {
                                            // todo: setState() to update chosen value
                                            print(value);
                                          },
                                          selectedColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool userFavourite;
  final void Function() toggleFavourite;

  const ItemAppBar({
    Key? key,
    required this.userFavourite,
    required this.toggleFavourite,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: Theme.of(context).textTheme.headlineLarge?.color,
          height: 2,
        ),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headlineLarge?.color),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            toggleFavourite();
            // todo: add item to fav
          },
          icon: (userFavourite)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
        ),
      ],
    );
  }
}
