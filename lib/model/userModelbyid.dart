// To parse this JSON data, do
//
//     final userModelbyId = userModelbyIdFromJson(jsonString);

import 'dart:convert';

UserModelbyId userModelbyIdFromJson(String str) => UserModelbyId.fromJson(json.decode(str));

String userModelbyIdToJson(UserModelbyId data) => json.encode(data.toJson());

class UserModelbyId {
  UserModelbyIddata data;
  String message;
  bool status;

  UserModelbyId({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserModelbyId.fromJson(Map<String, dynamic> json) => UserModelbyId(
    data: UserModelbyIddata.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class UserModelbyIddata {
  int id;
  String username;
  String email;
  String contactNumber;
  double rating;
  dynamic gstNumber;
  dynamic fssaiNumber;
  String openTime;
  String closeTime;
  int workingHour;
  dynamic address;
  String profileImage;

  UserModelbyIddata({
    required this.id,
    required this.username,
    required this.email,
    required this.contactNumber,
    required this.rating,
    required this.gstNumber,
    required this.fssaiNumber,
    required this.openTime,
    required this.closeTime,
    required this.workingHour,
    required this.address,
    required this.profileImage,
  });

  factory UserModelbyIddata.fromJson(Map<String, dynamic> json) => UserModelbyIddata(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    contactNumber: json["contact_number"],
    rating: json["rating"]?.toDouble(),
    gstNumber: json["gst_number"],
    fssaiNumber: json["fssai_number"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    workingHour: json["working_hour"],
    address: json["address"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "contact_number": contactNumber,
    "rating": rating,
    "gst_number": gstNumber,
    "fssai_number": fssaiNumber,
    "open_time": openTime,
    "close_time": closeTime,
    "working_hour": workingHour,
    "address": address,
    "profile_image": profileImage,
  };
}
