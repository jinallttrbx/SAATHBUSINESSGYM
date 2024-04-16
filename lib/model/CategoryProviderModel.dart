// To parse this JSON data, do
//
//     final getServiceCategory = getServiceCategoryFromJson(jsonString);

import 'dart:convert';

GetServiceCategory getServiceCategoryFromJson(String str) => GetServiceCategory.fromJson(json.decode(str));

String getServiceCategoryToJson(GetServiceCategory data) => json.encode(data.toJson());

class GetServiceCategory {
  List<GetServiceCategorydata> data;
  String message;
  bool status;

  GetServiceCategory({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetServiceCategory.fromJson(Map<String, dynamic> json) => GetServiceCategory(
    data: List<GetServiceCategorydata>.from(json["data"].map((x) => GetServiceCategorydata.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetServiceCategorydata {
  int id;
  String name;
  dynamic description;
  String color;
  int status;
  int isProduct;
  int isService;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String type;

  GetServiceCategorydata({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.status,
    required this.isProduct,
    required this.isService,
    required this.isFeatured,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory GetServiceCategorydata.fromJson(Map<String, dynamic> json) => GetServiceCategorydata(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    color: json["color"],
    status: json["status"],
    isProduct: json["is_product"],
    isService: json["is_service"],
    isFeatured: json["is_featured"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "color": color,
    "status": status,
    "is_product": isProduct,
    "is_service": isService,
    "is_featured": isFeatured,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "type": type,
  };
}
