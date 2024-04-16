// ignore_for_file: file_names

class QuicktransectionreportModel {
  bool? status;
  String? message;
  int? totalDebit;
  int? totalCredit;
  int? totalBalance;
  List<QuicktransectionreportModelData>? data;
  String? downloadLink;

  QuicktransectionreportModel(
      {this.status,
      this.message,
      this.totalDebit,
      this.totalCredit,
      this.totalBalance,
      this.data,
      this.downloadLink});

  QuicktransectionreportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
    totalBalance = json['total_balance'];
    if (json['data'] != null) {
      data = <QuicktransectionreportModelData>[];
      json['data'].forEach((v) {
        data!.add(QuicktransectionreportModelData.fromJson(v));
      });
    }
    downloadLink = json['download_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    data['total_balance'] = totalBalance;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['download_link'] = downloadLink;
    return data;
  }
}

class QuicktransectionreportModelData {
  String? date;
  List<SubData>? subData;

  QuicktransectionreportModelData({this.date, this.subData});

  QuicktransectionreportModelData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['sub_data'] != null) {
      subData = <SubData>[];
      json['sub_data'].forEach((v) {
        subData!.add(SubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (subData != null) {
      data['sub_data'] = subData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "date : $date , Subdata $subData";
  }
}

class SubData {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  String? transName;
  String? transMobile;
  String? transDate;
  int? creditAmount;
  int? debitAmount;
  String? paymentMode;
  String? description;
  String? flag;

  SubData(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.transName,
      this.transMobile,
      this.transDate,
      this.creditAmount,
      this.debitAmount,
      this.paymentMode,
      this.description,
      this.flag});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    userId = json['user_id'];
    transName = json['trans_name'];
    transMobile = json['trans_mobile'];
    transDate = json['trans_date'];
    creditAmount = json['credit_amount'];
    debitAmount = json['debit_amount'];
    paymentMode = json['payment_mode'];
    description = json['description'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['user_id'] = userId;
    data['trans_name'] = transName;
    data['trans_mobile'] = transMobile;
    data['trans_date'] = transDate;
    data['credit_amount'] = creditAmount;
    data['debit_amount'] = debitAmount;
    data['payment_mode'] = paymentMode;
    data['description'] = description;
    data['flag'] = flag;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Amount = $creditAmount $debitAmount , des = $description , client name=$transName ,  Mobile = $transMobile , type $paymentMode ";
  }
}
