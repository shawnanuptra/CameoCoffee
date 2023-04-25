import 'package:flutter/material.dart';

import '../model/item_class.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen(this.item, {Key? key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(item.toString())),
    );
  }
}
