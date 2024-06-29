// To parse this JSON data, do
//
//     final allDocumentList = allDocumentListFromJson(jsonString);

import 'dart:convert';

AllDocumentList allDocumentListFromJson(String str) => AllDocumentList.fromJson(json.decode(str));

String allDocumentListToJson(AllDocumentList data) => json.encode(data.toJson());

class AllDocumentList {
  String message;
  bool status;
  List<AllDocumentListdata> data;

  AllDocumentList({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AllDocumentList.fromJson(Map<String, dynamic> json) => AllDocumentList(
    message: json["message"],
    status: json["status"],
    data: List<AllDocumentListdata>.from(json["data"].map((x) => AllDocumentListdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllDocumentListdata {
  dynamic id;
  dynamic catName;
  List<Document> documents;
  dynamic image;

  AllDocumentListdata({
    required this.id,
    required this.catName,
    required this.documents,
    required this.image,
  });

  factory AllDocumentListdata.fromJson(Map<String, dynamic> json) => AllDocumentListdata(
    id: json["id"],
    catName: json["cat_name"],
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_name": catName,
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    "image": image,
  };
}

class Document {
  dynamic id;
  dynamic categoryId;
  dynamic name;
  dynamic supportNumber;
  dynamic usefullLink;
  dynamic status;
  dynamic isRequired;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic documentImage;
  dynamic ifUpload;
  dynamic providerDocument;

  Document({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.supportNumber,
    required this.usefullLink,
    required this.status,
    required this.isRequired,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.documentImage,
    required this.ifUpload,
    required this.providerDocument,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    supportNumber: json["support_number"],
    usefullLink: json["usefull_link"],
    status: json["status"],
    isRequired: json["is_required"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    documentImage: json["document_image"],
    ifUpload: json["if_upload"],
    providerDocument: json["provider_document"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "support_number": supportNumber,
    "usefull_link": usefullLink,
    "status": status,
    "is_required": isRequired,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "document_image": documentImage,
    "if_upload": ifUpload,
    "provider_document": providerDocument,
  };
}
