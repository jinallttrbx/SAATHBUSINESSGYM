// To parse this JSON data, do
//
//     final workProfileModel = workProfileModelFromJson(jsonString);

import 'dart:convert';

WorkProfileModel workProfileModelFromJson(String str) => WorkProfileModel.fromJson(json.decode(str));

String workProfileModelToJson(WorkProfileModel data) => json.encode(data.toJson());

class WorkProfileModel {
  bool status;
  List<WorkProfileModeldata> data;

  WorkProfileModel({
    required this.status,
    required this.data,
  });

  factory WorkProfileModel.fromJson(Map<String, dynamic> json) => WorkProfileModel(
    status: json["status"],
    data: List<WorkProfileModeldata>.from(json["data"].map((x) => WorkProfileModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WorkProfileModeldata {
  int workProfileId;
  String workProfileName;
  dynamic email;
  String modeOfBusiness;
  String businessAddress;
  String location;
  String mobile;
  int travelCharge;
  String gstNumber;
  String licenceNumber;
  dynamic fssaiNumber;
  int latitude;
  String openAt;
  String closeAt;
  int longitude;
  String title;
  String subTitle;
  int typeId;
  dynamic timing;
  int serviceCount;
  int productCount;

  WorkProfileModeldata({
    required this.workProfileId,
    required this.workProfileName,
    required this.email,
    required this.modeOfBusiness,
    required this.businessAddress,
    required this.location,
    required this.mobile,
    required this.travelCharge,
    required this.gstNumber,
    required this.licenceNumber,
    required this.fssaiNumber,
    required this.latitude,
    required this.openAt,
    required this.closeAt,
    required this.longitude,
    required this.title,
    required this.subTitle,
    required this.typeId,
    required this.timing,
    required this.serviceCount,
    required this.productCount,
  });

  factory WorkProfileModeldata.fromJson(Map<String, dynamic> json) => WorkProfileModeldata(
    workProfileId: json["work_profile_id"],
    workProfileName: json["work_profile_name"],
    email: json["email"],
    modeOfBusiness: json["mode_of_business"],
    businessAddress: json["business_address"],
    location: json["location"],
    mobile: json["mobile"],
    travelCharge: json["travel_charge"],
    gstNumber: json["gst_number"],
    licenceNumber: json["licence_number"],
    fssaiNumber: json["fssai_number"],
    latitude: json["latitude"],
    openAt: json["open_at"],
    closeAt: json["close_at"],
    longitude: json["longitude"],
    title: json["title"],
    subTitle: json["sub_title"],
    typeId: json["type_id"],
    timing: json["timing"],
    serviceCount: json["service_count"],
    productCount: json["product_count"],
  );

  Map<String, dynamic> toJson() => {
    "work_profile_id": workProfileId,
    "work_profile_name": workProfileName,
    "email": email,
    "mode_of_business": modeOfBusiness,
    "business_address": businessAddress,
    "location": location,
    "mobile": mobile,
    "travel_charge": travelCharge,
    "gst_number": gstNumber,
    "licence_number": licenceNumber,
    "fssai_number": fssaiNumber,
    "latitude": latitude,
    "open_at": openAt,
    "close_at": closeAt,
    "longitude": longitude,
    "title": title,
    "sub_title": subTitle,
    "type_id": typeId,
    "timing": timing,
    "service_count": serviceCount,
    "product_count": productCount,
  };
}
