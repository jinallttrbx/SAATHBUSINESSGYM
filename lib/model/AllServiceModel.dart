// ignore_for_file: file_names, prefer_void_to_null, unnecessary_question_mark

import 'dart:convert';

class AllServiceModel {
  Pagination? pagination;
  List<AllServiceModelData>? data;

  AllServiceModel({this.pagination, this.data});

  AllServiceModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <AllServiceModelData>[];
      json['data'].forEach((v) {
        data!.add(AllServiceModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? perPage;
  int? currentPage;
  int? totalPages;
  int? from;
  int? to;
  var nextPage;
  var previousPage;

  Pagination(
      {this.totalItems,
      this.perPage,
      this.currentPage,
      this.totalPages,
      this.from,
      this.to,
      this.nextPage,
      this.previousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    perPage = json['per_page'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    from = json['from'];
    to = json['to'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['per_page'] = perPage;
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['from'] = from;
    data['to'] = to;
    data['next_page'] = nextPage;
    data['previous_page'] = previousPage;
    return data;
  }
}

class AllServiceModelData {
  int? id;
  String? name;
  int? status;
  String? description;
  int? isFeatured;
  dynamic color;
  String? categoryImage;
  String? categoryExtension;
  dynamic deletedAt;
  List<SubData>? subData;

  AllServiceModelData(
      {this.id,
      this.name,
      this.status,
      this.description,
      this.isFeatured,
      this.color,
      this.categoryImage,
      this.categoryExtension,
      this.deletedAt,
      this.subData});

  AllServiceModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    isFeatured = json['is_featured'];
    color = json['color'];
    categoryImage = json['category_image'];
    categoryExtension = json['category_extension'];
    deletedAt = json['deleted_at'];
    if (json['sub_data'] != null) {
      subData = <SubData>[];
      json['sub_data'].forEach((v) {
        subData!.add(SubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['is_featured'] = isFeatured;
    data['color'] = color;
    data['category_image'] = categoryImage;
    data['category_extension'] = categoryExtension;
    data['deleted_at'] = deletedAt;
    data['sub_data'] = subData!.map((v) => v.toJson()).toList();
    return data;
  }
}

class SubData {
  int? id;
  String? name;
  int? status;
  String? description;
  int? isFeatured;
  var color;
  int? categoryId;
  String? categoryImage;
  String? categoryExtension;
  String? categoryName;
  int? services;
  var deletedAt;

  SubData(
      {this.id,
      this.name,
      this.status,
      this.description,
      this.isFeatured,
      this.color,
      this.categoryId,
      this.categoryImage,
      this.categoryExtension,
      this.categoryName,
      this.services,
      this.deletedAt});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    isFeatured = json['is_featured'];
    color = json['color'];
    categoryId = json['category_id'];
    categoryImage = json['category_image'];
    categoryExtension = json['category_extension'];
    categoryName = json['category_name'];
    services = json['services'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['is_featured'] = isFeatured;
    data['color'] = color;
    data['category_id'] = categoryId;
    data['category_image'] = categoryImage;
    data['category_extension'] = categoryExtension;
    data['category_name'] = categoryName;
    data['services'] = services;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
// To parse this JSON data, do
//
//     final allProductModel = allProductModelFromJson(jsonString);



AllProductModel allProductModelFromJson(String str) => AllProductModel.fromJson(json.decode(str));

String allProductModelToJson(AllProductModel data) => json.encode(data.toJson());

class AllProductModel {
  Pagination pagination;
  List<AllProductModeldata> data;

  AllProductModel({
    required this.pagination,
    required this.data,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) => AllProductModel(
    pagination: Pagination.fromJson(json["pagination"]),
    data: List<AllProductModeldata>.from(json["data"].map((x) => AllProductModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllProductModeldata {
  int id;
  String name;
  int status;
  String? description;
  int isFeatured;
  String color;
  String categoryImage;
  String categoryExtension;
  DateTime? deletedAt;
  List<SubDatum> subData;

  AllProductModeldata({
    required this.id,
    required this.name,
    required this.status,
    required this.description,
    required this.isFeatured,
    required this.color,
    required this.categoryImage,
    required this.categoryExtension,
    required this.deletedAt,
    required this.subData,
  });

  factory AllProductModeldata.fromJson(Map<String, dynamic> json) => AllProductModeldata(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    description: json["description"],
    isFeatured: json["is_featured"],
    color: json["color"],
    categoryImage: json["category_image"],
    categoryExtension: json["category_extension"],
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    subData: List<SubDatum>.from(json["sub_data"].map((x) => SubDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "description": description,
    "is_featured": isFeatured,
    "color": color,
    "category_image": categoryImage,
    "category_extension": categoryExtension,
    "deleted_at": deletedAt?.toIso8601String(),
    "sub_data": List<dynamic>.from(subData.map((x) => x.toJson())),
  };
}

class SubDatum {
  int id;
  int categoryId;
  String name;
  String? description;
  int status;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  SubDatum({
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

  factory SubDatum.fromJson(Map<String, dynamic> json) => SubDatum(
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

class Pagination1 {
  int totalItems;
  int perPage;
  int currentPage;
  int totalPages;
  int from;
  int to;
  dynamic nextPage;
  dynamic previousPage;

  Pagination1({
    required this.totalItems,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.from,
    required this.to,
    required this.nextPage,
    required this.previousPage,
  });

  factory Pagination1.fromJson(Map<String, dynamic> json) => Pagination1(
    totalItems: json["total_items"],
    perPage: json["per_page"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    from: json["from"],
    to: json["to"],
    nextPage: json["next_page"],
    previousPage: json["previous_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "per_page": perPage,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "from": from,
    "to": to,
    "next_page": nextPage,
    "previous_page": previousPage,
  };
}
