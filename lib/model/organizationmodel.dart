// To parse this JSON data, do
//
//     final organizationmodel = organizationmodelFromJson(jsonString);

import 'dart:convert';

OrganizationModel organizationmodelFromJson(String str) => OrganizationModel.fromJson(json.decode(str));

String organizationmodelToJson(OrganizationModel data) => json.encode(data.toJson());

class OrganizationModel {
  List<Organizationmodeldata> data;
  bool status;
  String message;

  OrganizationModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
    data: List<Organizationmodeldata>.from(json["data"].map((x) => Organizationmodeldata.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Organizationmodeldata {
  int id;
  String name;
  int stateId;
  String image;
  String description;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String stateName;

  Organizationmodeldata({
    required this.id,
    required this.name,
    required this.stateId,
    required this.image,
    required this.description,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.stateName,
  });

  factory Organizationmodeldata.fromJson(Map<String, dynamic> json) => Organizationmodeldata(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    image: json["image"],
    description: json["description"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "image": image,
    "description": description,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "state_name": stateName,
  };
}
