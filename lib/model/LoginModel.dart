// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String message;
  Data data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String username;
  String fullName;
  String firstName;
  String lastName;
  String gender;
  String email;
  dynamic companyName;
  String userType;
  String contactNumber;
  dynamic occupationId;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic providerId;
  dynamic address;
  dynamic playerId;
  int status;
  String displayName;
  dynamic providertypeId;
  int isFeatured;
  String timeZone;
  dynamic lastNotificationSeen;
  dynamic emailVerifiedAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  dynamic loginType;
  dynamic serviceAddressId;
  dynamic uid;
  dynamic handymantypeId;
  int isSubscribe;
  dynamic socialImage;
  int isAvailable;
  dynamic designation;
  dynamic lastOnlineTime;
  dynamic modeOfBusiness;
  dynamic businessTiming;
  dynamic perKmTravelCharges;
  dynamic gstNumber;
  dynamic licenseNumber;
  dynamic fassaiNumber;
  dynamic occuaptionId;
  int isAccount;
  String referralCode;
  int isSupplier;
  int organizationsId;
  double latitude;
  double longitude;
  dynamic userOpenAt;
  dynamic userCloseAt;
  List<String> userRole;
  String apiToken;
  String profileImage;
  int isVerifyProvider;

  Data({
    required this.id,
    required this.username,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.companyName,
    required this.userType,
    required this.contactNumber,
    required this.occupationId,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.providerId,
    required this.address,
    required this.playerId,
    required this.status,
    required this.displayName,
    required this.providertypeId,
    required this.isFeatured,
    required this.timeZone,
    required this.lastNotificationSeen,
    required this.emailVerifiedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.stripeId,
    required this.pmType,
    required this.pmLastFour,
    required this.trialEndsAt,
    required this.loginType,
    required this.serviceAddressId,
    required this.uid,
    required this.handymantypeId,
    required this.isSubscribe,
    required this.socialImage,
    required this.isAvailable,
    required this.designation,
    required this.lastOnlineTime,
    required this.modeOfBusiness,
    required this.businessTiming,
    required this.perKmTravelCharges,
    required this.gstNumber,
    required this.licenseNumber,
    required this.fassaiNumber,
    required this.occuaptionId,
    required this.isAccount,
    required this.referralCode,
    required this.isSupplier,
    required this.organizationsId,
    required this.latitude,
    required this.longitude,
    required this.userOpenAt,
    required this.userCloseAt,
    required this.userRole,
    required this.apiToken,
    required this.profileImage,
    required this.isVerifyProvider,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    email: json["email"],
    companyName: json["company_name"],
    userType: json["user_type"],
    contactNumber: json["contact_number"],
    occupationId: json["occupation_id"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    providerId: json["provider_id"],
    address: json["address"],
    playerId: json["player_id"],
    status: json["status"],
    displayName: json["display_name"],
    providertypeId: json["providertype_id"],
    isFeatured: json["is_featured"],
    timeZone: json["time_zone"],
    lastNotificationSeen: json["last_notification_seen"],
    emailVerifiedAt: json["email_verified_at"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stripeId: json["stripe_id"],
    pmType: json["pm_type"],
    pmLastFour: json["pm_last_four"],
    trialEndsAt: json["trial_ends_at"],
    loginType: json["login_type"],
    serviceAddressId: json["service_address_id"],
    uid: json["uid"],
    handymantypeId: json["handymantype_id"],
    isSubscribe: json["is_subscribe"],
    socialImage: json["social_image"],
    isAvailable: json["is_available"],
    designation: json["designation"],
    lastOnlineTime: json["last_online_time"],
    modeOfBusiness: json["mode_of_business"],
    businessTiming: json["business_timing"],
    perKmTravelCharges: json["per_km_travel_charges"],
    gstNumber: json["gst_number"],
    licenseNumber: json["license_number"],
    fassaiNumber: json["fassai_number"],
    occuaptionId: json["occuaption_id"],
    isAccount: json["is_account"],
    referralCode: json["referral_code"],
    isSupplier: json["isSupplier"],
    organizationsId: json["organizations_id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    userOpenAt: json["user_open_at"],
    userCloseAt: json["user_close_at"],
    userRole: List<String>.from(json["user_role"].map((x) => x)),
    apiToken: json["api_token"],
    profileImage: json["profile_image"],
    isVerifyProvider: json["is_verify_provider"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "full_name": fullName,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "email": email,
    "company_name": companyName,
    "user_type": userType,
    "contact_number": contactNumber,
    "occupation_id": occupationId,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "provider_id": providerId,
    "address": address,
    "player_id": playerId,
    "status": status,
    "display_name": displayName,
    "providertype_id": providertypeId,
    "is_featured": isFeatured,
    "time_zone": timeZone,
    "last_notification_seen": lastNotificationSeen,
    "email_verified_at": emailVerifiedAt,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "stripe_id": stripeId,
    "pm_type": pmType,
    "pm_last_four": pmLastFour,
    "trial_ends_at": trialEndsAt,
    "login_type": loginType,
    "service_address_id": serviceAddressId,
    "uid": uid,
    "handymantype_id": handymantypeId,
    "is_subscribe": isSubscribe,
    "social_image": socialImage,
    "is_available": isAvailable,
    "designation": designation,
    "last_online_time": lastOnlineTime,
    "mode_of_business": modeOfBusiness,
    "business_timing": businessTiming,
    "per_km_travel_charges": perKmTravelCharges,
    "gst_number": gstNumber,
    "license_number": licenseNumber,
    "fassai_number": fassaiNumber,
    "occuaption_id": occuaptionId,
    "is_account": isAccount,
    "referral_code": referralCode,
    "isSupplier": isSupplier,
    "organizations_id": organizationsId,
    "latitude": latitude,
    "longitude": longitude,
    "user_open_at": userOpenAt,
    "user_close_at": userCloseAt,
    "user_role": List<dynamic>.from(userRole.map((x) => x)),
    "api_token": apiToken,
    "profile_image": profileImage,
    "is_verify_provider": isVerifyProvider,
  };
}
