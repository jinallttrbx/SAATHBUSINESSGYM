// To parse this JSON data, do
//
//     final getDiscussionsModel = getDiscussionsModelFromJson(jsonString);

import 'dart:convert';

GetDiscussionsModel getDiscussionsModelFromJson(String str) => GetDiscussionsModel.fromJson(json.decode(str));

String getDiscussionsModelToJson(GetDiscussionsModel data) => json.encode(data.toJson());

class GetDiscussionsModel {
  String message;
  bool status;
  List<GetDiscussionsModelData> data;

  GetDiscussionsModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory GetDiscussionsModel.fromJson(Map<String, dynamic> json) => GetDiscussionsModel(
    message: json["message"],
    status: json["status"],
    data: List<GetDiscussionsModelData>.from(json["data"].map((x) => GetDiscussionsModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetDiscussionsModelData {
  int id;
  int userId;
  int groupId;
  String title;
  String description;
  List<String> tags;
  String deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int commentCount;
  String displayName;
  String profileImage;
  String time;

  GetDiscussionsModelData({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.title,
    required this.description,
    required this.tags,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
    required this.displayName,
    required this.profileImage,
    required this.time,
  });

  factory GetDiscussionsModelData.fromJson(Map<String, dynamic> json) => GetDiscussionsModelData(
    id: json["id"],
    userId: json["user_id"],
    groupId: json["group_id"],
    title: json["title"],
    description: json["description"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    commentCount: json["comment_count"],
    displayName: json["display_name"],
    profileImage: json["profile_image"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "group_id": groupId,
    "title": title,
    "description": description,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "comment_count": commentCount,
    "display_name": displayName,
    "profile_image": profileImage,
    "time": time,
  };
}
