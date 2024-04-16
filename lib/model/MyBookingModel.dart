

class MyBookingModel {
  bool? status;
  String? message;
  List<MyBookingModelData>? data;

  MyBookingModel({this.status, this.message, this.data});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyBookingModelData>[];
      json['data'].forEach((v) {
        data!.add(MyBookingModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyBookingModelData {
  var id;
  var userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  var providerId;
  var serviceId;
  String? date;
  String? serviceName;
  String? supplierName;
  String? ratingStar;
  String? description;
  String? serviceImage;
  String? tag;
  var supplierId;
  var productId;

  MyBookingModelData(
      {this.id,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.providerId,
      this.serviceId,
      this.date,
      this.serviceName,
      this.supplierName,
      this.ratingStar,
      this.description,
      this.serviceImage,
      this.tag,
      this.supplierId,
      this.productId});

  MyBookingModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    providerId = json['provider_id'];
    serviceId = json['service_id'];
    date = json['date'];
    serviceName = json['service_name'];
    supplierName = json['supplier_name'];
    ratingStar = json['rating_star'];
    description = json['description'];
    serviceImage = json['tag'] == 'provider service'
        ? json['provider_service_image']
        : json['tag'] == 'provider product'
            ? json['provider_product_image']
            : json['tag'] == 'supplier service'
                ? json['supplier_service_image']
                : json['supplier_product_image'];
    tag = json['tag'];
    supplierId = json['supplier_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['provider_id'] = this.providerId;
    data['service_id'] = this.serviceId;
    data['date'] = this.date;
    data['service_name'] = this.serviceName;
    data['supplier_name'] = this.supplierName;
    data['rating_star'] = this.ratingStar;
    data['description'] = this.description;
    data['provider_service_image'] = this.serviceImage;
    data['tag'] = this.tag;
    data['supplier_id'] = this.supplierId;
    data['product_id'] = this.productId;
    return data;
  }
}
