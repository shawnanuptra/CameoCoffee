class Item {
  final String name;
  final String description;
  final double price;
  final String category;
  final String itemSettings;

  @override
  String toString() {
    return "${this.name}, ${this.description}, ${this.price.toString()}, ${this.category}, ${this.itemSettings}";
  }

  const Item(this.name, this.description, this.price, this.category,
      this.itemSettings);
}
