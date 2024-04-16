// To parse this JSON data, do
//
//     final viewprofileModel = viewprofileModelFromJson(jsonString);

import 'dart:convert';

ViewprofileModel viewprofileModelFromJson(String str) => ViewprofileModel.fromJson(json.decode(str));

String viewprofileModelToJson(ViewprofileModel data) => json.encode(data.toJson());

class ViewprofileModel {
  bool status;
  String message;
  List<ViewprofileModeldata> data;

  ViewprofileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewprofileModel.fromJson(Map<String, dynamic> json) => ViewprofileModel(
    status: json["status"],
    message: json["message"],
    data: List<ViewprofileModeldata>.from(json["data"].map((x) => ViewprofileModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewprofileModeldata {
  int id;
  String fullName;
  String firstName;
  dynamic lastName;
  dynamic occupationId;
  dynamic occupation;
  String profileImage;
  List<Viewed> viewed;
  int totalRating;

  ViewprofileModeldata({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.occupationId,
    required this.occupation,
    required this.profileImage,
    required this.viewed,
    required this.totalRating,
  });

  factory ViewprofileModeldata.fromJson(Map<String, dynamic> json) => ViewprofileModeldata(
    id: json["id"],
    fullName: json["full_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    occupationId: json["occupation_id"],
    occupation: json["occupation"],
    profileImage: json["profile_image"],
    viewed: List<Viewed>.from(json["viewed"].map((x) => Viewed.fromJson(x))),
    totalRating: json["total_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "first_name": firstName,
    "last_name": lastName,
    "occupation_id": occupationId,
    "occupation": occupation,
    "profile_image": profileImage,
    "viewed": List<dynamic>.from(viewed.map((x) => x.toJson())),
    "total_rating": totalRating,
  };
}

class Viewed {
  int id;
  int userId;
  int profileId;
  DateTime createdAt;
  DateTime updatedAt;
  String fullName;
  String firstName;
  dynamic lastName;
  String userType;
  int isSupplier;
  dynamic occupationId;
  dynamic occupation;
  String profileImage;
  String type;
  int totalRating;

  Viewed({
    required this.id,
    required this.userId,
    required this.profileId,
    required this.createdAt,
    required this.updatedAt,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.isSupplier,
    required this.occupationId,
    required this.occupation,
    required this.profileImage,
    required this.type,
    required this.totalRating,
  });

  factory Viewed.fromJson(Map<String, dynamic> json) => Viewed(
    id: json["id"],
    userId: json["user_id"],
    profileId: json["profile_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fullName: json["full_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userType: json["user_type"],
    isSupplier: json["isSupplier"],
    occupationId: json["occupation_id"],
    occupation: json["occupation"],
    profileImage: json["profile_image"],
    type: json["type"],
    totalRating: json["total_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profile_id": profileId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "full_name": fullName,
    "first_name": firstName,
    "last_name": lastName,
    "user_type": userType,
    "isSupplier": isSupplier,
    "occupation_id": occupationId,
    "occupation": occupation,
    "profile_image": profileImage,
    "type": type,
    "total_rating": totalRating,
  };
}
