// To parse this JSON data, do
//
//     final viewNewsModel = viewNewsModelFromJson(jsonString);

import 'dart:convert';

ViewNewsModel viewNewsModelFromJson(String str) => ViewNewsModel.fromJson(json.decode(str));

String viewNewsModelToJson(ViewNewsModel data) => json.encode(data.toJson());

class ViewNewsModel {
  bool status;
  String message;
  List<ViewNewsModelData> data;

  ViewNewsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewNewsModel.fromJson(Map<String, dynamic> json) => ViewNewsModel(
    status: json["status"],
    message: json["message"],
    data: List<ViewNewsModelData>.from(json["data"].map((x) => ViewNewsModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewNewsModelData {
  String title;
  String urlLink;
  String image;
  String createTime;

  ViewNewsModelData({
    required this.title,
    required this.urlLink,
    required this.image,
    required this.createTime,
  });

  factory ViewNewsModelData.fromJson(Map<String, dynamic> json) => ViewNewsModelData(
    title: json["title"],
    urlLink: json["url_link"],
    image: json["image"],
    createTime: json["create_time"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url_link": urlLink,
    "image": image,
    "create_time": createTime,
  };
}
