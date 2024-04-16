// To parse this JSON data, do
//
//     final getClientModel = getClientModelFromJson(jsonString);

import 'dart:convert';

GetClientModel getClientModelFromJson(String str) => GetClientModel.fromJson(json.decode(str));

String getClientModelToJson(GetClientModel data) => json.encode(data.toJson());

class GetClientModel {
  bool status;
  String message;
  List<GetClientModeldata> data;

  GetClientModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetClientModel.fromJson(Map<String, dynamic> json) => GetClientModel(
    status: json["status"],
    message: json["message"],
    data: List<GetClientModeldata>.from(json["data"].map((x) => GetClientModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetClientModeldata {
  int id;
  int userId;
  int providerId;
  int typeId;
  String type;
  DateTime date;
  DateTime updatedAt;
  String receiverName;
  dynamic receiverAddress;
  String? receiverEmail;
  String receiverContactNumber;
  dynamic receiverGstNumber;
  dynamic receiverFassaiNumber;
  String receiverOpenAt;
  String receiverCloseAt;
  String senderName;
  dynamic senderAddress;
  dynamic senderEmail;
  String senderContactNumber;
  dynamic senderGstNumber;
  dynamic senderFassaiNumber;
  String senderOpenAt;
  String senderCloseAt;
  String name;
  dynamic callLogRatingsId;
  int rating;
  dynamic review;
  String image;
  String tag;
  String senderTag;
  String senderImage;
  String receiverTag;
  String recieverImage;
  int myBooking;

  GetClientModeldata({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.typeId,
    required this.type,
    required this.date,
    required this.updatedAt,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverEmail,
    required this.receiverContactNumber,
    required this.receiverGstNumber,
    required this.receiverFassaiNumber,
    required this.receiverOpenAt,
    required this.receiverCloseAt,
    required this.senderName,
    required this.senderAddress,
    required this.senderEmail,
    required this.senderContactNumber,
    required this.senderGstNumber,
    required this.senderFassaiNumber,
    required this.senderOpenAt,
    required this.senderCloseAt,
    required this.name,
    required this.callLogRatingsId,
    required this.rating,
    required this.review,
    required this.image,
    required this.tag,
    required this.senderTag,
    required this.senderImage,
    required this.receiverTag,
    required this.recieverImage,
    required this.myBooking,
  });

  factory GetClientModeldata.fromJson(Map<String, dynamic> json) => GetClientModeldata(
    id: json["id"],
    userId: json["user_id"],
    providerId: json["provider_id"],
    typeId: json["type_id"],
    type: json["type"],
    date: DateTime.parse(json["date"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    receiverName: json["receiver_name"],
    receiverAddress: json["receiver_address"],
    receiverEmail: json["receiver_email"],
    receiverContactNumber: json["receiver_contact_number"],
    receiverGstNumber: json["receiver_gst_number"],
    receiverFassaiNumber: json["receiver_fassai_number"],
    receiverOpenAt: json["receiver_open_at"],
    receiverCloseAt: json["receiver_close_at"],
    senderName: json["sender_name"],
    senderAddress: json["sender_address"],
    senderEmail: json["sender_email"],
    senderContactNumber: json["sender_contact_number"],
    senderGstNumber: json["sender_gst_number"],
    senderFassaiNumber: json["sender_fassai_number"],
    senderOpenAt: json["sender_open_at"],
    senderCloseAt: json["sender_close_at"],
    name: json["name"],
    callLogRatingsId: json["call_log_ratings_id"],
    rating: json["rating"],
    review: json["review"],
    image: json["image"],
    tag: json["tag"],
    senderTag: json["sender_tag"],
    senderImage: json["sender_image"],
    receiverTag: json["receiver_tag"],
    recieverImage: json["reciever_image"],
    myBooking: json["my_booking"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "provider_id": providerId,
    "type_id": typeId,
    "type": type,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "updated_at": updatedAt.toIso8601String(),
    "receiver_name": receiverName,
    "receiver_address": receiverAddress,
    "receiver_email": receiverEmail,
    "receiver_contact_number": receiverContactNumber,
    "receiver_gst_number": receiverGstNumber,
    "receiver_fassai_number": receiverFassaiNumber,
    "receiver_open_at": receiverOpenAt,
    "receiver_close_at": receiverCloseAt,
    "sender_name": senderName,
    "sender_address": senderAddress,
    "sender_email": senderEmail,
    "sender_contact_number": senderContactNumber,
    "sender_gst_number": senderGstNumber,
    "sender_fassai_number": senderFassaiNumber,
    "sender_open_at": senderOpenAt,
    "sender_close_at": senderCloseAt,
    "name": name,
    "call_log_ratings_id": callLogRatingsId,
    "rating": rating,
    "review": review,
    "image": image,
    "tag": tag,
    "sender_tag": senderTag,
    "sender_image": senderImage,
    "receiver_tag": receiverTag,
    "reciever_image": recieverImage,
    "my_booking": myBooking,
  };
}
