// To parse this JSON data, do
//
//     final loanListModel = loanListModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final loanListModel = loanListModelFromJson(jsonString);

import 'dart:convert';

LoanListModel loanListModelFromJson(String str) => LoanListModel.fromJson(json.decode(str));

String loanListModelToJson(LoanListModel data) => json.encode(data.toJson());

class LoanListModel {
  bool status;
  String loanapply;
  String messsage;
  List<LoanListModelData> data;

  LoanListModel({
    required this.status,
    required this.loanapply,
    required this.messsage,
    required this.data,
  });

  factory LoanListModel.fromJson(Map<String, dynamic> json) => LoanListModel(
    status: json["status"],
    loanapply: json["loanapply "],
    messsage: json["messsage"],
    data: List<LoanListModelData>.from(json["data"].map((x) => LoanListModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "loanapply ": loanapply,
    "messsage": messsage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LoanListModelData {
  int id;
  int approved;
  int mfiId;
  String purpose;
  String mfiName;
  int loanAmount;
  DateTime applyDate;
  DateTime approvedDate;
  int recievedAmount;
  String tenure;
  int intrestRate;
  int installmentAmount;
  String loanType;
  int remainingAmount;
  int scoreCount;

  LoanListModelData({
    required this.id,
    required this.approved,
    required this.mfiId,
    required this.purpose,
    required this.mfiName,
    required this.loanAmount,
    required this.applyDate,
    required this.approvedDate,
    required this.recievedAmount,
    required this.tenure,
    required this.intrestRate,
    required this.installmentAmount,
    required this.loanType,
    required this.remainingAmount,
    required this.scoreCount,
  });

  factory LoanListModelData.fromJson(Map<String, dynamic> json) => LoanListModelData(
    id: json["id"],
    approved: json["approved"],
    mfiId: json["mfi_id"],
    purpose: json["purpose"],
    mfiName: json["mfi_name"],
    loanAmount: json["loan_amount"],
    applyDate: DateTime.parse(json["apply_date"]),
    approvedDate: DateTime.parse(json["approved_date"]),
    recievedAmount: json["recieved_amount"],
    tenure: json["tenure"],
    intrestRate: json["intrest_rate"],
    installmentAmount: json["installment_amount"],
    loanType: json["loan_type"],
    remainingAmount: json["remaining_amount"],
    scoreCount: json["score_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "approved": approved,
    "mfi_id": mfiId,
    "purpose": purpose,
    "mfi_name": mfiName,
    "loan_amount": loanAmount,
    "apply_date": "${applyDate.year.toString().padLeft(4, '0')}-${applyDate.month.toString().padLeft(2, '0')}-${applyDate.day.toString().padLeft(2, '0')}",
    "approved_date": "${approvedDate.year.toString().padLeft(4, '0')}-${approvedDate.month.toString().padLeft(2, '0')}-${approvedDate.day.toString().padLeft(2, '0')}",
    "recieved_amount": recievedAmount,
    "tenure": tenure,
    "intrest_rate": intrestRate,
    "installment_amount": installmentAmount,
    "loan_type": loanType,
    "remaining_amount": remainingAmount,
    "score_count": scoreCount,
  };
}




// To parse this JSON data, do
//
//     final appliedLoanListModel = appliedLoanListModelFromJson(jsonString);



AppliedLoanListModel appliedLoanListModelFromJson(String str) => AppliedLoanListModel.fromJson(json.decode(str));

String appliedLoanListModelToJson(AppliedLoanListModel data) => json.encode(data.toJson());

class AppliedLoanListModel {
  bool status;
  String loanapply;
  String messsage;
  List<AppliedLoanListModeldata> data;

  AppliedLoanListModel({
    required this.status,
    required this.loanapply,
    required this.messsage,
    required this.data,
  });

  factory AppliedLoanListModel.fromJson(Map<String, dynamic> json) => AppliedLoanListModel(
    status: json["status"],
    loanapply: json["loanapply "],
    messsage: json["messsage"],
    data: List<AppliedLoanListModeldata>.from(json["data"].map((x) => AppliedLoanListModeldata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "loanapply ": loanapply,
    "messsage": messsage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AppliedLoanListModeldata {
  int id;
  int approved;
  int mfiId;
  String purpose;
  dynamic mfiName;
  int loanAmount;
  DateTime applyDate;
  dynamic approvedDate;
  int recievedAmount;
  String tenure;
  dynamic intrestRate;
  dynamic installmentAmount;
  String loanType;
  int remainingAmount;
  int scoreCount;

  AppliedLoanListModeldata({
    required this.id,
    required this.approved,
    required this.mfiId,
    required this.purpose,
    required this.mfiName,
    required this.loanAmount,
    required this.applyDate,
    required this.approvedDate,
    required this.recievedAmount,
    required this.tenure,
    required this.intrestRate,
    required this.installmentAmount,
    required this.loanType,
    required this.remainingAmount,
    required this.scoreCount,
  });

  factory AppliedLoanListModeldata.fromJson(Map<String, dynamic> json) => AppliedLoanListModeldata(
    id: json["id"],
    approved: json["approved"],
    mfiId: json["mfi_id"],
    purpose: json["purpose"],
    mfiName: json["mfi_name"],
    loanAmount: json["loan_amount"],
    applyDate: DateTime.parse(json["apply_date"]),
    approvedDate: json["approved_date"],
    recievedAmount: json["recieved_amount"],
    tenure: json["tenure"],
    intrestRate: json["intrest_rate"],
    installmentAmount: json["installment_amount"],
    loanType: json["loan_type"],
    remainingAmount: json["remaining_amount"],
    scoreCount: json["score_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "approved": approved,
    "mfi_id": mfiId,
    "purpose": purpose,
    "mfi_name": mfiName,
    "loan_amount": loanAmount,
    "apply_date": "${applyDate.year.toString().padLeft(4, '0')}-${applyDate.month.toString().padLeft(2, '0')}-${applyDate.day.toString().padLeft(2, '0')}",
    "approved_date": approvedDate,
    "recieved_amount": recievedAmount,
    "tenure": tenure,
    "intrest_rate": intrestRate,
    "installment_amount": installmentAmount,
    "loan_type": loanType,
    "remaining_amount": remainingAmount,
    "score_count": scoreCount,
  };
}


