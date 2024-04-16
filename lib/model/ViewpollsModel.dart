// To parse this JSON data, do
//
//     final viewpollsModel = viewpollsModelFromJson(jsonString);

import 'dart:convert';

ViewpollsModel viewpollsModelFromJson(String str) => ViewpollsModel.fromJson(json.decode(str));

String viewpollsModelToJson(ViewpollsModel data) => json.encode(data.toJson());

class ViewpollsModel {
  bool status;
  String message;
  List<ViewpollsModelData> data;

  ViewpollsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewpollsModel.fromJson(Map<String, dynamic> json) => ViewpollsModel(
    status: json["status"],
    message: json["message"],
    data: List<ViewpollsModelData>.from(json["data"].map((x) => ViewpollsModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ViewpollsModelData {
  int id;
  String question;
  List<Percentage> percentage;
  List<Option> option;
  String answerValue;
  String createTime;

  ViewpollsModelData({
    required this.id,
    required this.question,
    required this.percentage,
    required this.option,
    required this.answerValue,
    required this.createTime,
  });

  factory ViewpollsModelData.fromJson(Map<String, dynamic> json) => ViewpollsModelData(
    id: json["id"],
    question: json["question"],
    percentage: List<Percentage>.from(json["percentage"].map((x) => Percentage.fromJson(x))),
    option: List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    answerValue: json["answer_value"],
    createTime: json["create_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "percentage": List<dynamic>.from(percentage.map((x) => x.toJson())),
    "option": List<dynamic>.from(option.map((x) => x.toJson())),
    "answer_value": answerValue,
    "create_time": createTime,
  };
}

class Option {
  String option;

  Option({
    required this.option,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "option": option,
  };
}

class Percentage {
  String poll;
  int total;
  int percetage;

  Percentage({
    required this.poll,
    required this.total,
    required this.percetage,
  });

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    poll: json["poll"],
    total: json["total"],
    percetage: json["percetage"],
  );

  Map<String, dynamic> toJson() => {
    "poll": poll,
    "total": total,
    "percetage": percetage,
  };
}
