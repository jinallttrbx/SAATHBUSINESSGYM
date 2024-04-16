// To parse this JSON data, do
//
//     final productSellerList = productSellerListFromJson(jsonString);

import 'dart:convert';

ProductSellerList productSellerListFromJson(String str) => ProductSellerList.fromJson(json.decode(str));

String productSellerListToJson(ProductSellerList data) => json.encode(data.toJson());

class ProductSellerList {
  List<ProductSellerdata> data;

  ProductSellerList({
    required this.data,
  });

  factory ProductSellerList.fromJson(Map<String, dynamic> json) => ProductSellerList(
    data: List<ProductSellerdata>.from(json["data"].map((x) => ProductSellerdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductSellerdata {
  int id;
  int providerId;
  Type type;
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
  OpenAt openAt;
  CloseAt closeAt;
  String profileImage;
  String productImage;
  int workingHour;

  ProductSellerdata({
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
    required this.productImage,
    required this.workingHour,
  });

  factory ProductSellerdata.fromJson(Map<String, dynamic> json) => ProductSellerdata(
    id: json["id"],
    providerId: json["provider_id"],
    type: typeValues.map[json["type"]]!,
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
    openAt: openAtValues.map[json["open_at"]]!,
    closeAt: closeAtValues.map[json["close_at"]]!,
    profileImage: json["profile_image"],
    productImage: json["product_image"],
    workingHour: json["working_hour"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "type": typeValues.reverse[type],
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
    "open_at": openAtValues.reverse[openAt],
    "close_at": closeAtValues.reverse[closeAt],
    "profile_image": profileImage,
    "product_image": productImage,
    "working_hour": workingHour,
  };
}

enum CategoryName {
  MISCELLANEOUS,
  PERSONAL_PRODUCT
}

final categoryNameValues = EnumValues({
  "Miscellaneous": CategoryName.MISCELLANEOUS,
  "Personal Product": CategoryName.PERSONAL_PRODUCT
});

enum CloseAt {
  THE_1000_PM,
  THE_1100_PM,
  THE_200_PM,
  THE_900_PM
}

final closeAtValues = EnumValues({
  "10:00 PM": CloseAt.THE_1000_PM,
  "11:00 PM": CloseAt.THE_1100_PM,
  "2:00 PM": CloseAt.THE_200_PM,
  "9:00 PM": CloseAt.THE_900_PM
});

enum OpenAt {
  THE_1000_AM,
  THE_800_AM,
  THE_900_AM
}

final openAtValues = EnumValues({
  "10:00 AM": OpenAt.THE_1000_AM,
  "8:00 AM": OpenAt.THE_800_AM,
  "9:00 AM": OpenAt.THE_900_AM
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
