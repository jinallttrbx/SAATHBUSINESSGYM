// ignore_for_file: file_names

class GetSupportSubjectModel {
  String? message;
  bool? status;
  List<GetSupportSubjectData>? data;

  GetSupportSubjectModel({this.message, this.status, this.data});

  GetSupportSubjectModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetSupportSubjectData>[];
      json['data'].forEach((v) {
        data!.add(GetSupportSubjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSupportSubjectData {
  int? id;
  String? subjectTital;
  String? userType;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  GetSupportSubjectData(
      {this.id,
      this.subjectTital,
      this.userType,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  GetSupportSubjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectTital = json['subject_tital'];
    userType = json['user_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_tital'] = subjectTital;
    data['user_type'] = userType;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
