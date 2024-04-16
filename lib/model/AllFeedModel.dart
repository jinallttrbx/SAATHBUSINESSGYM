// To parse this JSON data, do
//
//     final allFeedModel = allFeedModelFromJson(jsonString);

import 'dart:convert';

AllFeedModel allFeedModelFromJson(String str) => AllFeedModel.fromJson(json.decode(str));

String allFeedModelToJson(AllFeedModel data) => json.encode(data.toJson());

class AllFeedModel {
  String message;
  bool status;
  List<AllFeedModeldata> data;

  AllFeedModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AllFeedModel.fromJson(Map<String, dynamic> json) => AllFeedModel(
    message: json["message"],
    status: json["status"],
    data: List<AllFeedModeldata>.from(json["data"].map((x) => AllFeedModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllFeedModeldata {
  int id;
  int? categoryId;
  String? videoTital;
  String? videoShortDescription;
  String? videoDuration;
  VideoType? videoType;
  String? youtubeUrl;
  ViewType? viewType;
  int? orderNumber;
  int? videoStatus;
  int? isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime? updatedAt;
  String? thumbnailImage;
  int? totalLike;
  int? totalComments;
  String type;
  CorrectAns? correctAns;
  String? correctAnsValue;
  CorrectAnsFull? correctAnsFull;
  String? quizQuestion;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? answer;
  AnswerValue? answerValue;
  CreateTime? createTime;
  String? pollsQuestion;
  List<Percentage>? percentage;
  List<Option>? option;
  String? title;
  String? link;

  AllFeedModeldata({
    required this.id,
    this.categoryId,
    this.videoTital,
    this.videoShortDescription,
    this.videoDuration,
    this.videoType,
    this.youtubeUrl,
    this.viewType,
    this.orderNumber,
    this.videoStatus,
    this.isFeatured,
    this.deletedAt,
    required this.createdAt,
    this.updatedAt,
    this.thumbnailImage,
    this.totalLike,
    this.totalComments,
    required this.type,
    this.correctAns,
    this.correctAnsValue,
    this.correctAnsFull,
    this.quizQuestion,
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.answer,
    this.answerValue,
    this.createTime,
    this.pollsQuestion,
    this.percentage,
    this.option,
    this.title,
    this.link,
  });

  factory AllFeedModeldata.fromJson(Map<String, dynamic> json) => AllFeedModeldata(
    id: json["id"],
    categoryId: json["category_id"],
    videoTital: json["video_tital"],
    videoShortDescription: json["video_short_description"],
    videoDuration: json["video_duration"],
    videoType: videoTypeValues.map[json["video_type"]],
    youtubeUrl: json["youtube_url"],
    viewType: viewTypeValues.map[json["view_type"]],
    orderNumber: json["order_number"],
    videoStatus: json["video_status"],
    isFeatured: json["is_featured"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    thumbnailImage: json["thumbnail_image"],
    totalLike: json["total_like"],
    totalComments: json["total_comments"],
    type: json["type"],
    correctAns: correctAnsValues.map[json["correct_ans"]],
    correctAnsValue: json["correct_ans_value"],
    correctAnsFull: correctAnsFullValues.map[json["correct_ans_full"]],
    quizQuestion: json["quiz_question"],
    answerA: json["answer_a"],
    answerB: json["answer_b"],
    answerC: json["answer_c"],
    answerD: json["answer_d"],
    answer: json["answer"],
    answerValue: answerValueValues.map[json["answer_value"]],
    createTime: createTimeValues.map[json["create_time"]],
    pollsQuestion: json["polls_question"],
    percentage: json["percentage"] == null ? [] : List<Percentage>.from(json["percentage"]!.map((x) => Percentage.fromJson(x))),
    option: json["option"] == null ? [] : List<Option>.from(json["option"]!.map((x) => Option.fromJson(x))),
    title: json["title"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "video_tital": videoTital,
    "video_short_description": videoShortDescription,
    "video_duration": videoDuration,
    "video_type": videoTypeValues.reverse[videoType],
    "youtube_url": youtubeUrl,
    "view_type": viewTypeValues.reverse[viewType],
    "order_number": orderNumber,
    "video_status": videoStatus,
    "is_featured": isFeatured,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "thumbnail_image": thumbnailImage,
    "total_like": totalLike,
    "total_comments": totalComments,
    "type": type,
    "correct_ans": correctAnsValues.reverse[correctAns],
    "correct_ans_value": correctAnsValue,
    "correct_ans_full": correctAnsFullValues.reverse[correctAnsFull],
    "quiz_question": quizQuestion,
    "answer_a": answerA,
    "answer_b": answerB,
    "answer_c": answerC,
    "answer_d": answerD,
    "answer": answer,
    "answer_value": answerValueValues.reverse[answerValue],
    "create_time": createTimeValues.reverse[createTime],
    "polls_question": pollsQuestion,
    "percentage": percentage == null ? [] : List<dynamic>.from(percentage!.map((x) => x.toJson())),
    "option": option == null ? [] : List<dynamic>.from(option!.map((x) => x.toJson())),
    "title": title,
    "link": link,
  };
}

enum AnswerValue {
  EMPTY,
  PAYTM,
  YES
}

final answerValueValues = EnumValues({
  "": AnswerValue.EMPTY,
  "Paytm": AnswerValue.PAYTM,
  "Yes": AnswerValue.YES
});

enum CorrectAns {
  A,
  B,
  C,
  D
}

final correctAnsValues = EnumValues({
  "A": CorrectAns.A,
  "B": CorrectAns.B,
  "C": CorrectAns.C,
  "D": CorrectAns.D
});

enum CorrectAnsFull {
  ANSWER_A,
  ANSWER_B,
  ANSWER_C,
  ANSWER_D
}

final correctAnsFullValues = EnumValues({
  "answer_a": CorrectAnsFull.ANSWER_A,
  "answer_b": CorrectAnsFull.ANSWER_B,
  "answer_c": CorrectAnsFull.ANSWER_C,
  "answer_d": CorrectAnsFull.ANSWER_D
});

enum CreateTime {
  THE_10_MONTHS_AGO,
  THE_11_MONTHS_AGO,
  THE_1_MONTH_AGO,
  THE_1_YEAR_AGO
}

final createTimeValues = EnumValues({
  "10 months ago": CreateTime.THE_10_MONTHS_AGO,
  "11 months ago": CreateTime.THE_11_MONTHS_AGO,
  "1 month ago": CreateTime.THE_1_MONTH_AGO,
  "1 year ago": CreateTime.THE_1_YEAR_AGO
});

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
  CorrectAns poll;
  int total;
  int percetage;

  Percentage({
    required this.poll,
    required this.total,
    required this.percetage,
  });

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    poll: correctAnsValues.map[json["poll"]]!,
    total: json["total"],
    percetage: json["percetage"],
  );

  Map<String, dynamic> toJson() => {
    "poll": correctAnsValues.reverse[poll],
    "total": total,
    "percetage": percetage,
  };
}

enum Type {
  NEWS,
  POLLS,
  QUIZ,
  VIDEO
}

final typeValues = EnumValues({
  "news": Type.NEWS,
  "polls": Type.POLLS,
  "quiz": Type.QUIZ,
  "video": Type.VIDEO
});

enum VideoType {
  LOCAL,
  YOUTUBE
}

final videoTypeValues = EnumValues({
  "local": VideoType.LOCAL,
  "youtube": VideoType.YOUTUBE
});

enum ViewType {
  PROVIDER,
  USER,
  USER_PROVIDER
}

final viewTypeValues = EnumValues({
  "[\"provider\"]": ViewType.PROVIDER,
  "[\"user\"]": ViewType.USER,
  "[\"user\",\"provider\"]": ViewType.USER_PROVIDER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
