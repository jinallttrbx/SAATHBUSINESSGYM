// ignore_for_file: file_names, unnecessary_question_mark, prefer_void_to_null

class LoginModelData {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? userType;
  String? contactNumber;
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
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? stripeId;
  Null? pmType;
  Null? pmLastFour;
  Null? trialEndsAt;
  String? loginType;
  Null? serviceAddressId;
  String? uid;
  int? handymantypeId;
  int? isSubscribe;
  String? socialImage;
  int? isAvailable;
  String? designation;
  Null? lastOnlineTime;
  List<String>? userRole;
  String? apiToken;
  String? profileImage;
  int? isVerifyProvider;

  LoginModelData(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.userType,
      this.contactNumber,
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
      this.userRole,
      this.apiToken,
      this.profileImage,
      this.isVerifyProvider});

  LoginModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    userType = json['user_type'];
    contactNumber = json['contact_number'];
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
    userRole = json['user_role'].cast<String>();
    apiToken = json['api_token'];
    profileImage = json['profile_image'];
    isVerifyProvider = json['is_verify_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['user_type'] = userType;
    data['contact_number'] = contactNumber;
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
    data['user_role'] = userRole;
    data['api_token'] = apiToken;
    data['profile_image'] = profileImage;
    data['is_verify_provider'] = isVerifyProvider;
    return data;
  }
}



