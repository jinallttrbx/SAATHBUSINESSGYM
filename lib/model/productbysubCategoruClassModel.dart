class ProductSubCategoryModel {
  List<Data>? data;
  bool? status;
  String? message;

  ProductSubCategoryModel({this.data, this.status, this.message});

  ProductSubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  int? categoryId;
  int? providerId;
  int? price;
  String? type;
  String? duration;
  int? discount;
  int? status;
  String? description;
  int? isFeatured;
  int? addedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? subcategoryId;
  var occupationId;
  var workProfileId;
  var city;
  var address;
  var mapLink;
  var mobile;
  var email;

  Data(
      {this.id,
      this.name,
      this.categoryId,
      this.providerId,
      this.price,
      this.type,
      this.duration,
      this.discount,
      this.status,
      this.description,
      this.isFeatured,
      this.addedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.subcategoryId,
      this.occupationId,
      this.workProfileId,
      this.city,
      this.address,
      this.mapLink,
      this.mobile,
      this.email});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    providerId = json['provider_id'];
    price = json['price'];
    type = json['type'];
    duration = json['duration'];
    discount = json['discount'];
    status = json['status'];
    description = json['description'];
    isFeatured = json['is_featured'];
    addedBy = json['added_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subcategoryId = json['subcategory_id'];
    occupationId = json['occupation_id'];
    workProfileId = json['work_profile_id'];
    city = json['city'];
    address = json['address'];
    mapLink = json['map_link'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['provider_id'] = this.providerId;
    data['price'] = this.price;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['description'] = this.description;
    data['is_featured'] = this.isFeatured;
    data['added_by'] = this.addedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subcategory_id'] = this.subcategoryId;
    data['occupation_id'] = this.occupationId;
    data['work_profile_id'] = this.workProfileId;
    data['city'] = this.city;
    data['address'] = this.address;
    data['map_link'] = this.mapLink;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
