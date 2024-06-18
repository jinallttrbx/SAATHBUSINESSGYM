
// To parse this JSON data, do
//
//     final getRecommendedService = getRecommendedServiceFromJson(jsonString);

import 'dart:convert';

GetRecommendedProduct getRecommendedServiceFromJson(String str) => GetRecommendedProduct.fromJson(json.decode(str));

String getRecommendedServiceToJson(GetRecommendedProduct data) => json.encode(data.toJson());

class GetRecommendedProduct {
  List<GetRecommendedProductdata> data;

  GetRecommendedProduct({
    required this.data,
  });

  factory GetRecommendedProduct.fromJson(Map<String, dynamic> json) => GetRecommendedProduct(
    data: List<GetRecommendedProductdata>.from(json["data"].map((x) => GetRecommendedProductdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetRecommendedProductdata {
  dynamic id;
  dynamic username;
  dynamic displayName;
  dynamic fullName;
  dynamic firstName;
  dynamic lastName;
  dynamic gender;
  dynamic email;
  dynamic companyName;
  dynamic password;
  dynamic userType;
  dynamic contactNumber;
  dynamic occupationId;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic providerId;
  dynamic address;
  dynamic playerId;
  dynamic status;
  dynamic providertypeId;
  dynamic isFeatured;
  dynamic timeZone;
  dynamic lastNotificationSeen;
  dynamic emailVerifiedAt;
  dynamic rememberToken;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  dynamic loginType;
  dynamic serviceAddressId;
  dynamic uid;
  dynamic handymantypeId;
  dynamic isSubscribe;
  dynamic socialImage;
  dynamic isAvailable;
  dynamic designation;
  dynamic lastOnlineTime;
  dynamic modeOfBusiness;
  dynamic businessTiming;
  dynamic perKmTravelCharges;
  dynamic gstNumber;
  dynamic licenseNumber;
  dynamic fassaiNumber;
  dynamic occuaptionId;
  dynamic isAccount;
  dynamic referralCode;
  dynamic isSupplier;
  dynamic? organizationsId;
  dynamic latitude;
  dynamic longitude;
  dynamic averageRating;
  dynamic totalRating;
  dynamic userId;
  dynamic name;
  dynamic categoryId;
  dynamic price;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic type;
  dynamic discount;
  dynamic description;
  dynamic addedBy;
  dynamic subcategoryId;
  dynamic workProfileId;
  dynamic city;
  dynamic mapLink;
  dynamic mobile;
  dynamic productType;
  dynamic duration;
  dynamic productImage;
  dynamic tag;

  GetRecommendedProductdata({
    required this.id,
    required this.username,
    required this.displayName,
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
    required this.type,
    required this.discount,
    required this.description,
    required this.addedBy,
    required this.subcategoryId,
    required this.workProfileId,
    required this.city,
    required this.mapLink,
    required this.mobile,
    required this.productType,
    required this.duration,
    required this.productImage,
    required this.tag,
  });

  factory GetRecommendedProductdata.fromJson(Map<String, dynamic> json) => GetRecommendedProductdata(
    id: json["id"],
    username: json["username"],
    displayName: json["display_name"],
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
    providertypeId: json["providertype_id"],
    isFeatured: json["is_featured"],
    timeZone: json["time_zone"],
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
    averageRating: json["average_rating"]?.toDouble(),
    totalRating: json["total_rating"]?.toDouble(),
    userId: json["user_id"],
    name: json["name"],
    categoryId: json["category_id"],
    price: json["price"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    type: json["type"],
    discount: json["discount"],
    description: json["description"],
    addedBy: json["added_by"],
    subcategoryId: json["subcategory_id"],
    workProfileId: json["work_profile_id"],
    city: json["city"],
    mapLink: json["map_link"],
    mobile: json["mobile"],
    productType: json["product_type"],
    duration: json["duration"],
    productImage: json["product_image"],
    tag: json["tag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "display_name": displayName,
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
    "providertype_id": providertypeId,
    "is_featured": isFeatured,
    "time_zone": timeZone,
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
    "type": type,
    "discount": discount,
    "description": description,
    "added_by": addedBy,
    "subcategory_id": subcategoryId,
    "work_profile_id": workProfileId,
    "city": city,
    "map_link": mapLink,
    "mobile": mobile,
    "product_type": productType,
    "duration": duration,
    "product_image": productImage,
    "tag": tag,
  };
}
