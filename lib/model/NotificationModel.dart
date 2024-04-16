// ignore_for_file: file_names

class NotificationModel {
  bool? status;
  String? message;
  List<NotificationModelData>? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationModelData>[];
      json['data'].forEach((v) {
        data!.add(NotificationModelData.fromJson(v));
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

class NotificationModelData {
  int? id;
  String? userType;
  String? title;
  String? image;
  String? createTime;

  NotificationModelData(
      {this.id, this.userType, this.title, this.image, this.createTime});

  NotificationModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    title = json['title'];
    image = json['image'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['title'] = title;
    data['image'] = image;
    data['create_time'] = createTime;
    return data;
  }
}
