// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';

class DocumentUploadModel {
  String? document_id;
  File? provider_document;
  String? is_verified;
  DocumentUploadModel(
      {this.document_id, this.provider_document, this.is_verified});

  DocumentUploadModel.fromJson(Map<String, dynamic> json) {
    document_id = json['document_id'];
    provider_document = json['document'];
    is_verified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = document_id;
    data['document'] = provider_document;
    data['is_verified'] = is_verified;
    return data;
  }
}
