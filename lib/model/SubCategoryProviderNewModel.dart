// To parse this JSON data, do
//
//     final getServiceSubCategory = getServiceSubCategoryFromJson(jsonString);

import 'dart:convert';

GetServiceSubCategory getServiceSubCategoryFromJson(String str) => GetServiceSubCategory.fromJson(json.decode(str));

String getServiceSubCategoryToJson(GetServiceSubCategory data) => json.encode(data.toJson());

class GetServiceSubCategory {
  List<GetServiceSubCategorydata> data;
  String message;
  bool status;

  GetServiceSubCategory({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetServiceSubCategory.fromJson(Map<String, dynamic> json) => GetServiceSubCategory(
    data: List<GetServiceSubCategorydata>.from(json["data"].map((x) => GetServiceSubCategorydata.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetServiceSubCategorydata {
  int id;
  int categoryId;
  String name;
  dynamic description;
  int status;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  GetServiceSubCategorydata({
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

  factory GetServiceSubCategorydata.fromJson(Map<String, dynamic> json) => GetServiceSubCategorydata(
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
