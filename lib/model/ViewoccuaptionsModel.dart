// To parse this JSON data, do
//
//     final viewoccuaptionsModel = viewoccuaptionsModelFromJson(jsonString);

import 'dart:convert';

ViewoccuaptionsModel viewoccuaptionsModelFromJson(String str) => ViewoccuaptionsModel.fromJson(json.decode(str));

String viewoccuaptionsModelToJson(ViewoccuaptionsModel data) => json.encode(data.toJson());

class ViewoccuaptionsModel {
  bool statsu;
  String messsage;
  List<ViewoccuaptionsModelData> data;

  ViewoccuaptionsModel({
    required this.statsu,
    required this.messsage,
    required this.data,
  });

  factory ViewoccuaptionsModel.fromJson(Map<String, dynamic> json) => ViewoccuaptionsModel(
    statsu: json["statsu"],
    messsage: json["messsage"],
    data: List<ViewoccuaptionsModelData>.from(json["data"].map((x) => ViewoccuaptionsModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statsu": statsu,
    "messsage": messsage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewoccuaptionsModelData {
  int id;
  String title;
  int status;

  ViewoccuaptionsModelData({
    required this.id,
    required this.title,
    required this.status,
  });

  factory ViewoccuaptionsModelData.fromJson(Map<String, dynamic> json) => ViewoccuaptionsModelData(
    id: json["id"],
    title: json["title"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
  };
}
