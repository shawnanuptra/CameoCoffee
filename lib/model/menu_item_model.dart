import 'dart:core';

class MenuItem {
  String name;
  String description;
  String category;
  double price;
  bool? special;
  Map<String, dynamic>? itemSettings;

  MenuItem(this.name, this.description, this.category, this.price,
      this.special,
      this.itemSettings
      );

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'description' : description,
      'category' : category,
      'price' : price,
      'special' : special,
      'itemSettings': itemSettings
    };
  }

  MenuItem.fromMap(Map<String,dynamic> itemMap)
    : name = itemMap['name'],
      description = itemMap['description'],
      category = itemMap['category'],
      price = itemMap['price'].toDouble(),
      special = itemMap['special'],
      itemSettings = itemMap['itemSettings'];
}

class ItemOptions {
  // String milk;
  // String syrup;
  //
  // String
}

enum Milk {
  Whole,
  Skinny,
  Oat,
  Coconut,
  Almond,
  Soy,
}

enum Syrup {
  Vanilla,
  Caramel,
  Hazelnut
}
