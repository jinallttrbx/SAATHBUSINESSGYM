// To parse this JSON data, do
//
//     final getratingClass = getratingClassFromJson(jsonString);

import 'dart:convert';

GetratingClass getratingClassFromJson(String str) => GetratingClass.fromJson(json.decode(str));

String getratingClassToJson(GetratingClass data) => json.encode(data.toJson());

class GetratingClass {
  bool status;
  String message;
  List<Datum> data;
  double totalRating;
  double avgStar;
  int totalReview;

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
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  int userId;
  int callLogId;
  int customerId;
  double rating;
  String review;
  dynamic description;
  int serviceId;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String customerName;
  String profileImage;

  Datum({
    required this.id,
    required this.userId,
    required this.callLogId,
    required this.customerId,
    required this.rating,
    required this.review,
    required this.description,
    required this.serviceId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.customerName,
    required this.profileImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    callLogId: json["call_log_id"],
    customerId: json["customer_id"],
    rating: json["rating"]?.toDouble(),
    review: json["review"],
    description: json["description"],
    serviceId: json["service_id"],
    productId: json["product_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    customerName: json["customer_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "call_log_id": callLogId,
    "customer_id": customerId,
    "rating": rating,
    "review": review,
    "description": description,
    "service_id": serviceId,
    "product_id": productId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "customer_name": customerName,
    "profile_image": profileImage,
  };
}
