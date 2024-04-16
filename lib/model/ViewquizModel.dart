class ViewquizModel {
  bool? status;
  String? message;
  List<ViewquizModelData>? data;

  ViewquizModel({this.status, this.message, this.data});

  ViewquizModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewquizModelData>[];
      json['data'].forEach((v) {
        data!.add(ViewquizModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewquizModelData {
  int? id;
  String? correctAns;
  String? correctAnsValue;
  String? correctAnsFull;
  String? question;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? createdAt;
  String? answer;
  String? answerValue;
  String? createTime;

  ViewquizModelData(
      {this.id,
      this.correctAns,
      this.correctAnsValue,
      this.correctAnsFull,
      this.question,
      this.answerA,
      this.answerB,
      this.answerC,
      this.answerD,
      this.createdAt,
      this.answer,
      this.answerValue,
      this.createTime});

  ViewquizModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    correctAns = json['correct_ans'];
    correctAnsValue = json['correct_ans_value'];
    correctAnsFull = json['correct_ans_full'];
    question = json['question'];
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'];
    answerD = json['answer_d'];
    createdAt = json['created_at'];
    answer = json['answer'];
    answerValue = json['answer_value'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['correct_ans'] = correctAns;
    data['correct_ans_value'] = correctAnsValue;
    data['correct_ans_full'] = correctAnsFull;
    data['question'] = question;
    data['answer_a'] = answerA;
    data['answer_b'] = answerB;
    data['answer_c'] = answerC;
    data['answer_d'] = answerD;
    data['created_at'] = createdAt;
    data['answer'] = answer;
    data['answer_value'] = answerValue;
    data['create_time'] = createTime;
    return data;
  }
}
