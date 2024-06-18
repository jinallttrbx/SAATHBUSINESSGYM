// To parse this JSON data, do
//
//     final getDiscussionCommentModel = getDiscussionCommentModelFromJson(jsonString);

import 'dart:convert';

GetDiscussionCommentModel getDiscussionCommentModelFromJson(String str) => GetDiscussionCommentModel.fromJson(json.decode(str));

String getDiscussionCommentModelToJson(GetDiscussionCommentModel data) => json.encode(data.toJson());

class GetDiscussionCommentModel {
  String? message;
  bool? status;
  GetDiscussionCommentModelData? data;
  List<Comments>? comments;

  GetDiscussionCommentModel({
     this.message,
     this.status,
     this.data,
     this.comments,
  });

  factory GetDiscussionCommentModel.fromJson(Map<String, dynamic> json) => GetDiscussionCommentModel(
    message: json["message"],
    status: json["status"],
    data: GetDiscussionCommentModelData.fromJson(json["data"]),
    comments: List<Comments>.from(json["comments"].map((x) => Comments.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data!.toJson(),
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comments {
  int? id;
  int? userId;
  int? discussionId;
  int? groupId;
  String? text;
  String? username;
  String? profileImage;
  String? time;

  Comments({
     this.id,
     this.userId,
     this.discussionId,
     this.groupId,
     this.text,
     this.username,
     this.profileImage,
     this.time,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    id: json["id"],
    userId: json["user_id"],
    discussionId: json["discussion_id"],
    groupId: json["group_id"],
    text: json["text"],
    username: json["username"],
    profileImage: json["profile_image"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "discussion_id": discussionId,
    "group_id": groupId,
    "text": text,
    "username": username,
    "profile_image": profileImage,
    "time": time,
  };
}

class GetDiscussionCommentModelData {
  int? id;
  int? userId;
  int? groupId;
  String? title;
  String? description;
  String? tags;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetDiscussionCommentModelData({
     this.id,
     this.userId,
     this.groupId,
     this.title,
     this.description,
     this.tags,
     this.deletedAt,
     this.createdAt,
     this.updatedAt,
  });

  factory GetDiscussionCommentModelData.fromJson(Map<String, dynamic> json) => GetDiscussionCommentModelData(
    id: json["id"],
    userId: json["user_id"],
    groupId: json["group_id"],
    title: json["title"],
    description: json["description"],
    tags: json["tags"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "group_id": groupId,
    "title": title,
    "description": description,
    "tags": tags,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
