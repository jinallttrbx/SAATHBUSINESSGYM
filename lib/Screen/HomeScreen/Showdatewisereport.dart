// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, file_names, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';

import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../Utils/ApiUrl.dart';
import '../../../Utils/BalanceSheetReport.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../Utils/common_route.dart';
import '../../../model/QuicktransectionreportModel.dart';
import '../../../values/Colors.dart';
import '../../../values/assets.dart';
import '../../../values/const_text.dart';

class FinancePageViewDetailReportFilterScreen extends StatefulWidget {
  String Fromdate;
  String todate;
  String username;
  String address;
  String city;

  FinancePageViewDetailReportFilterScreen(this.Fromdate, this.todate,this.username,this.address,this.city,
      {super.key});

  @override
  FinancePageViewDetailReportFilterScreenState createState() =>
      FinancePageViewDetailReportFilterScreenState();
}

class FinancePageViewDetailReportFilterScreenState
    extends State<FinancePageViewDetailReportFilterScreen> {



  String? UserId;
  SharedPreference sharedPreference = SharedPreference();


  Future<List<QuicktransectionreportModelData>?>? alltransactionmodel;
  List<QuicktransectionreportModelData?>? transactionData = [];
  DateTime? pickedDate;
  String? cdate;
  String? totalcashin;
  String? totalcashout;
  String? newbalance;
  String? donloadlink;

  TextEditingController sdateController = TextEditingController();
  TextEditingController edateController = TextEditingController();
  String? sDate = "";
  String? eDate = "";

  List<SubData> subData = [];

  @override
  void initState() {
    super.initState();
    sDate = DateFormat('dd-MM-yyyy').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7));
    eDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    sdateController.text = sDate!;
    edateController.text = eDate!;

    userid();
    setState(() {});
  }

  Future<void> userid() async {
    UserId = await sharedPreference.isUsetId();

    alltransactionmodel =
        MyFinanceList(UserId!, widget.Fromdate, widget.todate);

    cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  Future<List<QuicktransectionreportModelData>?>? MyFinanceList(
      String userId,
      String sDate,
      String eDate,
      ) async {
    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
        'start_date': sDate.toString(),
        'end_date': eDate.toString(),
      };

      print(requestBody);

      print(ApiUrl.transectionreport);
      final response = await http.post(
        Uri.parse(ApiUrl.transectionreport),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);
      print(response.body);

      if (response.statusCode == 200) {
        QuicktransectionreportModel? allViewTransectionModel =
        QuicktransectionreportModel.fromJson(jsonDecode(response.body));
        transactionData = allViewTransectionModel.data;
        newbalance = allViewTransectionModel.totalBalance.toString();
        totalcashin = allViewTransectionModel.totalCredit.toString();
        totalcashout = allViewTransectionModel.totalDebit.toString();
        donloadlink = allViewTransectionModel.downloadLink.toString();
        setState(() {
          totaldata = "";
        });
        for (var i = 0; i < transactionData!.length; i++) {
          //
          for (var j = 0; j < transactionData![i]!.subData!.length; j++) {

            subData.add(transactionData![i]!.subData![j]);
          }
        }
        hideLoader();

        // print("Success");
        setState(() {});

        return allViewTransectionModel.data;
      } else {
        print("Something went wronge");
      }
    } catch (e) {
      print("data==1=$e");
    }
  }

  save(dynamic subdata) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        totaldata +=
         "Amount : ₹ ${subdata.flag != "debit" ? "${subdata.creditAmount}" ' (Credit)' : "-${subdata.debitAmount} (Debit)"} \nClient Name : ${subdata.transName} \nDate : ${subdata.transDate} \nDescription : ${subdata.description} \nPayment Type : ${subdata.paymentMode} \n----------------------------------------    \n";
      });
    });
  }

  String totaldata = "";

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime startDate = DateTime(today.year, today.month - 1, today.day);
    DateTime endDate = DateTime(today.year, today.month + 1, today.day);
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "View Detail Report"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              transactionData!.isEmpty
                  ? const Center(child: Text("Data Not Found"))
                  : ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: transactionData!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionData![index]!.subData!.length,
                      itemBuilder: (BuildContext context, int index1) {
                        var subdata =
                        transactionData![index]!.subData![index1];
                        return GestureDetector(
                          onTap: () async {

                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(17))),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await BalanceSheetReport()
                                        .generateSinglePdf(
                                        context,
                                        'open',
                                        transactionData![index]!.date,
                                        "Rs${subdata.flag != "debit" ? subdata.creditAmount : subdata.debitAmount}/- ${subdata.flag != "debit" ? "(Credit)" : "(Debit)"}",
                                        subdata.description,
                                        subdata.transName,
                                        subdata.transMobile,
                                        subdata.paymentMode)
                                        .then((value) =>
                                        Navigator.pop(context));

                                  },
                                  child:
                                  SvgPicture.asset(AppImages.download),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subdata.transName!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          color: Colors.black),
                                    ),
                                    Text(
                                      subdata.transDate!,
                                      style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xffA6A6A6),
                                      ),
                                    )
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    subdata.flag == "debit"
                                        ? Text(
                                      "-${subdata.debitAmount.toString()}",
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xffF59E20)),
                                    )
                                        : Text(
                                        "+${subdata.creditAmount.toString()}",
                                        style: const TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Color(0xff1B9346))),
                                    Text(
                                      subdata.paymentMode!,
                                      style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xffA6A6A6),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: AppColors.white,
        child: GestureDetector(
          onTap: () async {
            if (transactionData!.isEmpty) {

            } else {
              print(totaldata);
              await BalanceSheetReportDownloadAll().generateSinglePdf(
                context,
                'open',
                widget.Fromdate.toString().split(" ").first,
                widget.todate.toString().split(" ").first,
                newbalance ?? "0",
                totalcashin ?? "0",
                totalcashout ?? "0",
                subData,
                widget.username,widget.address,widget.city
              );
              await Methods1.orderSuccessAlert(context, "Report Download Successfully");


            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            margin:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: boldtext(AppColors.white, 15, " Download "),
            ),
          ),
        ),
      ),
    );
  }
}
