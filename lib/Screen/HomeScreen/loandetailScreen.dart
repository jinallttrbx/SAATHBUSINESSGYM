// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, file_names, body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';


import 'package:businessgym/Screen/FeedScreen/MfiScreen.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Utils/ApiUrl.dart';

import '../../../Utils/SharedPreferences.dart';
import '../../../Utils/common_route.dart';
import '../../../model/LoanListModel.dart';
import '../../../values/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../values/assets.dart';
import '../../../values/const_text.dart';
import '../../../values/spacer.dart';

class LoneDetailScreens extends StatefulWidget {

   LoneDetailScreens();

  @override
  LoneListScreensState createState() => LoneListScreensState();
}

class LoneListScreensState extends State<LoneDetailScreens> {
  Future<LoanListModel?>? providerdatalist;
  LoanListModel? addCallModel;
  String loanFilter = "Approved";
  String? UserId;
  bool status = false;
  String waitappliy = "no";
  SharedPreference sharedPreference = SharedPreference();




  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    userid();
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: APPBar(
          title: "Active Loans",
        ),

        body: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(

              children: [
                FutureBuilder<LoanListModel?>(
                    future: providerdatalist,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          List<LoanListModelData> loanList = addCallModel
                              ?.data
                              ?.where((element) =>
                          loanFilter == 'Applied'
                              ? element.mfiName == null
                              : element.mfiName != null)
                              .toList() ??
                              [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Row(
                               children: [
                                Expanded(child:  regulartext(AppColors.hint,14,"Loan Board"),),
                                 ElevatedButton(
                                     style: ElevatedButton
                                         .styleFrom(
                                       shape:
                                       RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius
                                             .circular(
                                             12.0),
                                       ),
                                       backgroundColor:
                                       AppColors
                                           .lightblue,
                                     ),
                                     onPressed: () {
                                       Get.to(MfiScreen());
                                     },
                                     child: boldtext(
                                       AppColors.primary,
                                       12,
                                       'Apply Loan',
                                     )),
                               ],
                             ),

                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:loanList.length,
                                  itemBuilder: (context,position){
                                    return Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20,left: 16,right: 16),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF9F9F9),
                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          boldtext(AppColors.black,16,"${loanList[position].mfiName??""}"),
                                          SizedBox(height: 15,),
                                          Divider(height: 1,thickness: 1,),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                             Expanded(child:  Column(
                                               crossAxisAlignment:CrossAxisAlignment.start,
                                               children: [
                                                 regulartext(AppColors.hint,12,"Loan amount"),
                                                 SizedBox(height: 5,),
                                                 boldtext(AppColors.black,14,"₹${loanList[position].loanAmount??""}"),
                                                 SizedBox(height: 15,),
                                                 regulartext(AppColors.hint,12,"Installment"),
                                                 SizedBox(height: 5,),
                                                 boldtext(AppColors.black,14,"₹${loanList[position].installmentAmount??""}"),
                                                 SizedBox(height: 15,),
                                                 regulartext(AppColors.hint,12,"Interest rate"),
                                                 SizedBox(height: 5,),
                                                 boldtext(AppColors.black,14,"${loanList[position].intrestRate}%")
                                               ],
                                             ),),
                                              Expanded(child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  regulartext(AppColors.hint,12,"Loan type"),
                                                  SizedBox(height: 5,),
                                                  boldtext(AppColors.black,14,"${loanList[position].loanType}"),
                                                  SizedBox(height: 15,),
                                                  regulartext(AppColors.hint,12,"Issue date"),
                                                  SizedBox(height: 5,),
                                                  boldtext(AppColors.black,14,"${DateFormat("dd/MM/yyyy").format(loanList[position].applyDate)}"),
                                                  SizedBox(height: 15,),
                                                  regulartext(AppColors.hint,12,"MFI Score"),
                                                  SizedBox(height: 5,),
                                                  boldtext(AppColors.black,14,"${loanList[position].scoreCount}/100"),
                                                ],
                                              ),)

                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  })


                            ],
                          );
                        }
                      }

                      // Displaying LoadingSpinner to indicate waiting state
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            )
          ),
        ),
      ),
    );
  }

  Future<void> userid() async {
    UserId = await sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    providerdatalist = addLoanModeloges(UserId!);
  }

  Future<LoanListModel?> addLoanModeloges(String userId) async {
    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'provider_id': "" + userId,
        'status':"1",
      };
      print("USerId1 == supplier_id" + userId);
      final response = await http.post(
        Uri.parse(ApiUrl.approved_loan_list),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);
      print("Responce new datatat ===== ---- " + ApiUrl.approved_loan_list);
      print("Responce new datatat ===== ---- " + response.body);
      if (response.statusCode == 200) {
        hideLoader();
        addCallModel = LoanListModel.fromJson(jsonDecode(response.body));
        status = addCallModel!.status!;
        waitappliy = addCallModel!.loanapply!;
        setState(() {});
        List<LoanListModelData> loanList = addCallModel?.data
            ?.where((element) => loanFilter == 'Applied'
            ? element.mfiName == null
            : element.mfiName != null)
            .toList() ??
            [];
        print(addCallModel);
        return addCallModel;
      } else {
        hideLoader();
        print("Something went wronge");
        return addCallModel;
      }
    } catch (e) {
      hideLoader();
      print("data==1=$e");
    }
  }





}
