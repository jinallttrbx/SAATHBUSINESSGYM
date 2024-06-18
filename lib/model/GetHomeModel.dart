// To parse this JSON data, do
//
//     final getHomeModel = getHomeModelFromJson(jsonString);

import 'dart:convert';

GetHomeModel getHomeModelFromJson(String str) => GetHomeModel.fromJson(json.decode(str));

String getHomeModelToJson(GetHomeModel data) => json.encode(data.toJson());

class GetHomeModel {
  bool status;
  String message;
  dynamic profilecompleted;
  dynamic avrageRating;
  dynamic overallMfiScore;
  dynamic serviceCount;
  dynamic productCount;
  dynamic loanCount;
  List<ProductListElement> serviceList;
  List<ProductListElement> productList;
  List<DocumentList> documentList;

  GetHomeModel({
    required this.status,
    required this.message,
    required this.profilecompleted,
    required this.avrageRating,
    required this.overallMfiScore,
    required this.serviceCount,
    required this.productCount,
    required this.loanCount,
    required this.serviceList,
    required this.productList,
    required this.documentList,
  });

  factory GetHomeModel.fromJson(Map<String, dynamic> json) => GetHomeModel(
    status: json["status"],
    message: json["message"],
    profilecompleted: json["profilecompleted"],
    avrageRating: json["avrage_rating"],
    overallMfiScore: json["overall_mfi_score"],
    serviceCount: json["service_count"],
    productCount: json["product_count"],
    loanCount: json["loan_count"],
    serviceList: List<ProductListElement>.from(json["service_list"].map((x) => ProductListElement.fromJson(x))),
    productList: List<ProductListElement>.from(json["product_list"].map((x) => ProductListElement.fromJson(x))),
    documentList: List<DocumentList>.from(json["document_list"].map((x) => DocumentList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "profilecompleted": profilecompleted,
    "avrage_rating": avrageRating,
    "overall_mfi_score": overallMfiScore,
    "service_count": serviceCount,
    "product_count": productCount,
    "loan_count": loanCount,
    "service_list": List<dynamic>.from(serviceList.map((x) => x.toJson())),
    "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
    "document_list": List<dynamic>.from(documentList.map((x) => x.toJson())),
  };
}

class DocumentList {
  dynamic id;
  dynamic categoryId;
  dynamic categoryName;
  dynamic name;
  dynamic supportNumber;
  dynamic usefullLink;
  dynamic status;
  dynamic isRequired;
  dynamic isSubmitted;
  dynamic isVerified;
  dynamic providerDocument;
  dynamic uploadedDocument;
  dynamic providerExtension;

  DocumentList({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.supportNumber,
    required this.usefullLink,
    required this.status,
    required this.isRequired,
    required this.isSubmitted,
    required this.isVerified,
    required this.providerDocument,
    required this.uploadedDocument,
    required this.providerExtension,
  });

  factory DocumentList.fromJson(Map<String, dynamic> json) => DocumentList(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    name: json["name"],
    supportNumber: json["support_number"],
    usefullLink: json["usefull_link"],
    status: json["status"],
    isRequired: json["is_required"],
    isSubmitted: json["is_submitted"],
    isVerified: json["is_verified"],
    providerDocument: json["provider_document"],
    uploadedDocument: json["uploaded_document"],
    providerExtension: json["provider_extension"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "name": name,
    "support_number": supportNumber,
    "usefull_link": usefullLink,
    "status": status,
    "is_required": isRequired,
    "is_submitted": isSubmitted,
    "is_verified": isVerified,
    "provider_document": providerDocument,
    "uploaded_document": uploadedDocument,
    "provider_extension": providerExtension,
  };
}



class ProductListElement {
  dynamic id;
  dynamic name;
  dynamic categoryId;
  dynamic providerId;
  dynamic price;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic type;
  dynamic discount;
  dynamic status;
  dynamic description;
  dynamic isFeatured;
  dynamic addedBy;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic subcategoryId;
  dynamic occupationId;
  dynamic workProfileId;
  dynamic city;
  dynamic address;
  dynamic mapLink;
  dynamic mobile;
  dynamic email;
  dynamic productType;
  dynamic totalRating;
  dynamic averageRating;
  dynamic duration;
  dynamic contactNumber;
  dynamic distance;
  dynamic username;
  dynamic profileImage;
  dynamic tag;
  dynamic gstNumber;
  dynamic fassaiNumber;
  dynamic serviceType;

  ProductListElement({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.providerId,
    required this.price,
    required this.minPrice,
    required this.maxPrice,
    required this.type,
    required this.discount,
    required this.status,
    required this.description,
    required this.isFeatured,
    required this.addedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategoryId,
    required this.occupationId,
    required this.workProfileId,
    required this.city,
    required this.address,
    required this.mapLink,
    required this.mobile,
    required this.email,
    this.productType,
    required this.totalRating,
    required this.averageRating,
    required this.duration,
    required this.contactNumber,
    required this.distance,
    required this.username,
    required this.profileImage,
    required this.tag,
    required this.gstNumber,
    required this.fassaiNumber,
    this.serviceType,
  });

  factory ProductListElement.fromJson(Map<String, dynamic> json) => ProductListElement(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    providerId: json["provider_id"],
    price: json["price"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    type: json["type"],
    discount: json["discount"],
    status: json["status"],
    description: json["description"],
    isFeatured: json["is_featured"],
    addedBy: json["added_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subcategoryId: json["subcategory_id"],
    occupationId: json["occupation_id"],
    workProfileId: json["work_profile_id"],
    city: json["city"],
    address: json["address"],
    mapLink: json["map_link"],
    mobile: json["mobile"],
    email: json["email"],
    productType: json["product_type"],
    totalRating: json["total_rating"],
    averageRating: json["average_rating"]?.toDouble(),
    duration: json["duration"],
    contactNumber: json["contact_number"],
    distance: json["distance"]?.toDouble(),
    username: json["username"],
    profileImage: json["profile_image"],
    tag: json["tag"],
    gstNumber: json["gst_number"],
    fassaiNumber: json["fassai_number"],
    serviceType: json["service_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "provider_id": providerId,
    "price": price,
    "min_price": minPrice,
    "max_price": maxPrice,
    "type": type,
    "discount": discount,
    "status": status,
    "description": description,
    "is_featured": isFeatured,
    "added_by": addedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "subcategory_id": subcategoryId,
    "occupation_id": occupationId,
    "work_profile_id": workProfileId,
    "city": city,
    "address": address,
    "map_link": mapLink,
    "mobile": mobile,
    "email": email,
    "product_type": productType,
    "total_rating": totalRating,
    "average_rating": averageRating,
    "duration": duration,
    "contact_number": contactNumber,
    "distance": distance,
    "username": username,
    "profile_image": profileImage,
    "tag": tag,
    "gst_number": gstNumber,
    "fassai_number": fassaiNumber,
    "service_type": serviceType,
  };
}


