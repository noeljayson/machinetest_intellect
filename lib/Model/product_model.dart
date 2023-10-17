// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProductModel> productModelFromMap(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromMap(x)));

String productModelToMap(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductModel {
  int id;
  String name;
  String slug;
  String permalink;

  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;

  String averageRating;

  List<Category> categories;

  List<Images> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.averageRating,
    required this.categories,
    required this.images,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"]!,
        slug: json["slug"],
        permalink: json["permalink"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        averageRating: json["average_rating"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
        images: List<Images>.from(json["images"].map((x) => Images.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "average_rating": averageRating,
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Images {
  int id;

  String src;
  String name;

  Images({
    required this.id,
    required this.src,
    required this.name,
  });

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        id: json["id"],
        src: json["src"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "src": src,
        "name": name,
      };
}

enum Name {
  DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY,
  DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY_COPY,
  DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY_COPY_COPY
}

final nameValues = EnumValues({
  "Dabur Rajah Pravarthanavati Tablets 60 Nos (Copy)":
      Name.DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY,
  "Dabur Rajah Pravarthanavati Tablets 60 Nos (Copy) (Copy)":
      Name.DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY_COPY,
  "Dabur Rajah Pravarthanavati Tablets 60 Nos (Copy) (Copy) (Copy)":
      Name.DABUR_RAJAH_PRAVARTHANAVATI_TABLETS_60_NOS_COPY_COPY_COPY
});

enum Status { PUBLISH }

final statusValues = EnumValues({"publish": Status.PUBLISH});

enum StockStatus { INSTOCK }

final stockStatusValues = EnumValues({"instock": StockStatus.INSTOCK});

enum TaxStatus { TAXABLE }

final taxStatusValues = EnumValues({"taxable": TaxStatus.TAXABLE});

enum Type { SIMPLE }

final typeValues = EnumValues({"simple": Type.SIMPLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
