// ignore_for_file: non_constant_identifier_names

class ProviderModel {
  List<Data>? data;

  ProviderModel({this.data});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? serviceId;
  String? serviceName;
  int? providerId;
  var rating;
  int? user_id;
  String? displayName;
  String? contactNumber;
  dynamic companyName;
  dynamic socialImage;
  String? profile_pic;
  String? service_attachment;

  Data(
      {this.serviceId,
      this.serviceName,
      this.providerId,
      this.rating,
      this.user_id,
      this.displayName,
      this.contactNumber,
      this.companyName,
      this.profile_pic,
      this.service_attachment,
      this.socialImage});

  Data.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    providerId = json['provider_id'];
    rating = json['rating'];
    user_id = json['user_id'];
    displayName = json['display_name'];
    contactNumber = json['contact_number'];
    companyName = json['company_name'];
    socialImage = json['social_image'];
    profile_pic = json['profile_pic'];
    service_attachment = json['service_attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['provider_id'] = providerId;
    data['rating'] = rating;
    data['user_id'] = user_id;
    data['display_name'] = displayName;
    data['contact_number'] = contactNumber;
    data['company_name'] = companyName;
    data['social_image'] = socialImage;
    data['profile_pic'] = profile_pic;
    data['service_attachment'] = service_attachment;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "mobile $contactNumber";
  }
}
