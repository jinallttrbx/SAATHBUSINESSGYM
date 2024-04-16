// To parse this JSON data, do
//
//     final viewAdvertismentModel = viewAdvertismentModelFromJson(jsonString);

import 'dart:convert';

ViewAdvertismentModel viewAdvertismentModelFromJson(String str) => ViewAdvertismentModel.fromJson(json.decode(str));

String viewAdvertismentModelToJson(ViewAdvertismentModel data) => json.encode(data.toJson());

class ViewAdvertismentModel {
  bool status;
  String message;
  List<ViewAdvertismentModelData> data;

  ViewAdvertismentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewAdvertismentModel.fromJson(Map<String, dynamic> json) => ViewAdvertismentModel(
    status: json["status"],
    message: json["message"],
    data: List<ViewAdvertismentModelData>.from(json["data"].map((x) => ViewAdvertismentModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewAdvertismentModelData {
  int id;
  String title;
  String urlLink;
  String description;
  String image;
  String createTime;

  ViewAdvertismentModelData({
    required this.id,
    required this.title,
    required this.urlLink,
    required this.description,
    required this.image,
    required this.createTime,
  });

  factory ViewAdvertismentModelData.fromJson(Map<String, dynamic> json) => ViewAdvertismentModelData(
    id: json["id"],
    title: json["title"],
    urlLink: json["url_link"],
    description: json["description"],
    image: json["image"],
    createTime: json["create_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url_link": urlLink,
    "description": description,
    "image": image,
    "create_time": createTime,
  };
}
