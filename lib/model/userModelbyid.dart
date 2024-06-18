// To parse this JSON data, do
//
//     final userModelbyId = userModelbyIdFromJson(jsonString);

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
  dynamic id;
  dynamic username;
  dynamic email;
  dynamic contactNumber;
  dynamic rating;
  dynamic gstNumber;
  dynamic fssaiNumber;
  dynamic openTime;
  dynamic closeTime;
  dynamic workingHour;
  dynamic businessAddress;
  dynamic profileImage;

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
    required this.businessAddress,
    required this.profileImage,
  });

  factory UserModelbyIddata.fromJson(Map<String, dynamic> json) => UserModelbyIddata(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    contactNumber: json["contact_number"],
    rating: json["rating"],
    gstNumber: json["gst_number"],
    fssaiNumber: json["fssai_number"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    workingHour: json["working_hour"],
    businessAddress: json["business_address"],
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
    "business_address": businessAddress,
    "profile_image": profileImage,
  };
}



// To parse this JSON data, do
//
//     final userModelbyuserId = userModelbyuserIdFromJson(jsonString);



UserModelbyuserId userModelbyuserIdFromJson(String str) => UserModelbyuserId.fromJson(json.decode(str));

String userModelbyuserIdToJson(UserModelbyuserId data) => json.encode(data.toJson());

class UserModelbyuserId {
  UserModelbyuserIddata data;
  String message;
  bool status;

  UserModelbyuserId({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserModelbyuserId.fromJson(Map<String, dynamic> json) => UserModelbyuserId(
    data: UserModelbyuserIddata.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class UserModelbyuserIddata {
  dynamic id;
  dynamic username;
  dynamic email;
  dynamic contactNumber;
  dynamic rating;
  dynamic profileImage;

  UserModelbyuserIddata({
    required this.id,
    required this.username,
    required this.email,
    required this.contactNumber,
    required this.rating,
    required this.profileImage,
  });

  factory UserModelbyuserIddata.fromJson(Map<String, dynamic> json) => UserModelbyuserIddata(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    contactNumber: json["contact_number"],
    rating: json["rating"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "contact_number": contactNumber,
    "rating": rating,
    "profile_image": profileImage,
  };
}

