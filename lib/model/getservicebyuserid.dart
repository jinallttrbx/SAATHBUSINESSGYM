// To parse this JSON data, do
//
//     final getservicebyuserid = getservicebyuseridFromJson(jsonString);

import 'dart:convert';

Getservicebyuserid getservicebyuseridFromJson(String str) => Getservicebyuserid.fromJson(json.decode(str));

String getservicebyuseridToJson(Getservicebyuserid data) => json.encode(data.toJson());

class Getservicebyuserid {
  List<Getservicebyuseriddata> data;
  String message;
  bool status;

  Getservicebyuserid({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Getservicebyuserid.fromJson(Map<String, dynamic> json) => Getservicebyuserid(
    data: List<Getservicebyuseriddata>.from(json["data"].map((x) => Getservicebyuseriddata.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Getservicebyuseriddata {
  int id;
  String serviceName;
  String subCategoryName;
  int minPrice;
  int maxPrice;
  String serviceImage;

  Getservicebyuseriddata({
    required this.id,
    required this.serviceName,
    required this.subCategoryName,
    required this.minPrice,
    required this.maxPrice,
    required this.serviceImage,
  });

  factory Getservicebyuseriddata.fromJson(Map<String, dynamic> json) => Getservicebyuseriddata(
    id: json["id"],
    serviceName: json["service_name"],
    subCategoryName: json["sub_category_name"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    serviceImage: json["service_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_name": serviceName,
    "sub_category_name": subCategoryName,
    "min_price": minPrice,
    "max_price": maxPrice,
    "service_image": serviceImage,
  };
}
