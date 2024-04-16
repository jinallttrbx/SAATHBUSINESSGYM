// To parse this JSON data, do
//
//     final serchlistmodel = serchlistmodelFromJson(jsonString);

import 'dart:convert';

Serchlistmodel serchlistmodelFromJson(String str) => Serchlistmodel.fromJson(json.decode(str));

String serchlistmodelToJson(Serchlistmodel data) => json.encode(data.toJson());

class Serchlistmodel {
  List<Serchlistmodeldata> data;
  bool status;
  String message;

  Serchlistmodel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory Serchlistmodel.fromJson(Map<String, dynamic> json) => Serchlistmodel(
    data: List<Serchlistmodeldata>.from(json["data"].map((x) => Serchlistmodeldata.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Serchlistmodeldata {
  String type;
  int userid;
  String name;
  String subCategoryName;
  String providername;
  String profileImage;
  int rating;

  Serchlistmodeldata({
    required this.type,
    required this.userid,
    required this.name,
    required this.subCategoryName,
    required this.providername,
    required this.profileImage,
    required this.rating,
  });

  factory Serchlistmodeldata.fromJson(Map<String, dynamic> json) => Serchlistmodeldata(
    type: json["type"],
    userid: json["userid"],
    name: json["name"],
    subCategoryName: json["sub_category_name"],
    providername: json["providername"],
    profileImage: json["profile_image"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "userid": userid,
    "name": name,
    "sub_category_name": subCategoryName,
    "providername": providername,
    "profile_image": profileImage,
    "rating": rating,
  };
}
