// To parse this JSON data, do
//
//     final getRecommendedService = getRecommendedServiceFromJson(jsonString);

import 'dart:convert';

GetRecommendedService getRecommendedServiceFromJson(String str) => GetRecommendedService.fromJson(json.decode(str));

String getRecommendedServiceToJson(GetRecommendedService data) => json.encode(data.toJson());

class GetRecommendedService {
  List<GetRecommendedServicedata> data;

  GetRecommendedService({
    required this.data,
  });

  factory GetRecommendedService.fromJson(Map<String, dynamic> json) => GetRecommendedService(
    data: List<GetRecommendedServicedata>.from(json["data"].map((x) => GetRecommendedServicedata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetRecommendedServicedata {
  int id;
  String username;
  String fullName;
  String firstName;
  dynamic lastName;
  String gender;
  dynamic email;
  dynamic companyName;
  String password;
  String userType;
  String contactNumber;
  dynamic occupationId;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  int providerId;
  dynamic address;
  dynamic playerId;
  int status;
  String displayName;
  dynamic providertypeId;
  int isFeatured;
  TimeZone timeZone;
  dynamic lastNotificationSeen;
  dynamic emailVerifiedAt;
  dynamic rememberToken;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  dynamic loginType;
  dynamic serviceAddressId;
  String? uid;
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
  int averageRating;
  int totalRating;
  int userId;
  String name;
  int categoryId;
  int price;
  int minPrice;
  int maxPrice;
  String serviceType;
  dynamic discount;
  String description;
  dynamic addedBy;
  int subcategoryId;
  int workProfileId;
  dynamic city;
  dynamic mapLink;
  dynamic mobile;
  String? type;
  int duration;
  String serviceImage;
  String tag;

  GetRecommendedServicedata({
    required this.id,
    required this.username,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.companyName,
    required this.password,
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
    required this.rememberToken,
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
    required this.averageRating,
    required this.totalRating,
    required this.userId,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.minPrice,
    required this.maxPrice,
    required this.serviceType,
    required this.discount,
    required this.description,
    required this.addedBy,
    required this.subcategoryId,
    required this.workProfileId,
    required this.city,
    required this.mapLink,
    required this.mobile,
    required this.type,
    required this.duration,
    required this.serviceImage,
    required this.tag,
  });

  factory GetRecommendedServicedata.fromJson(Map<String, dynamic> json) => GetRecommendedServicedata(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    email: json["email"],
    companyName: json["company_name"],
    password: json["password"],
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
    timeZone: timeZoneValues.map[json["time_zone"]]!,
    lastNotificationSeen: json["last_notification_seen"],
    emailVerifiedAt: json["email_verified_at"],
    rememberToken: json["remember_token"],
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
    averageRating: json["average_rating"],
    totalRating: json["total_rating"],
    userId: json["user_id"],
    name: json["name"],
    categoryId: json["category_id"],
    price: json["price"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    serviceType: json["service_type"],
    discount: json["discount"],
    description: json["description"],
    addedBy: json["added_by"],
    subcategoryId: json["subcategory_id"],
    workProfileId: json["work_profile_id"],
    city: json["city"],
    mapLink: json["map_link"],
    mobile: json["mobile"],
    type: json["type"],
    duration: json["duration"],
    serviceImage: json["service_image"],
    tag: json["tag"],
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
    "password": password,
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
    "time_zone": timeZoneValues.reverse[timeZone],
    "last_notification_seen": lastNotificationSeen,
    "email_verified_at": emailVerifiedAt,
    "remember_token": rememberToken,
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
    "average_rating": averageRating,
    "total_rating": totalRating,
    "user_id": userId,
    "name": name,
    "category_id": categoryId,
    "price": price,
    "min_price": minPrice,
    "max_price": maxPrice,
    "service_type": serviceType,
    "discount": discount,
    "description": description,
    "added_by": addedBy,
    "subcategory_id": subcategoryId,
    "work_profile_id": workProfileId,
    "city": city,
    "map_link": mapLink,
    "mobile": mobile,
    "type": type,
    "duration": duration,
    "service_image": serviceImage,
    "tag": tag,
  };
}

enum Gender {
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.MALE
});

enum Tag {
  PROVIDER_SERVICE,
  SERVICE
}

final tagValues = EnumValues({
  "Provider Service": Tag.PROVIDER_SERVICE,
  " Service": Tag.SERVICE
});

enum TimeZone {
  UTC
}

final timeZoneValues = EnumValues({
  "UTC": TimeZone.UTC
});

enum Type {
  PROVIDER,
  SUPPLIER
}

final typeValues = EnumValues({
  "provider": Type.PROVIDER,
  "supplier": Type.SUPPLIER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
