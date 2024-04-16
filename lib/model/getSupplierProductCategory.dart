// To parse this JSON data, do
//
//     final getProductCategory = getProductCategoryFromJson(jsonString);

import 'dart:convert';

GetProductCategory getProductCategoryFromJson(String str) => GetProductCategory.fromJson(json.decode(str));

String getProductCategoryToJson(GetProductCategory data) => json.encode(data.toJson());

class GetProductCategory {
  List<GetProductCategorydata> data;
  String message;
  bool status;

  GetProductCategory({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetProductCategory.fromJson(Map<String, dynamic> json) => GetProductCategory(
    data: List<GetProductCategorydata>.from(json["data"].map((x) => GetProductCategorydata.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetProductCategorydata {
  int id;
  String name;
  String? description;
  Color color;
  int status;
  int isProduct;
  int isService;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Type type;

  GetProductCategorydata({
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

  factory GetProductCategorydata.fromJson(Map<String, dynamic> json) => GetProductCategorydata(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    color: colorValues.map[json["color"]]!,
    status: json["status"],
    isProduct: json["is_product"],
    isService: json["is_service"],
    isFeatured: json["is_featured"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "color": colorValues.reverse[color],
    "status": status,
    "is_product": isProduct,
    "is_service": isService,
    "is_featured": isFeatured,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "type": typeValues.reverse[type],
  };
}

enum Color {
  AF5541,
  THE_000000
}

final colorValues = EnumValues({
  "#af5541": Color.AF5541,
  "#000000": Color.THE_000000
});

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
