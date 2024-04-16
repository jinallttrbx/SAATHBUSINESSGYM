// ignore_for_file: file_names

class GetUserReviews {
  bool? status;
  String? message;
  List<GetUserReviewsData>? data;

  GetUserReviews({this.status, this.message, this.data});

  GetUserReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUserReviewsData>[];
      json['data'].forEach((v) {
        data!.add(GetUserReviewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserReviewsData {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? displayName;
  int? rating;
  String? review;

  GetUserReviewsData(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.displayName,
      this.rating,
      this.review});

  GetUserReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}

class ReviewListByProviderModel {
  List<ReviewData>? data;
  bool? status;
  String? message;

  ReviewListByProviderModel({this.data, this.status, this.message});

  ReviewListByProviderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReviewData>[];
      json['data'].forEach((v) {
        data!.add(new ReviewData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ReviewData {
  int? id;
  int? bookingId;
  int? serviceId;
  int? customerId;
  dynamic rating;
  String? review;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? serviceName;

  ReviewData(
      {this.id,
      this.bookingId,
      this.serviceId,
      this.customerId,
      this.rating,
      this.review,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.customerName,
      this.serviceName});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    customerId = json['customer_id'];
    rating = json['rating_star'];
    review = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['customer_id'] = this.customerId;
    data['rating_star'] = this.rating;
    data['description'] = this.review;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_name'] = this.customerName;
    data['service_name'] = this.serviceName;
    return data;
  }
}
