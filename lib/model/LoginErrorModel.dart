// ignore_for_file: file_names

class LoginErrorModel {
  bool? status;
  String? data;

  LoginErrorModel({this.status, this.data});

  LoginErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = data;
    return data;
  }
}
