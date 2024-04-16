// To parse this JSON data, do
//
//     final getserviceslistmodel = getserviceslistmodelFromJson(jsonString);

import 'dart:convert';

Getserviceslistmodel getserviceslistmodelFromJson(String str) => Getserviceslistmodel.fromJson(json.decode(str));

String getserviceslistmodelToJson(Getserviceslistmodel data) => json.encode(data.toJson());

class Getserviceslistmodel {
  List<ServiceCategory> data;
  String message;
  bool status;

  Getserviceslistmodel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Getserviceslistmodel.fromJson(Map<String, dynamic> json) => Getserviceslistmodel(
    data: List<ServiceCategory>.from(json["data"].map((x) => ServiceCategory.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ServiceCategory {
  int id;
  String categoryName;
  Type type;
  List<SubCategory> subCategory;

  ServiceCategory({
    required this.id,
    required this.categoryName,
    required this.type,
    required this.subCategory,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
    id: json["id"],
    categoryName: json["category_name"],
    type: typeValues.map[json["type"]]!,
    subCategory: List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "type": typeValues.reverse[type],
    "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory {
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
  String serviceImage;

  SubCategory({
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
    required this.serviceImage,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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
    serviceImage: json["service_image"],
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
    "service_image": serviceImage,
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
