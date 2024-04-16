// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, file_names, body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';

import 'package:businessgym/Screen/HomeScreen/loandetailScreen.dart';
import 'package:businessgym/components/button.dart';

import 'package:businessgym/conts/appbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import '../../../Utils/ApiUrl.dart';

import '../../../Utils/SharedPreferences.dart';
import '../../../Utils/common_route.dart';
import '../../../model/LoanListModel.dart';
import '../../../values/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../values/assets.dart';
import '../../../values/const_text.dart';
import '../../../values/spacer.dart';
import '../../../conts/global_values.dart';
import 'LoneScreens.dart';
import '../../../Screen/FeedScreen/MfiScreen.dart';



class LoneListScreens extends StatefulWidget {
  const LoneListScreens({super.key});

  @override
  LoneListScreensState createState() => LoneListScreensState();
}

class LoneListScreensState extends State<LoneListScreens> {
  String? UserId;
  bool visible = false;
  bool status = false;
  String waitappliy = "no";
  String loanFilter = "Approved";

  SharedPreference sharedPreference = SharedPreference();

  final myloanamountController = TextEditingController();
  final mypurposeController = TextEditingController();

  LoanListModel? addCallModel;
  Future<LoanListModel?>? providerdatalist;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    userid();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: APPBar(
          title: " Loans",
        ),

        body: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                vertical(10),
                ButtonMain(
                  ontap: () {
                    Get.to(MfiScreen());
                  },
                  text: "List of MFIs",
                  width: 0.6,
                  loader: false,
                  height: 40,
                ),
                vertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 14,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: AppColors.BGColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PopupMenuButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              loanFilter,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        // icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                          const PopupMenuItem<String>(
                            value: 'Approved',
                            child: Text('Approved'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Applied',
                            child: Text('Applied'),
                          ),
                        ],
                        onSelected: (value) => setState(() {
                          loanFilter = value;
                          // print(filter);
                        }),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                status == false
                    ? Center(
                        child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset("assets/images/nodatafound.gif"),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("You have a not any active loan"),
                        ],
                      ))
                    : FutureBuilder<LoanListModel?>(
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
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: loanList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      elevation: 6,
                                      color: index > 10
                                          ? colorList[index.remainder(10).abs()]
                                          : colorList[index],
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 15),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                boldtext(
                                                  AppColors.blackShade10,
                                                  14,
                                                  loanList[index].mfiName ==
                                                          null
                                                      ? "Loan Applied"
                                                      : "Loan Approved by"
                                                          " ${loanList![index].mfiName}",
                                                ),
                                                vertical(5),
                                                boldtext(AppColors.black, 25,
                                                    "₹ ${loanList[index].loanAmount}"),
                                              ],
                                            ),
                                            trailing:
                                                Image.asset(AppImages.search),
                                            subtitle: boldtext(
                                                AppColors.blackShade10,
                                                12,
                                                "Apply Date : ${loanList[index].applyDate!}"),
                                            onTap: () {
                                              Get.to(LoneDetailScreens());
                                              //alert(loanList[index]);

                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          }

                          // Displaying LoadingSpinner to indicate waiting state
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alert(dynamic data) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          // titleText: 'Title',
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(AppImages.APP_LOGO),
                    ),
                  ),
                  boldtext(AppColors.black, 14, "Loan / Borrowing"),
                  vertical(20),
                  cardView(AppColors.bg2, "Total Loan Balance",
                      "₹ ${data.loanAmount}"),
                  cardView(AppColors.bg3, "Amount to be returned/paid",
                      "₹ ${data.recievedAmount}"),
                  cardView(AppColors.bg4, "Amount Remaining",
                      "₹ ${data.remainingAmount}"),
                  cardView(AppColors.bg5, "Loan Tenure", "${data.tenure}"),
                  cardView(AppColors.bg6, "Loan Approved Date",
                      " ${data.approvedDate}"),
                  vertical(20),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ButtonMain(
                        ontap: () {
                          Get.back();
                        },
                        text: 'Back',
                        width: 0.2,
                        loader: false,
                        fsize: 12,
                        height: 40,
                      )),
                  vertical(20),
                ],
              ),
            )
          ],
        );
      },
      animationType: DialogTransitionType.slideFromRightFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000),
    );

  }

  Widget cardView(Color color, String text1, String text2) {
    return Card(
      elevation: 4,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldtext(AppColors.blackShade10, 12, text1),
            boldtext(AppColors.black, 14, text2),
          ],
        ),
      ),
    );
  }

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }
}
