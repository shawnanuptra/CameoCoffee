import 'package:coffee_cameo/model/menu_item_model.dart';
import 'package:coffee_cameo/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../model/item_class.dart';

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
    });
  }

  List data = ['Small', 'Medium', 'Big'];
  int _focusedIndex = 0;

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    return Container(
      width: 75,
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 75,
            width: 75,
            // decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Text('${data[index]}'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: Theme.of(context).textTheme.headlineLarge?.color,
            height: 2,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: kBgColor,
        iconTheme: IconThemeData(
            color: Theme.of(context).textTheme.headlineLarge?.color),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.item.name,
          style: Theme.of(context).textTheme.headlineLarge,
          // ?.copyWith(fontWeight: FontWeight.normal),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Item',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        onPressed: () {},
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: SvgPicture.asset('assets/espresso.svg'),
                  ),
                  Text(widget.item.description),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Size',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Container(
                        height: 75,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            ScrollSnapList(
                                itemBuilder: _buildListItem,
                                itemCount: data.length,
                                itemSize: 75,
                                onItemFocus: _onItemFocus),
                          ],
                        ),
                      ),
                      Container(
                        child: Text('$_focusedIndex'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        'Milk',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        'Blend',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        'Extra shots',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        'Syrups',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
