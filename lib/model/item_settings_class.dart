class ItemSettings {
  final bool? requiredMilk;
  final String? milk;
  final String? size;
  final String? syrup;
  final bool? cream;
  final bool? marshmallow;

  const ItemSettings(this.requiredMilk, this.milk, this.size, this.syrup,
      this.cream, this.marshmallow);

  @override
  String toString() {
    return "${this.milk}, ${this.size}, ${this.syrup}, ${this.requiredMilk}, ${this.cream}, ${this.marshmallow}";
  }

  Map<String, dynamic> toMap() {
    return {
      'requiredMilk': requiredMilk,
      'milk': milk,
      'size': size,
      'syrup': syrup,
      'cream': cream,
      'marshmallow': marshmallow,
    };
  }

  ItemSettings.fromMap(Map<String, dynamic> itemSettings)
      : requiredMilk = itemSettings['requiredMilk'],
        milk = itemSettings['milk'],
        size = itemSettings['size'],
        syrup = itemSettings['syrup'],
        cream = itemSettings['cream'],
        marshmallow = itemSettings['marshmallow'];
}