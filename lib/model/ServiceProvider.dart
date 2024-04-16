// To parse this JSON data, do
//
//     final serviceProviderList = serviceProviderListFromJson(jsonString);

import 'dart:convert';

ServiceProviderList serviceProviderListFromJson(String str) => ServiceProviderList.fromJson(json.decode(str));

String serviceProviderListToJson(ServiceProviderList data) => json.encode(data.toJson());

class ServiceProviderList {
  List<ServiceProviderdata> data;

  ServiceProviderList({
    required this.data,
  });

  factory ServiceProviderList.fromJson(Map<String, dynamic> json) => ServiceProviderList(
    data: List<ServiceProviderdata>.from(json["data"].map((x) => ServiceProviderdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ServiceProviderdata {
  int id;
  int providerId;
  dynamic type;
  int duration;
  DateTime createdAt;
  DateTime updatedAt;
  int subcategoryId;
  dynamic occupationId;
  int workProfileId;
  dynamic city;
  dynamic mobile;
  dynamic email;
  int totalRating;
  int averageRating;
  int categoryId;
  String categoryName;
  String username;
  int userId;
  String contactNumber;
  dynamic gstNumber;
  dynamic fassaiNumber;
  String location;
  double latitude;
  double longitude;
  String openAt;
  String closeAt;
  String profileImage;
  String serviceImage;
  int workingHour;

  ServiceProviderdata({
    required this.id,
    required this.providerId,
    required this.type,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategoryId,
    required this.occupationId,
    required this.workProfileId,
    required this.city,
    required this.mobile,
    required this.email,
    required this.totalRating,
    required this.averageRating,
    required this.categoryId,
    required this.categoryName,
    required this.username,
    required this.userId,
    required this.contactNumber,
    required this.gstNumber,
    required this.fassaiNumber,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.openAt,
    required this.closeAt,
    required this.profileImage,
    required this.serviceImage,
    required this.workingHour,
  });

  factory ServiceProviderdata.fromJson(Map<String, dynamic> json) => ServiceProviderdata(
    id: json["id"],
    providerId: json["provider_id"],
    type: json["type"],
    duration: json["duration"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subcategoryId: json["subcategory_id"],
    occupationId: json["occupation_id"],
    workProfileId: json["work_profile_id"],
    city: json["city"],
    mobile: json["mobile"],
    email: json["email"],
    totalRating: json["total_rating"],
    averageRating: json["average_rating"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    username: json["username"],
    userId: json["user_id"],
    contactNumber: json["contact_number"],
    gstNumber: json["gst_number"],
    fassaiNumber: json["fassai_number"],
    location: json["location"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    openAt: json["open_at"],
    closeAt: json["close_at"],
    profileImage: json["profile_image"],
    serviceImage: json["service_image"],
    workingHour: json["working_hour"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "type": type,
    "duration": duration,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "subcategory_id": subcategoryId,
    "occupation_id": occupationId,
    "work_profile_id": workProfileId,
    "city": city,
    "mobile": mobile,
    "email": email,
    "total_rating": totalRating,
    "average_rating": averageRating,
    "category_id": categoryId,
    "category_name": categoryName,
    "username": username,
    "user_id": userId,
    "contact_number": contactNumber,
    "gst_number": gstNumber,
    "fassai_number": fassaiNumber,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "open_at": openAt,
    "close_at": closeAt,
    "profile_image": profileImage,
    "service_image": serviceImage,
    "working_hour": workingHour,
  };
}
