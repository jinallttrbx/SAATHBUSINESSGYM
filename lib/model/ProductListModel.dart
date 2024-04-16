// To parse this JSON data, do
//
//     final getproductlistmodel = getproductlistmodelFromJson(jsonString);

import 'dart:convert';

Getproductlistmodel getproductlistmodelFromJson(String str) => Getproductlistmodel.fromJson(json.decode(str));

String getproductlistmodelToJson(Getproductlistmodel data) => json.encode(data.toJson());

class Getproductlistmodel {
  List<ProductCategory> data;
  String message;
  bool status;

  Getproductlistmodel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Getproductlistmodel.fromJson(Map<String, dynamic> json) => Getproductlistmodel(
    data: List<ProductCategory>.from(json["data"].map((x) => ProductCategory.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ProductCategory {
  int id;
  String categoryName;
  Type type;
  List<SubCategoryProduct> subCategory;

  ProductCategory({
    required this.id,
    required this.categoryName,
    required this.type,
    required this.subCategory,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    categoryName: json["category_name"],
    type: typeValues.map[json["type"]]!,
    subCategory: List<SubCategoryProduct>.from(json["sub_category"].map((x) => SubCategoryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "type": typeValues.reverse[type],
    "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategoryProduct {
  int categoryId;
  int subCategoryId;
  String subCategoriesName;
  dynamic description;
  int status;
  String productName;
  int minPrice;
  int maxPrice;
  int id;
  int workProfileId;
  String workProfileName;
  String productImage;

  SubCategoryProduct({
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoriesName,
    required this.description,
    required this.status,
    required this.productName,
    required this.minPrice,
    required this.maxPrice,
    required this.id,
    required this.workProfileId,
    required this.workProfileName,
    required this.productImage,
  });

  factory SubCategoryProduct.fromJson(Map<String, dynamic> json) => SubCategoryProduct(
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    subCategoriesName: json["sub_categories_name"],
    description: json["description"],
    status: json["status"],
    productName: json["product_name"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    id: json["id"],
    workProfileId: json["work_profile_id"],
    workProfileName: json["work_profile_name"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "sub_categories_name": subCategoriesName,
    "description": description,
    "status": status,
    "product_name": productName,
    "min_price": minPrice,
    "max_price": maxPrice,
    "id": id,
    "work_profile_id": workProfileId,
    "work_profile_name": workProfileName,
    "product_image": productImage,
  };
}

enum Type {
  PROVIDER,
  SUPPLIER
}

final typeValues = EnumValues({
  "provider": Type.PROVIDER,
  "supplier": Type.SUPPLIER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
