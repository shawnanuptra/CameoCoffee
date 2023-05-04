import 'dart:core';

import 'package:coffee_cameo/model/item_settings_class.dart';

class MenuItem {
  String name;
  String description;
  String category;
  double price;
  bool? special;
  ItemSettings itemSettings;

  MenuItem(this.name, this.description, this.category, this.price, this.special,
      this.itemSettings);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'special': special,
      'itemSettings': itemSettings.toMap()
    };
  }

  MenuItem.fromMap(Map<String, dynamic> itemMap)
      : name = itemMap['name'],
        description = itemMap['description'],
        category = itemMap['category'],
        price = itemMap['price'].toDouble(),
        special = itemMap['special'],
        itemSettings = ItemSettings.fromMap(itemMap['itemSettings']);
}

class ItemOptions {
  // String milk;
  // String syrup;
  //
  // String
}
