// To parse this JSON data, do
//
//     final viewAdvertismentdetailModel = viewAdvertismentdetailModelFromJson(jsonString);

import 'dart:convert';

ViewAdvertismentdetailModel viewAdvertismentdetailModelFromJson(String str) => ViewAdvertismentdetailModel.fromJson(json.decode(str));

String viewAdvertismentdetailModelToJson(ViewAdvertismentdetailModel data) => json.encode(data.toJson());

class ViewAdvertismentdetailModel {
  bool status;
  String message;
  List<ViewAdvertismentdetailModeldata> data;

  ViewAdvertismentdetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewAdvertismentdetailModel.fromJson(Map<String, dynamic> json) => ViewAdvertismentdetailModel(
    status: json["status"],
    message: json["message"],
    data: List<ViewAdvertismentdetailModeldata>.from(json["data"].map((x) => ViewAdvertismentdetailModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewAdvertismentdetailModeldata {
  String title;
  String urlLink;
  String description;
  String image;
  String createTime;

  ViewAdvertismentdetailModeldata({
    required this.title,
    required this.urlLink,
    required this.description,
    required this.image,
    required this.createTime,
  });

  factory ViewAdvertismentdetailModeldata.fromJson(Map<String, dynamic> json) => ViewAdvertismentdetailModeldata(
    title: json["title"],
    urlLink: json["url_link"],
    description: json["description"],
    image: json["image"],
    createTime: json["create_time"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url_link": urlLink,
    "description": description,
    "image": image,
    "create_time": createTime,
  };
}
