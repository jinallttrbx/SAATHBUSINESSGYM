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
  dynamic type;
  dynamic userid;
  dynamic typeId;
  dynamic name;
  dynamic subCategoryName;
  dynamic providername;
  dynamic profileImage;
  dynamic rating;

  Serchlistmodeldata({
    required this.type,
    required this.userid,
    required this.typeId,
    required this.name,
    required this.subCategoryName,
    required this.providername,
    required this.profileImage,
    required this.rating,
  });

  factory Serchlistmodeldata.fromJson(Map<String, dynamic> json) => Serchlistmodeldata(
    type: json["type"],
    userid: json["userid"],
    typeId: json["type_id"],
    name: json["name"],
    subCategoryName: json["sub_category_name"],
    providername: json["providername"],
    profileImage: json["profile_image"],
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "userid": userid,
    "type_id": typeId,
    "name": name,
    "sub_category_name": subCategoryName,
    "providername": providername,
    "profile_image": profileImage,
    "rating": rating,
  };
}
