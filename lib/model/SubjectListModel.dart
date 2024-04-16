// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  String message;
  bool status;
  List<SubjectModeldata> data;

  SubjectModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    message: json["message"],
    status: json["status"],
    data: List<SubjectModeldata>.from(json["data"].map((x) => SubjectModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubjectModeldata {
  int id;
  String subjectTital;
  String userType;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  SubjectModeldata({
    required this.id,
    required this.subjectTital,
    required this.userType,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubjectModeldata.fromJson(Map<String, dynamic> json) => SubjectModeldata(
    id: json["id"],
    subjectTital: json["subject_tital"],
    userType: json["user_type"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_tital": subjectTital,
    "user_type": userType,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
