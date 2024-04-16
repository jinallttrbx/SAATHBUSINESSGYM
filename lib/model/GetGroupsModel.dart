

class GetGroupsModel {
  String? message;
  bool? status;
  List<GetGroupsModelData>? data;

  GetGroupsModel({this.message, this.status, this.data});

  GetGroupsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetGroupsModelData>[];
      json['data'].forEach((v) {
        data!.add(GetGroupsModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetGroupsModelData {
  int? id;
  int? userId;
  int? Groupid;
  String? groupTitle;
  String? groupDescription;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  String? status;

  GetGroupsModelData(
      {this.id,
      this.userId,
        this.Groupid,
      this.groupTitle,
      this.groupDescription,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.status});

  GetGroupsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    Groupid=json['group_id'];
    groupTitle = json['group_title'];
    groupDescription = json['group_description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group_id'] =this.Groupid;
    data['group_title'] = this.groupTitle;
    data['group_description'] = this.groupDescription;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
