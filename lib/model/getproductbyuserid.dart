// To parse this JSON data, do
//
//     final getproductbyuserid = getproductbyuseridFromJson(jsonString);

import 'dart:convert';

Getproductbyuserid getproductbyuseridFromJson(String str) => Getproductbyuserid.fromJson(json.decode(str));

String getproductbyuseridToJson(Getproductbyuserid data) => json.encode(data.toJson());

class Getproductbyuserid {
  List<GetproductbyuseridData> data;
  String message;
  bool status;

  Getproductbyuserid({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Getproductbyuserid.fromJson(Map<String, dynamic> json) => Getproductbyuserid(
    data: List<GetproductbyuseridData>.from(json["data"].map((x) => GetproductbyuseridData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetproductbyuseridData {
  int id;
  String productName;
  String subCategoryName;
  int minPrice;
  int maxPrice;
  String productImage;

  GetproductbyuseridData({
    required this.id,
    required this.productName,
    required this.subCategoryName,
    required this.minPrice,
    required this.maxPrice,
    required this.productImage,
  });

  factory GetproductbyuseridData.fromJson(Map<String, dynamic> json) => GetproductbyuseridData(
    id: json["id"],
    productName: json["product_name"],
    subCategoryName: json["sub_category_name"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "sub_category_name": subCategoryName,
    "min_price": minPrice,
    "max_price": maxPrice,
    "product_image": productImage,
  };
}
