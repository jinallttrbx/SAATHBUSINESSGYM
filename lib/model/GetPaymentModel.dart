// ignore_for_file: file_names

class GetPaymentModel {
  String? message;
  bool? status;
  List<GetPaymentModelData>? data;

  GetPaymentModel({this.message, this.status, this.data});

  GetPaymentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetPaymentModelData>[];
      json['data'].forEach((v) {
        data!.add(GetPaymentModelData.fromJson(v));
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

class GetPaymentModelData {
  int? id;
  String? title;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  GetPaymentModelData(
      {this.id, this.title, this.deletedAt, this.createdAt, this.updatedAt});

  GetPaymentModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
