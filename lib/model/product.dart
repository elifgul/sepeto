import 'package:flutter/foundation.dart';

enum Category {
  ALL, FRUIT, VEGETABLE, GRAIN, DAIRY_PRODUCT,
}

extension CategoryExtension on Category {
  String get value {
    switch(this) {
      case Category.ALL: return 'TÜMÜ';
      case Category.FRUIT: return 'MEYVE';
      case Category.VEGETABLE: return 'SEBZE';
      case Category.GRAIN: return 'TAHIL';
      default: return 'SÜT ÜRÜNLERI';
    }
  }
}


class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    this.price,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(price != null);

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  String get assetName => '$id-0.jpg';
  String get assetPackage => 'assets/sepeto_images';

  @override
  String toString() => "$name (id=$id)";
}
