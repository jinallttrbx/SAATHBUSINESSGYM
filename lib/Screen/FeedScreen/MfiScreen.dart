// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/LoneScreens.dart';
import 'package:businessgym/Screen/HomeScreen/loandetailScreen.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/model/LoanListModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/MfilistModel.dart';
import '../../values/Colors.dart';

import '../../conts/global_values.dart';

class MfiScreen extends StatefulWidget {
  @override
  MfiScreenState createState() => MfiScreenState();
}

class MfiScreenState extends State<MfiScreen> {
  SharedPreference _sharedPreference = SharedPreference();
  String UserId = "";
  var now = new DateTime.now();
  final mynameController = TextEditingController();
  final mycityController = TextEditingController();
  final mynumberController = TextEditingController();
  final myemailController = TextEditingController();
  final mypriceController = TextEditingController();
  final mydescriptionController = TextEditingController();
  final myaddressController = TextEditingController();

  Future<List<MfilistModelData>?>? providerdatalist;

  // Future<AppliedLoanModel?>? providerdatalist1;
  List<MfilistModelData>? providerdata = [];
  String Mfid = "0";
  AppliedLoanListModel? addCallModel;

  // AppliedLoanModel? addCallModel1;
  bool status = false;
  String waitappliy = "no";
  String loanFilter = "Applied";
  Future<AppliedLoanListModel?>? appliedloanlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
  }

  void getuserType() async {
    String? usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();

    setState(() {
      providerdatalist = getserviceList(UserId);
      appliedloanlist = addloanmmodeloges(UserId!);
      // providerdatalist1 = addLoanModeloges(UserId!);
    });
  }

  Future<AppliedLoanListModel?> addloanmmodeloges(String userId) async {

    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'provider_id': "" + userId,
        'status': "0",
      };

      final response = await http.post(
        Uri.parse(ApiUrl.approved_loan_list),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        addCallModel = AppliedLoanListModel.fromJson(jsonDecode(response.body));
        status = addCallModel!.status!;
        waitappliy = addCallModel!.loanapply!;
        setState(() {});
        List<AppliedLoanListModeldata> loanList = addCallModel?.data
                ?.where((element) => loanFilter == 'Applied'
                    ? element.mfiName == null
                    : element.mfiName != null)
                .toList() ??
            [];

        return addCallModel;
      } else {
        hideLoader();

        return addCallModel;
      }
    } catch (e) {
      hideLoader();

    }
  }

  Future<List<MfilistModelData>?>? getserviceList(String userid) async {
    try {
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.mfilist),
        body: {
          //   "provider_id" : ""+UserId,
        },
      );

      if (response.statusCode == 200) {
        MfilistModel? myBookingModel =
            MfilistModel.fromJson(jsonDecode(response.body));

        hideLoader();
        providerdata = myBookingModel.data;


        setState(() {});

        return myBookingModel.data;
      } else {
        hideLoader();

      }
    } catch (e) {
      hideLoader();

    }
  }

  Future<bool?>? getDelete(String id) async {
    try {
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.servicedelete),
        body: {
          "id": "" + id,
        },
      );

      if (response.statusCode == 200) {
        //ProviderServiceModel? myBookingModel = ProviderServiceModel.fromJson(jsonDecode(response.body));

        hideLoader();

        //providerdata = myBookingModel.data;

        providerdatalist = getserviceList(UserId);
        setState(() {});

        return true;
      } else {
        hideLoader();

      }
    } catch (e) {
      hideLoader();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        appBar: APPBar(title: "Loan"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<AppliedLoanListModel?>(
                        future: appliedloanlist,
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
                              List<AppliedLoanListModeldata> loanList =
                                  addCallModel
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
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: loanList.length,
                                      itemBuilder: (context, position) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: 16,
                                              right: 16),
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF9F9F9),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: boldtext(
                                                        AppColors.black,
                                                        16,
                                                        "${"Loan request sent..."}"),
                                                  ),
                                                  Expanded(
                                                      child: SvgPicture.asset(
                                                    AppImages.loanapply,
                                                  ))
                                                ],
                                              ),
                                              boldtext(AppColors.hint, 14,
                                                  "Status: ${loanList[position].approved == 0 ? "Applied" : "Reject" ?? ""}"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Divider(
                                                height: 1,
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        regulartext(
                                                            AppColors.hint,
                                                            12,
                                                            "Requested amount"),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        boldtext(
                                                            AppColors.black,
                                                            14,
                                                            "₹${loanList[position].loanAmount ?? ""}"),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        //  regulartext(AppColors.hint,12,"Installment"),
                                                        //  SizedBox(height: 5,),
                                                        // boldtext(AppColors.black,14,"₹${loanList[position].installmentAmount??""}"),
                                                        // SizedBox(height: 15,),
                                                        //  regulartext(AppColors.hint,12,"Interest rate"),
                                                        //  SizedBox(height: 5,),
                                                        // boldtext(AppColors.black,14,"${loanList[position].intrestRate}%")
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        regulartext(
                                                            AppColors.hint,
                                                            12,
                                                            "Loan type"),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        boldtext(
                                                            AppColors.black,
                                                            14,
                                                            "${loanList[position].loanType}"),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        //  regulartext(AppColors.hint,12,"Issue date"),
                                                        // SizedBox(height: 5,),
                                                        // boldtext(AppColors.black,14,"${DateFormat("dd/MM/yyyy").format(loanList[position].applyDate)}"),
                                                        // SizedBox(height: 15,),
                                                        // regulartext(AppColors.hint,12,"MFI Score"),
                                                        //  SizedBox(height: 5,),
                                                        // boldtext(AppColors.black,14,"${loanList[position].scoreCount}/100"),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height: 1,
                                                thickness: 1,
                                              ),
                                              boldtext(AppColors.hint, 12,
                                                  "Purpose"),
                                              regulartext(AppColors.black, 14,
                                                  "${loanList[position].purpose}")
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
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: boldtext(AppColors.black, 16, "List of MFIs"),
                    ),
                    FutureBuilder<List<MfilistModelData?>?>(
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
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                           Mfid=snapshot.data![index]!.mfiId.toString();

                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Mfid==snapshot.data![index]!.mfiId.toString()?   AppColors.LightBlue
                                          : null,
                                        ),
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.network(
                                                snapshot.data![index]!.image!,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Expanded(
                                                child: regulartext(
                                                    AppColors.black,
                                                    14,
                                                    snapshot.data![index]!
                                                        .userName!))
                                          ],
                                        ),
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
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  onPressed: () {
                    Get.to(LoneScreens(Mfid));
                  },
                  child: boldtext(
                    AppColors.white,
                    18,
                    'Apply for loan',
                  )),
            ),
          ),
        ));
  }
}
