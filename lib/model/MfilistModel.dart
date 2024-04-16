// To parse this JSON data, do
//
//     final mfilistModel = mfilistModelFromJson(jsonString);

import 'dart:convert';

MfilistModel mfilistModelFromJson(String str) => MfilistModel.fromJson(json.decode(str));

String mfilistModelToJson(MfilistModel data) => json.encode(data.toJson());

class MfilistModel {
  bool status;
  String message;
  List<MfilistModelData> data;

  MfilistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MfilistModel.fromJson(Map<String, dynamic> json) => MfilistModel(
    status: json["status"],
    message: json["message"],
    data: List<MfilistModelData>.from(json["data"].map((x) => MfilistModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MfilistModelData {
  int mfiId;
  String userName;
  String email;
  String branch;
  int status;
  String image;
  String createTime;

  MfilistModelData({
    required this.mfiId,
    required this.userName,
    required this.email,
    required this.branch,
    required this.status,
    required this.image,
    required this.createTime,
  });

  factory MfilistModelData.fromJson(Map<String, dynamic> json) => MfilistModelData(
    mfiId: json["mfi_id"],
    userName: json["user_name"],
    email: json["email"],
    branch: json["branch"],
    status: json["status"],
    image: json["image"],
    createTime: json["create_time"],
  );

  Map<String, dynamic> toJson() => {
    "mfi_id": mfiId,
    "user_name": userName,
    "email": email,
    "branch": branch,
    "status": status,
    "image": image,
    "create_time": createTime,
  };
}
