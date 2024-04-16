// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, file_names, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable, deprecated_member_use

import 'dart:convert';

import 'package:businessgym/model/ViewpollsModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';


class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  PollScreenState createState() => PollScreenState();
}

class PollScreenState extends State<PollScreen> {
  List<ViewpollsModelData>? viewpollsModelData = [];

  String UserId = "";
  String categotyid = "";
  String? usertoken = "";
  String? usertype = "";

  final SharedPreference _sharedPreference = SharedPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();

    setState(() {});
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId);
    print("Ashish tiken$usertoken");
    //listData1=getcategotyData();
    getcategotyData(UserId);
  }

  Future<List<ViewpollsModelData>?> getcategotyData(String userid) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.viewpolls),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      print("dixitUrl:==========" + ApiUrl.viewquiz);
      print("dixitBody:==========" + response.body);
      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        ViewpollsModel catrgortModel =
            ViewpollsModel.fromJson(jsonDecode(response.body));
        viewpollsModelData = catrgortModel.data;
        setState(() {});
        return viewpollsModelData;
      } else {
        hideLoader();
      }
      print(response.statusCode);
    } catch (e) {
      hideLoader();
      print("sdfok" + e.toString());
    }
  }

  Future<bool?> getansAdd(String userid, String question_id, String correct_ans) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
        'poll_id': question_id,
        'poll': correct_ans,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.addpolls),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      print("dixitUrl:==========" + ApiUrl.viewquiz);
      print("dixitBody:==========" + response.body);
      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        getcategotyData(UserId);
        setState(() {});
        return true;
      } else {
        hideLoader();
      }
      print(response.statusCode);
    } catch (e) {
      hideLoader();
      print("sdfok" + e.toString());
    }
  }

  List sendOption = ["A", "B", "C", "D", "E", "F", "G"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: viewpollsModelData!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 6),
                          width: Get.width * 0.7,
                          child: boldtext(AppColors.black, 16,
                              viewpollsModelData![index].question!),
                        ),
                        vertical(10),
                        ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          itemCount: viewpollsModelData![index].option!.length,
                          itemBuilder: (BuildContext context, int inner) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getansAdd(
                                      UserId,
                                      viewpollsModelData![index]
                                          .id!
                                          .toString(),
                                      sendOption[inner]);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          viewpollsModelData![index]
                                              .option![inner]
                                              .option ==
                                              viewpollsModelData![index]
                                                  .answerValue
                                              ? Icons.circle
                                              : Icons.circle_outlined,
                                          color: AppColors.primary,
                                          size: 12,
                                        ),
                                        horizental(10),
                                        regulartext(
                                            AppColors.black,
                                            14,
                                            viewpollsModelData![index]
                                                .option![inner]
                                                .option
                                                .toString())
                                      ],
                                    ),
                                  ),
                                  viewpollsModelData![index].answerValue !=
                                      ""
                                      ? viewpollsModelData![index].option.length==1?SizedBox.shrink():Container(
                                      child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                            LinearPercentIndicator(
                            width:
                            MediaQuery.of(context)
                                .size
                                .width -
                            100,
                            animation: true,
                            lineHeight: 5.0,
                            animationDuration: 2500,
                            percent: double.parse(
                            "0.${100 == viewpollsModelData![index].percentage![inner].percetage! ? 99 : viewpollsModelData![index].percentage![inner].percetage!}"),

                            linearStrokeCap:
                            LinearStrokeCap
                                .roundAll,
                            barRadius:
                            const Radius.circular(
                            30),
                            progressColor: AppColors.primary,
                            ),
                            Text(
                            "${viewpollsModelData![index].percentage![inner].percetage!}%",
                            style: const TextStyle(
                            fontFamily: "bold",
                            fontSize: 14),
                            ),
                            ],
                            ),
                            )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
