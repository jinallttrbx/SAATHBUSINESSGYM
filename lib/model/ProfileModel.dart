class ProfileModel {
  bool? status;
  String? message;
  ProfileModelData? data;
  List<BusinessPhotos>? businessPhotos;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
    json['data'] != null ? ProfileModelData.fromJson(json['data']) : null;
    if (json['business_photos'] != null) {
      businessPhotos = <BusinessPhotos>[];
      json['business_photos'].forEach((v) {
        businessPhotos!.add(BusinessPhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (businessPhotos != null) {
      data['business_photos'] = businessPhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileModelData {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? companyName;
  String? userType;
  String? contactNumber;
  String? gender;
  int? countryId;
  int? stateId;
  int? cityId;
  int? providerId;
  String? address;
  String? playerId;
  int? status;
  String? displayName;
  int? providertypeId;
  int? isFeatured;
  String? timeZone;
  String? lastNotificationSeen;
  String? emailVerifiedAt;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  String? pmType;
  String? pmLastFour;
  String? trialEndsAt;
  String? loginType;
  int? serviceAddressId;
  String? uid;
  int? handymantypeId;
  int? isSubscribe;
  String? socialImage;
  int? isAvailable;
  String? designation;
  String? lastOnlineTime;
  String? modeOfBusiness;
  String? businessTiming;
  String? perKmTravelCharges;
  String? gstNumber;
  String? licenseNumber;
  String? fassaiNumber;
  String? profileImage;
  String? referral_code;
  int? bg_id;
  var rating_star;
  int? reviews;

  ProfileModelData(
      {this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.companyName,
        this.userType,
        this.contactNumber,
        this.gender,
        this.countryId,
        this.stateId,
        this.cityId,
        this.providerId,
        this.address,
        this.playerId,
        this.status,
        this.displayName,
        this.providertypeId,
        this.isFeatured,
        this.timeZone,
        this.lastNotificationSeen,
        this.emailVerifiedAt,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.stripeId,
        this.pmType,
        this.pmLastFour,
        this.trialEndsAt,
        this.loginType,
        this.serviceAddressId,
        this.uid,
        this.handymantypeId,
        this.isSubscribe,
        this.socialImage,
        this.isAvailable,
        this.designation,
        this.lastOnlineTime,
        this.modeOfBusiness,
        this.businessTiming,
        this.perKmTravelCharges,
        this.gstNumber,
        this.licenseNumber,
        this.fassaiNumber,
        this.referral_code,
        this.profileImage,
        this.bg_id,
        this.rating_star,
        this.reviews});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    userType = json['user_type'];
    contactNumber = json['contact_number'];
    gender=json['gender'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    providerId = json['provider_id'];
    address = json['address'];
    playerId = json['player_id'];
    status = json['status'];
    displayName = json['display_name'];
    providertypeId = json['providertype_id'];
    isFeatured = json['is_featured'];
    timeZone = json['time_zone'];
    lastNotificationSeen = json['last_notification_seen'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    loginType = json['login_type'];
    serviceAddressId = json['service_address_id'];
    uid = json['uid'];
    handymantypeId = json['handymantype_id'];
    isSubscribe = json['is_subscribe'];
    socialImage = json['social_image'];
    isAvailable = json['is_available'];
    designation = json['designation'];
    lastOnlineTime = json['last_online_time'];
    modeOfBusiness = json['mode_of_business'];
    businessTiming = json['business_timing'];
    perKmTravelCharges = json['per_km_travel_charges'];
    gstNumber = json['gst_number'];
    licenseNumber = json['license_number'];
    fassaiNumber = json['fassai_number'];
    profileImage = json['profile_image'];
    referral_code = json['referral_code'];
    bg_id = json['bg_id'];
    rating_star = json['rating_star'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['company_name'] = companyName;
    data['user_type'] = userType;
    data['contact_number'] = contactNumber;
    data['gender']=gender;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['provider_id'] = providerId;
    data['address'] = address;
    data['player_id'] = playerId;
    data['status'] = status;
    data['display_name'] = displayName;
    data['providertype_id'] = providertypeId;
    data['is_featured'] = isFeatured;
    data['time_zone'] = timeZone;
    data['last_notification_seen'] = lastNotificationSeen;
    data['email_verified_at'] = emailVerifiedAt;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['stripe_id'] = stripeId;
    data['pm_type'] = pmType;
    data['pm_last_four'] = pmLastFour;
    data['trial_ends_at'] = trialEndsAt;
    data['login_type'] = loginType;
    data['service_address_id'] = serviceAddressId;
    data['uid'] = uid;
    data['handymantype_id'] = handymantypeId;
    data['is_subscribe'] = isSubscribe;
    data['social_image'] = socialImage;
    data['is_available'] = isAvailable;
    data['designation'] = designation;
    data['last_online_time'] = lastOnlineTime;
    data['mode_of_business'] = modeOfBusiness;
    data['business_timing'] = businessTiming;
    data['per_km_travel_charges'] = perKmTravelCharges;
    data['gst_number'] = gstNumber;
    data['license_number'] = licenseNumber;
    data['fassai_number'] = fassaiNumber;
    data['profile_image'] = profileImage;
    data['referral_code'] = referral_code;
    data['bg_id'] = bg_id;
    data['rating_star'] = rating_star;
    data['reviews'] = reviews;
    return data;
  }
}

class BusinessPhotos {
  int? id;
  String? profileImage;

  BusinessPhotos({this.id, this.profileImage});

  BusinessPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_image'] = profileImage;
    return data;
  }
}
