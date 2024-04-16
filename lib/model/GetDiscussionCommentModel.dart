// ignore_for_file: file_names, prefer_void_to_null, unnecessary_question_mark

class GetDiscussionCommentModel {
  String? message;
  bool? status;
  GetDiscussionCommentModelData? data;
  List<Comments>? comments;

  GetDiscussionCommentModel(
      {this.message, this.status, this.data, this.comments});

  GetDiscussionCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null
        ? GetDiscussionCommentModelData.fromJson(json['data'])
        : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDiscussionCommentModelData {
  int? id;
  int? userId;
  int? groupId;
  String? title;
  String? description;
  String? tags;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  GetDiscussionCommentModelData(
      {this.id,
      this.userId,
      this.groupId,
      this.title,
      this.description,
      this.tags,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  GetDiscussionCommentModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    title = json['title'];
    description = json['description'];
    tags = json['tags'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['group_id'] = groupId;
    data['title'] = title;
    data['description'] = description;
    data['tags'] = tags;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? discussionId;
  int? groupId;
  String? text;
  String? displayName;
  String? profileImage;
  String? time;

  Comments(
      {this.id,
      this.userId,
      this.discussionId,
      this.groupId,
      this.text,
      this.displayName,
      this.profileImage,
      this.time});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    discussionId = json['discussion_id'];
    groupId = json['group_id'];
    text = json['text'];
    displayName = json['display_name'];
    profileImage = json['profile_image'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['discussion_id'] = discussionId;
    data['group_id'] = groupId;
    data['text'] = text;
    data['display_name'] = displayName;
    data['profile_image'] = profileImage;
    data['time'] = time;
    return data;
  }
}
