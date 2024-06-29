// ignore_for_file: file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, body_might_complete_normally_nullable, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:businessgym/Screen/HomeScreen/Showdatewisereport.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';

import 'package:businessgym/model/QuicktransectionreportModel.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../Utils/ApiUrl.dart';
import '../../../../../Utils/SharedPreferences.dart';
import '../../../../../Utils/common_route.dart';
import '../../../../../model/AllViewTransectionModel.dart';
import '../../../../../values/Colors.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../../../Utils/BalanceSheetReport.dart';
import '../../../values/assets.dart';

class FinancePageScreen extends StatefulWidget {
  String username;
  String address;
  String city;
   FinancePageScreen(this.username,this.address,this.city);

  @override
  FinancePageScreenState createState() => FinancePageScreenState();
}

class FinancePageScreenState extends State<FinancePageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String? UserId;
  String? type;
  SharedPreference sharedPreference = SharedPreference();
  Future<List<TransectionData>?>? alltransactionmodel;
  Future<List<QuicktransectionreportModelData>?>? alltransactionmodel1;
  List<TransectionData?>? transactionData = [];
  List<QuicktransectionreportModelData?>? transactionData1 = [];
  DateTime? pickedDate;
  String? cdate;
  String? totalcashin;
  String? totalcashout;
  String? newbalance;
  String click = "0";
  String? donloadlink;

  // String dropdownvalue = '  ';
  ClientView? dropdownvalue;
  String typeid = "1";
  List<ClientView> clientdata = [];

  @override
  void initState() {
    super.initState();
    ClientViewList.forEach((element) {
      clientdata.add(ClientView.fromJson(element));
    });
    // final info = await PrintingInfo();

    userid();
    setState(() {
      //   printingInfo=info;
    });
  }

  Future<void> userid() async {
    UserId = await sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    alltransactionmodel = MyFinanceList(UserId!);
    cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  Future<List<QuicktransectionreportModelData>?>? MyFinanceList1(
      String userId, String type) async {

    print("${ApiUrl.quicktransectionreport}${userId},${type}");
    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
        'type': type.toString(),
      };
      print(userId);
      final response = await http.post(
        Uri.parse(ApiUrl.quicktransectionreport),
        body: requestBody,
      );
      print(response.statusCode);
      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        QuicktransectionreportModel? allViewTransectionModel =
        QuicktransectionreportModel.fromJson(jsonDecode(response.body));
        transactionData1 = allViewTransectionModel.data;
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
            save(transactionData![i]!.subData![j]);
          }
        }
        hideLoader();

        setState(() {});

        return allViewTransectionModel.data;
      } else {
        setState(() {
          hideLoader();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<TransectionData>?>? MyFinanceList(String userId) async {
    showGetLoader();
    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
      };

      print("USerId1 == supplier_id" + userId);

      final response = await http.post(
        Uri.parse(ApiUrl.view_transection),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      print("Success finanash datat" + ApiUrl.view_transection);
      print("responsebody" + response.body);
      print("Success finanash datat" + userId);
      if (response.statusCode == 200) {
        AllViewTransectionModel? allViewTransectionModel =
        AllViewTransectionModel.fromJson(jsonDecode(response.body));
        transactionData = allViewTransectionModel.data;
        newbalance = allViewTransectionModel.totalBalance.toString();
        totalcashin = allViewTransectionModel.totalCredit.toString();
        totalcashout = allViewTransectionModel.totalDebit.toString();
        hideLoader();

        print("Success");
        setState(() {});

        return allViewTransectionModel.data;
      } else {
        print("Something went wronge");
      }
    } catch (e) {
      print("data==1=$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print()
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: 'Daily Income & Expenses'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            vertical(20),
            // Align(
            //     alignment: Alignment.centerRight,
            //     child: boldtext(AppColors.black, 14, "Date | $cdate")),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff34A2EA),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(top: 20),
                  height: 150,
                  child: Column(
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "OpenSans",
                            color: AppColors.white),
                      ),
                      Text(
                        "₹ ${newbalance.toString()}",
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.downarrow),
                                  Column(
                                    children: [
                                      const Text("Total Income",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "OpenSans",
                                              color: AppColors.white)),
                                      Text("₹${totalcashin.toString()}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "OpenSans",
                                              color: AppColors.white))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.uparrow),
                                  Column(
                                    children: [
                                      const Text("Total Expenses",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "OpenSans",
                                              color: AppColors.white)),
                                      Text("₹${totalcashout.toString()}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "OpenSans",
                                              color: AppColors.white))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            click = "0";
                          });
                        },
                        child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: click == "0"
                                        ? AppColors.primary
                                        : Colors.transparent),
                                borderRadius: click == "0"
                                    ? const BorderRadius.all(
                                    Radius.circular(17))
                                    : const BorderRadius.all(
                                    Radius.circular(0))),
                            child: Center(
                              child: Text(
                                "History",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: click == "0"
                                        ? Colors.black
                                        : const Color(0xff656565)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 121,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: click == "1"
                                    ? AppColors.primary
                                    : Colors.transparent),
                            borderRadius: click == "1"
                                ? const BorderRadius.all(Radius.circular(17))
                                : const BorderRadius.all(Radius.circular(0))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                hint: const Text("Today"),
                                value: dropdownvalue,
                                underline: const Divider(
                                  thickness: 2,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                elevation: 15,
                                dropdownColor: AppColors.grey,
                                style: const TextStyle(
                                  fontFamily: 'caviarbold',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                icon: const Text(""),
                                items: clientdata
                                    ?.map(
                                      (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name),
                                  ),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  dropdownvalue = value;
                                  setState(() {
                                    typeid = dropdownvalue!.value.toString();
                                    click = "1";
                                  });
                                  print(dropdownvalue!.name);
                                  print(typeid);
                                  if (typeid == "1" ||
                                      typeid == "2" ||
                                      typeid == "3" ||
                                      typeid == "4" ||
                                      typeid == "5") {
                                    print("Selected typeid ${typeid}");
                                    alltransactionmodel1 =
                                        MyFinanceList1(UserId!, typeid);
                                    //  Get.to(FinancePageReportFilterScreen(1));
                                  } else {
                                    print("something went wrong");
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                          onTap: () {
                            _downloadreport(context,widget.username,widget.address,widget.city);
                            // Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.download),
                              const Text("Report")
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),

            ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: transactionData1!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactionData1![index]!.subData!.length,
                    itemBuilder: (BuildContext context, int index1) {
                      var subdata = transactionData1![index]!.subData![index1];
                      return GestureDetector(
                        onTap: () async {
                          Delete(context);
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
                                      subdata.description??"",
                                      subdata.transName,
                                      subdata.transMobile,
                                     "upi")
                                      .then((value) => Navigator.of(context));
                                },
                                child: SvgPicture.asset(AppImages.download),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subdata.transName!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black),
                                  ),
                                  Text(subdata.transDate!,
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffA6A6A6)))
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                  Text(subdata.paymentMode!,
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffA6A6A6)))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            click == "0"
                ? ListView.builder(
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
                          print("objectobjectobjectobjectobject");
                          // ShowData(context,transactionData![index]!.subData![index1]!  );
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
                                      .then(
                                          (value) => Navigator.of(context));
                                },
                                child: SvgPicture.asset(AppImages.download),
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
                                  Text(subdata.transDate!,
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffA6A6A6)))
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                  Text(subdata.paymentMode!,
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffA6A6A6)))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })
                : const SizedBox.shrink(),
          ],
        ),
      ),
      // bottomSheet:
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _addincome(context, "Add Income");
                  },
                  child: Container(
                    width: 180,
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: const Color(0xff1B9346),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      " + Income ",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          fontFamily: "OpenSans"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _addincome(context, "Add Expenses");
                  },
                  child: Container(
                    width: 180,
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: const Color(0xffF59E20),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      " + Expenses ",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          fontFamily: "OpenSans"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _downloadreport(BuildContext context,String username,String address,String city) async {
    TextEditingController fromdate = TextEditingController();
    TextEditingController todate = TextEditingController();
    return showDialog(
        context: context,
        builder: (innerContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 0),
            iconPadding: EdgeInsets.zero,
            content: Container(
              height: 265,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("objectobjectobjectobject");
                          Navigator.pop(context);
                        },
                        child: const Padding(padding: EdgeInsets.only(right: 5),child: Icon(Icons.close_rounded),)
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(subMenu.image),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select date to Download Report",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ],
                  ),
                  const Text("From"),
                  SizedBox(
                    child: TextField(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          String formattedDatesend =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            fromdate.text = formattedDate;
                            // currentdatasend=formattedDatesend;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.25),
                          ),
                          filled: true,
                          border: InputBorder.none,
                          fillColor: AppColors.textfieldcolor,
                          hintText: "From Date"),
                      controller: fromdate,
                      keyboardType: TextInputType.none,
                      autofocus: false,
                    ),
                  ),
                  const Text("To"),
                  SizedBox(
                    child: TextField(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          String formattedDatesend =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            todate.text = formattedDate;
                            // currentdatasend=formattedDatesend;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.25),
                          ),
                          filled: true,
                          border: InputBorder.none,
                          fillColor: AppColors.textfieldcolor,
                          hintText: "To date"),
                      controller: todate,
                      autofocus: false,
                      keyboardType: TextInputType.none,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          if(fromdate.text.isEmpty){

                            ScaffoldMessenger.of(innerContext)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Please Select From Date"),

                            ));
                          }else if(todate.text.isEmpty){
                            ScaffoldMessenger.of(innerContext)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Please Select To Date"),
                            ));
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinancePageViewDetailReportFilterScreen(
                                            fromdate.text, todate.text,username,address,city)));
                          }


                        },
                        child: const Text("Show Data"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String totaldata = "";
  save(dynamic subdata) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        totaldata +=
        // "₹ ${subdata.flag != "debit" ? subdata.creditAmount : "-${subdata.debitAmount}"} \n${subdata.description} \nClient Name  :  ${subdata.transName} \nMobile no    : ${subdata.transMobile} \nPayment Type : ${subdata.paymentMode} \n----------------------------------------    \n";
        "Amount : ₹ ${subdata.flag != "debit" ? subdata.creditAmount + ' (Credit)' : "-${subdata.debitAmount} (Debit)"} \nClient Name : ${subdata.transName} \nDate : ${subdata.transDate} \nDescription : ${subdata.description} \nPayment Type : ${subdata.paymentMode} \n----------------------------------------    \n";
      });
    });
  }

  void _addincome(context, String addincome) {
    bool click = false;
    String paymentmode = "";
    String paymenttype = "";
    String currentdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String currentdatasend = DateFormat('yyyy-MM-dd').format(DateTime.now());
    TextEditingController addamount = TextEditingController();
    TextEditingController paidby = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController mobileno = TextEditingController();
    String? mobile = "";
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      addincome == "Add Income"
                                          ? "Add Income"
                                          : "Add Expenses",
                                      style: const TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          if (kDebugMode) {
                                            print(pickedDate);
                                          }
                                          String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                          String formattedDatesend =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                          if (kDebugMode) {
                                            print(formattedDate);
                                          }
                                          setState(() {
                                            currentdate = formattedDate;
                                            currentdatasend = formattedDatesend;
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primary),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(17))),
                                        height: 32,
                                        width: 100,
                                        child: Center(
                                          child: Text(currentdate),
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.25),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 0.25),
                                    ),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: AppColors.textfieldcolor,
                                    hintText: "Amount"),
                                controller: addamount,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.25),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 0.25),
                                    ),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: AppColors.textfieldcolor,
                                    hintText: addincome=="Add Income"?"Paid by":"Paid To"),
                                controller: paidby,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              click == false
                                  ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    click = true;
                                  });
                                  if (kDebugMode) {
                                    print(click);
                                  }
                                },
                                child: const Text(
                                  "+Add description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "OpenSans",
                                      fontSize: 14,
                                      color: AppColors.primary),
                                ),
                              )
                                  : const SizedBox.shrink(),
                              click == true
                                  ? Column(
                                children: [
                                  TextField(
                                    textCapitalization:
                                    TextCapitalization.words,
                                    decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 0.25),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 0.25),
                                        ),
                                        filled: true,
                                        border: InputBorder.none,
                                        fillColor: AppColors.textfieldcolor,
                                        hintText: "Description"),
                                    controller: description,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.textfieldcolor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: TextFormField(
                                      controller: mobileno,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        fillColor: AppColors.green,
                                        hintText: 'Mobile Number',
                                        border: InputBorder.none,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 0.25),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 0.25),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 0.25),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          mobile = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                                  : const Text(""),
                              const Text("Select payment method"),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            paymentmode = "0";
                                            paymenttype = "Cash";
                                          });
                                          if (kDebugMode) {
                                            print(paymentmode);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle_outlined,
                                                color: paymentmode == "0"
                                                    ? AppColors.primary
                                                    : AppColors.gray),
                                            const Text("Cash"),
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              paymentmode = "1";
                                              paymenttype = "UPI";
                                            });
                                            if (kDebugMode) {
                                              print(paymentmode);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle_outlined,
                                                  color: paymentmode == "1"
                                                      ? AppColors.primary
                                                      : AppColors.gray),
                                              const Text("UPI"),
                                            ],
                                          ))),
                                  Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            paymentmode = "2";
                                            paymenttype = "Cheque";
                                          });
                                          if (kDebugMode) {
                                            print(paymentmode);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle_outlined,
                                                color: paymentmode == "2"
                                                    ? AppColors.primary
                                                    : AppColors.gray),
                                            const Text("Cheque"),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [

                                  // Expanded(
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         setState(() {
                                  //           paymentmode = "3";
                                  //           paymenttype = "Googlepay";
                                  //         });
                                  //         if (kDebugMode) {
                                  //           print(paymentmode);
                                  //         }
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Icon(Icons.circle_outlined,
                                  //               color: paymentmode == "3"
                                  //                   ? AppColors.primary
                                  //                   : AppColors.gray),
                                  //           const Text("Googlepay"),
                                  //         ],
                                  //       ),
                                  //     )),
                                ],
                              ),
                              Container(
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                          ),
                                          backgroundColor: AppColors.primary,
                                        ),
                                        onPressed: () async {
                                          if (addamount.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Please Add  Amount"),
                                            ));
                                          } else if (paidby.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar( SnackBar(
                                              content:
                                              Text(addincome == "Add Income"?"Please Add  Paid By Name":"Please Add  Paid To Name"),
                                            ));
                                          } else if (mobileno.text.isNotEmpty &&
                                              mobileno.text.length != 10) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please 10 digit  Mobile Number"),
                                            ));
                                          } else if (mobileno.text.isNotEmpty &&
                                              mobileno.text.length < 10) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please 10 digit  Mobile Number"),
                                            ));
                                          } else if (paymentmode == "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please Select Payment Mode"),
                                            ));
                                          } else {
                                            print(ApiUrl.add_transection);
                                            print(addincome == "Add Income"
                                                ? "ADDINCOME"
                                                : "ADD EXPENSES");

                                            final response = await http.post(
                                              Uri.parse(ApiUrl.add_transection),
                                              body: {
                                                "user_id": UserId,
                                                "trans_date": currentdatasend,
                                                "credit_amount":
                                                addincome == "Add Income"
                                                    ? addamount.text
                                                    : "0",
                                                "debit_amount":
                                                addincome == "Add Income"
                                                    ? "0"
                                                    : addamount.text,
                                                "description": description.text,
                                                "trans_name": paidby.text,
                                                "trans_mobile": mobileno.text,
                                                "payment_mode": paymenttype,
                                                "flag": addincome == "Add Income"
                                                    ? "credit"
                                                    : "debit",
                                              },
                                            );
                                            print({
                                              "user_id": UserId,
                                              "trans_date": currentdatasend,
                                              "credit_amount":
                                              addincome == "Add Income"
                                                  ? addamount.text
                                                  : "0",
                                              "debit_amount":
                                              addincome == "Add Income"
                                                  ? "0"
                                                  : addamount.text,
                                              "description": description.text,
                                              "trans_name": paidby.text,
                                              "trans_mobile": mobileno.text,
                                              "payment_mode": paymenttype,
                                              "flag": addincome == "Add Income"
                                                  ? "credit"
                                                  : "debit",
                                            });
                                            print(response.statusCode);
                                            print(response.body);
                                            if (response.statusCode == 200) {
                                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                content: addincome=="Add Income"?Text(
                                                    "Income Add Successfully"):Text(
                                                    "Expenses Add Successfully"),
                                                duration: Duration(microseconds: 1),
                                              ));
                                              Timer(const Duration(seconds: 1), () => Navigator.of(context).pop());
                                              alltransactionmodel =
                                                  MyFinanceList(UserId!);
                                              if (kDebugMode) {
                                                print(response.statusCode);
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              if (kDebugMode) {
                                                print("object");
                                                Navigator.pop(context);
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  floatingActionButton: Container(
                    height: 30,
                    transform: Matrix4.translationValues(170.0, -40, 0.0),
                    // translate up by 30
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        if (kDebugMode) {
                          print('doing stuff');
                        }
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerTop,
                );
              });
        });
  }

  void ShowData(context, TransectionSubData? addincome) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 40),
                            child: Text(addincome!.transName.toString()))
                      ],
                    ),
                  ),
                  floatingActionButton: Container(
                    height: 30,
                    transform: Matrix4.translationValues(170.0, -40, 0.0),
                    // translate up by 30
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        if (kDebugMode) {
                          print('doing stuff');
                        }
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerTop,
                );
              });
        });
  }

  Delete(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: SizedBox(
                height: 245,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(subMenu.image),
                        const SizedBox(
                          width: 10,
                        ),
                        boldtext(AppColors.black, 18, "Delete Entry?"),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: regulartext(
                        const Color(0xffA6A6A6),
                        14,
                        "Are you sure to delete this finance entry",
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () async {},
                          child: boldtext(AppColors.white, 14, "Delete"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: regulartext(AppColors.black, 14, "Cancel"),
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }
}

Widget cashInfo_card(String text1, String text2, {Color? color}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      color: color ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        width: 1,
        color: Colors.black26,
      ),
    ),
    width: Get.width * 0.29,
    height: 70,
    child: Center(
      child: boldtext(
        Colors.black,
        13,
        '$text1\n₹ $text2',
      ),
    ),
  );
}

List ClientViewList = [
  {
    "name": "Today",
    "value": "4",
    },
  {"name": "last week", "value": "1", },
  {
    "name": "last month",
    "value": "2",

  },
  {
    "name": "last 6 month",
    "value": "3",
      },
  {
    "name": "last year",
    "value": "5",
   },
];

class ClientView {
  var name;
  var value;


  List<ClientView> subMenu = [];

  ClientView(
      {this.value,
        this.name,
        required this.subMenu,
      });

  ClientView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu?.add(new ClientView.fromJson(v));
      });
    }
  }
}
