// To parse this JSON data, do
//
//     final getProductSubCategory = getProductSubCategoryFromJson(jsonString);

import 'dart:convert';

GetProductSubCategory getProductSubCategoryFromJson(String str) => GetProductSubCategory.fromJson(json.decode(str));

String getProductSubCategoryToJson(GetProductSubCategory data) => json.encode(data.toJson());

class GetProductSubCategory {
  List<GetProductSubCategorydata> data;
  String message;
  bool status;

  GetProductSubCategory({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetProductSubCategory.fromJson(Map<String, dynamic> json) => GetProductSubCategory(
    data: List<GetProductSubCategorydata>.from(json["data"].map((x) => GetProductSubCategorydata.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetProductSubCategorydata {
  int id;
  int categoryId;
  String name;
  dynamic description;
  int status;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  GetProductSubCategorydata({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.status,
    required this.isFeatured,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetProductSubCategorydata.fromJson(Map<String, dynamic> json) => GetProductSubCategorydata(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    isFeatured: json["is_featured"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "description": description,
    "status": status,
    "is_featured": isFeatured,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
