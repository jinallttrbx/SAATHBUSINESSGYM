class MemebrGroupModel {
  String? message;
  bool? status;
  List<MemebrGroupModelData>? data;

  MemebrGroupModel({this.message, this.status, this.data});

  MemebrGroupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <MemebrGroupModelData>[];
      json['data'].forEach((v) {
        data!.add(new MemebrGroupModelData.fromJson(v));
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

class MemebrGroupModelData {
  String? id;
  String? uid;
  String? displayName;
  String? firstName;
  String? lastName;
  String? username;
  String? providerId;
  String? email;
  String? contactNumber;
  String? designation;
  String? profileImage;

  MemebrGroupModelData(
      {this.id,
      this.uid,
      this.displayName,
      this.firstName,
      this.lastName,
      this.username,
      this.providerId,
      this.email,
      this.contactNumber,
      this.designation,
      this.profileImage});

  MemebrGroupModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    uid = json['uid'];
    displayName = json['display_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    providerId = json['provider_id'].toString();
    email = json['email'];
    contactNumber = json['contact_number'];
    designation = json['designation'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['display_name'] = this.displayName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['provider_id'] = this.providerId;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    data['designation'] = this.designation;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
