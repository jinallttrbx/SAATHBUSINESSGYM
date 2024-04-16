// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) => json.encode(data.toJson());

class NotificationResponseModel {
  List<Datum> data;
  bool status;
  String message;

  NotificationResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Datum {
  int id;
  String userType;
  String title;
  String type;
  dynamic cityId;
  dynamic stateId;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Datum({
    required this.id,
    required this.userType,
    required this.title,
    required this.type,
    required this.cityId,
    required this.stateId,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userType: json["user_type"],
    title: json["title"],
    type: json["type"],
    cityId: json["city_id"],
    stateId: json["state_id"],
    description: json["description"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userType,
    "title": title,
    "type": type,
    "city_id": cityId,
    "state_id": stateId,
    "description": description,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt.toIso8601String(),
  };
}
