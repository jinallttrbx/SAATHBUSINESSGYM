// ignore_for_file: file_names

class LoantypesModel {
  bool? status;
  List<LoantypesModelData>? data;

  LoantypesModel({this.status, this.data});

  LoantypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LoantypesModelData>[];
      json['data'].forEach((v) {
        data!.add(LoantypesModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoantypesModelData {
  int? id;
  String? title;
  int? status;

  LoantypesModelData({this.id, this.title, this.status});

  LoantypesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    return data;
  }
}
