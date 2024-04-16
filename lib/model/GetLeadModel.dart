// To parse this JSON data, do
//
//     final leadDataModel = leadDataModelFromJson(jsonString);

import 'dart:convert';

LeadDataModel leadDataModelFromJson(String str) => LeadDataModel.fromJson(json.decode(str));

String leadDataModelToJson(LeadDataModel data) => json.encode(data.toJson());

class LeadDataModel {
  bool status;
  String message;
  List<Datum> data;

  LeadDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LeadDataModel.fromJson(Map<String, dynamic> json) => LeadDataModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int userId;
  int? serviceId;
  DateTime date;
  DateTime updatedAt;
  UserName userName;
  String contactNumber;
  String? serviceName;
  Tag tag;
  String? providerServiceImage;
  int avgRating;
  int totalRating;
  int myBooking;
  int? productId;
  String? productName;
  String? supplierProductImage;
  String? supplierServiceImage;
  String? providerProductImage;

  Datum({
    required this.id,
    required this.userId,
    this.serviceId,
    required this.date,
    required this.updatedAt,
    required this.userName,
    required this.contactNumber,
    this.serviceName,
    required this.tag,
    this.providerServiceImage,
    required this.avgRating,
    required this.totalRating,
    required this.myBooking,
    this.productId,
    this.productName,
    this.supplierProductImage,
    this.supplierServiceImage,
    this.providerProductImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    date: DateTime.parse(json["date"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userName: userNameValues.map[json["user_name"]]!,
    contactNumber: json["contact_number"],
    serviceName: json["service_name"],
    tag: tagValues.map[json["tag"]]!,
    providerServiceImage: json["provider_service_image"],
    avgRating: json["avg_rating"],
    totalRating: json["total_rating"],
    myBooking: json["my_booking"],
    productId: json["product_id"],
    productName: json["product_name"],
    supplierProductImage: json["supplier_product_image"],
    supplierServiceImage: json["supplier_service_image"],
    providerProductImage: json["provider_product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_id": serviceId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "updated_at": updatedAt.toIso8601String(),
    "user_name": userNameValues.reverse[userName],
    "contact_number": contactNumber,
    "service_name": serviceName,
    "tag": tagValues.reverse[tag],
    "provider_service_image": providerServiceImage,
    "avg_rating": avgRating,
    "total_rating": totalRating,
    "my_booking": myBooking,
    "product_id": productId,
    "product_name": productName,
    "supplier_product_image": supplierProductImage,
    "supplier_service_image": supplierServiceImage,
    "provider_product_image": providerProductImage,
  };
}

enum Tag {
  PROVIDER_PRODUCT,
  PROVIDER_SERVICE,
  SUPPLIER_PRODUCT,
  SUPPLIER_SERVICE
}

final tagValues = EnumValues({
  "provider product": Tag.PROVIDER_PRODUCT,
  "provider service": Tag.PROVIDER_SERVICE,
  "supplier product": Tag.SUPPLIER_PRODUCT,
  "supplier service": Tag.SUPPLIER_SERVICE
});

enum UserName {
  ALIII,
  JIGAR_PRAJAPATI,
  MEET_PLAY_STORE,
  MEHUL,
  RAESABANU_ANSARI
}

final userNameValues = EnumValues({
  "Aliii": UserName.ALIII,
  "Jigar Prajapati": UserName.JIGAR_PRAJAPATI,
  "meet play store": UserName.MEET_PLAY_STORE,
  "mehul": UserName.MEHUL,
  "Raesabanu Ansari": UserName.RAESABANU_ANSARI
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
