// To parse this JSON data, do
//
//     final getratingClass = getratingClassFromJson(jsonString);

import 'dart:convert';

GetratingClass getratingClassFromJson(String str) => GetratingClass.fromJson(json.decode(str));

String getratingClassToJson(GetratingClass data) => json.encode(data.toJson());

class GetratingClass {
  bool status;
  String message;
  List<GetratingClassdata> data;
  dynamic totalRating;
  dynamic avgStar;
  dynamic totalReview;

  GetratingClass({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRating,
    required this.avgStar,
    required this.totalReview,
  });

  factory GetratingClass.fromJson(Map<String, dynamic> json) => GetratingClass(
    status: json["status"],
    message: json["message"],
    data: List<GetratingClassdata>.from(json["data"].map((x) => GetratingClassdata.fromJson(x))),
    totalRating: json["total_rating"]?.toDouble(),
    avgStar: json["avg_star"]?.toDouble(),
    totalReview: json["total_review"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_rating": totalRating,
    "avg_star": avgStar,
    "total_review": totalReview,
  };
}

class GetratingClassdata {
  dynamic id;
  dynamic callLogId;
  dynamic serviceId;
  dynamic productId;
  dynamic customerId;
  dynamic rating;
  dynamic review;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic type;
  dynamic customerName;
  dynamic profileImage;
  dynamic userId;
  dynamic description;

  GetratingClassdata({
    required this.id,
    required this.callLogId,
    required this.serviceId,
    required this.productId,
    required this.customerId,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.type,
    required this.customerName,
    required this.profileImage,
    this.userId,
    this.description,
  });

  factory GetratingClassdata.fromJson(Map<String, dynamic> json) => GetratingClassdata(
    id: json["id"],
    callLogId: json["call_log_id"],
    serviceId: json["service_id"],
    productId: json["product_id"],
    customerId: json["customer_id"],
    rating: json["rating"]?.toDouble(),
    review: json["review"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    type: json["type"],
    customerName: json["customer_name"],
    profileImage: json["profile_image"],
    userId: json["user_id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "call_log_id": callLogId,
    "service_id": serviceId,
    "product_id": productId,
    "customer_id": customerId,
    "rating": rating,
    "review": review,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "type": type,
    "customer_name": customerName,
    "profile_image": profileImage,
    "user_id": userId,
    "description": description,
  };
}


