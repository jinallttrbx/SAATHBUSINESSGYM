// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/ViewquizModel.dart';
import '../../values/Colors.dart';

class QuizScreen extends StatefulWidget {
  @override
  QuizScreenState createState() => QuizScreenState();
}

enum boovalue { yes, no }

class QuizScreenState extends State<QuizScreen> {
  List<ViewquizModelData>? viewquizModelData = [];

  bool yesValue = false;
  bool NoValue = false;

  double percent = 50.0;
  String UserId = "";
  String categotyid = "";
  String? usertoken = "";
  String? usertype = "";

  SharedPreference _sharedPreference = new SharedPreference();

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
    print("Ashish tiken${usertoken}");
    getcategotyData(UserId);
  }

  Future<List<ViewquizModelData>?> getcategotyData(String userid) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.viewquiz),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      print("dixitUrl:==========" + ApiUrl.viewquiz);
      print("dixitBody:==========" + response.body);
      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        ViewquizModel catrgortModel =
            ViewquizModel.fromJson(jsonDecode(response.body));
        viewquizModelData = catrgortModel.data;
        setState(() {});
        return viewquizModelData;
      } else {
        hideLoader();
      }
      print(response.statusCode);
    } catch (e) {
      hideLoader();
      print("sdfok" + e.toString());
    }
  }

  Future<bool?> getansAdd(
      String userid, String question_id, String correct_ans) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
        'question_id': question_id,
        'correct_ans': correct_ans,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.addquiz),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        getcategotyData(UserId);
        setState(() {});

        return true;
      }
      print(response.statusCode);
    } catch (e) {
      hideLoader();
      print("sdfok" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: viewquizModelData!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "" + viewquizModelData![index].question!,
                            style: const TextStyle(
                                fontFamily: "bold", fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              yesValue = true;
                              NoValue = false;

                              getansAdd(
                                  UserId,
                                  viewquizModelData![index].id.toString(),
                                  "A");
                            });
                          },
                          child: viewquizModelData![index].answerValue == ""
                              ? Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color: viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .answerA
                                    ? viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? viewquizModelData![index]
                                    .answerA ==
                                    viewquizModelData![
                                    index]
                                        .correctAnsValue
                                    ? AppColors.primary
                                    : AppColors.primary
                                    : AppColors.red
                                    : AppColors.grey),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "" +
                                        viewquizModelData![index]
                                            .answerA!,
                                    style:  TextStyle(
                                      color: viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .answerA
                                          ? viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? viewquizModelData![index]
                                          .answerA ==
                                          viewquizModelData![
                                          index]
                                              .correctAnsValue
                                          ? AppColors.white
                                          : AppColors.white
                                          : AppColors.white
                                          : AppColors.black,
                                        fontFamily: "reguler",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color: viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .answerA
                                    ? viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? AppColors.primary
                                    : AppColors.red
                                    : viewquizModelData![index]
                                    .answerValue !=
                                    ""
                                    ? viewquizModelData![index]
                                    .correctAnsValue ==
                                    viewquizModelData![
                                    index]
                                        .answerA
                                    ? AppColors.primary
                                    : AppColors.grey
                                    : AppColors.grey),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "" +
                                        viewquizModelData![index]
                                            .answerA!,
                                    style:  TextStyle(
                                      color: viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .answerA
                                          ? viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? AppColors.white
                                          : AppColors.white
                                          : viewquizModelData![index]
                                          .answerValue !=
                                          ""
                                          ? viewquizModelData![index]
                                          .correctAnsValue ==
                                          viewquizModelData![
                                          index]
                                              .answerA
                                          ? AppColors.white
                                          : AppColors.black
                                          : AppColors.black,
                                        fontFamily: "reguler",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              yesValue = false;
                              NoValue = true;
                              getansAdd(
                                  UserId,
                                  viewquizModelData![index].id.toString(),
                                  "B");
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index].answerB
                                    ? viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? viewquizModelData![index]
                                    .answerB ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? AppColors.primary
                                    : AppColors.primary
                                    : AppColors.red
                                    : viewquizModelData![index]
                                    .answerValue !=
                                    ""
                                    ? viewquizModelData![index]
                                    .correctAnsValue ==
                                    viewquizModelData![index]
                                        .answerB
                                    ? AppColors.primary
                                    : AppColors.grey
                                    : AppColors.grey),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "" + viewquizModelData![index].answerB!,
                                    style:  TextStyle(
                                      color: viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index].answerB
                                          ? viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? viewquizModelData![index]
                                          .answerB ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? AppColors.white
                                          : AppColors.white
                                          : AppColors.white
                                          : viewquizModelData![index]
                                          .answerValue !=
                                          ""
                                          ? viewquizModelData![index]
                                          .correctAnsValue ==
                                          viewquizModelData![index]
                                              .answerB
                                          ? AppColors.white
                                          : AppColors.black
                                          : AppColors.black,
                                        fontFamily: "reguler",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              yesValue = false;
                              NoValue = true;
                              getansAdd(
                                  UserId,
                                  viewquizModelData![index].id.toString(),
                                  "C");
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index].answerC
                                    ? viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? viewquizModelData![index]
                                    .answerC ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? AppColors.primary
                                    : AppColors.primary
                                    : AppColors.red
                                    : viewquizModelData![index]
                                    .answerValue !=
                                    ""
                                    ? viewquizModelData![index]
                                    .correctAnsValue ==
                                    viewquizModelData![index]
                                        .answerC
                                    ? AppColors.primary
                                    : AppColors.grey
                                    : AppColors.grey),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "" + viewquizModelData![index].answerC!,
                                    style:  TextStyle(
                                      color: viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index].answerC
                                          ? viewquizModelData![index]
                                          .answerValue ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? viewquizModelData![index]
                                          .answerC ==
                                          viewquizModelData![index]
                                              .correctAnsValue
                                          ? AppColors.white
                                          : AppColors.white
                                          : AppColors.white
                                          : viewquizModelData![index]
                                          .answerValue !=
                                          ""
                                          ? viewquizModelData![index]
                                          .correctAnsValue ==
                                          viewquizModelData![index]
                                              .answerC
                                          ? AppColors.white
                                          : AppColors.black
                                          : AppColors.black,
                                        fontFamily: "reguler",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              yesValue = false;
                              NoValue = true;
                              getansAdd(
                                  UserId,
                                  viewquizModelData![index].id.toString(),
                                  "D");
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index].answerD
                                    ? viewquizModelData![index]
                                    .answerValue ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? viewquizModelData![index]
                                    .answerD ==
                                    viewquizModelData![index]
                                        .correctAnsValue
                                    ? AppColors.primary
                                    : AppColors.primary
                                    : AppColors.red
                                    : viewquizModelData![index]
                                    .answerValue !=
                                    ""
                                    ? viewquizModelData![index]
                                    .correctAnsValue ==
                                    viewquizModelData![index]
                                        .answerD
                                    ? AppColors.primary
                                    : AppColors.grey
                                    : AppColors.grey),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "" + viewquizModelData![index].answerD!,
                                    style:  TextStyle(
                                        color: viewquizModelData![index]
                                            .answerValue ==
                                            viewquizModelData![index].answerD
                                            ? viewquizModelData![index]
                                            .answerValue ==
                                            viewquizModelData![index]
                                                .correctAnsValue
                                            ? viewquizModelData![index]
                                            .answerD ==
                                            viewquizModelData![index]
                                                .correctAnsValue
                                            ? AppColors.white
                                            : AppColors.white
                                            : AppColors.white
                                            : viewquizModelData![index]
                                            .answerValue !=
                                            ""
                                            ? viewquizModelData![index]
                                            .correctAnsValue ==
                                            viewquizModelData![index]
                                                .answerD
                                            ? AppColors.white
                                            : AppColors.black
                                            : AppColors.black,
                                        fontFamily: "reguler",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
