import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/NewDetailScreen.dart';
import 'package:businessgym/Screen/FeedScreen/VideoDetailScreen.dart';
import 'package:businessgym/Screen/FeedScreen/VideoPlayerScreen.dart';
import 'package:businessgym/Screen/FeedScreen/VideosDetailsScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/AllFeedModel.dart';
import 'package:businessgym/model/all_videos_model.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pod_player/pod_player.dart';
import '../../model/GetVideosModel.dart';

class FeedmainScreen extends StatefulWidget {
  State<FeedmainScreen> createState() => _FeedmainScreenState();
}

class _FeedmainScreenState extends State<FeedmainScreen> {
  //List<Data>? data = [];
  bool yesValue = false;
  bool NoValue = false;
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  List<AllFeedModel>? getCityStateIdDataData = [];
  final SharedPreference _sharedPreference = SharedPreference();
  Future<AllFeedModel?>? allservice1;
  List<AllFeedModeldata> list = [];
  List<AllFeedModel>? productcategorydata = [];
  List sendOption = ["A", "B", "C", "D", "E", "F", "G"];
  int like =0;

  @override
  void initState() {
    super.initState();
    getuserType();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index1) {
              return Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        list[index1].type == "video"
                            ? Container(
                            padding: EdgeInsets.only(
                            left: 20, right: 16, bottom: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
              Radius.circular(16))),
              child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
              GestureDetector(
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => VideosDetailScreen(
              data: list[index1]
              ),
              ),
              );
              },
              child:      Container(
              padding: EdgeInsets.only(
              left: 0, right: 0, bottom: 0),
              height: 150,
              width:
              MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius:
              BorderRadius.circular(15)),
              margin: EdgeInsets.only(
              top: 10, bottom: 10),
              child: ClipRRect(
              borderRadius:
              BorderRadius.circular(15),
              child: Image.network(
              list[index1].thumbnailImage ?? "",
              height: 150,
              width: MediaQuery.of(context)
                  .size
                  .width,
              fit: BoxFit.fill,
              ),
              ),
              ),
              ),
              boldtext(
              Colors.black,
              14,
              list[index1].videoTital ?? "",
              ),
              regulartext(
              AppColors.hint,
              12,
              list[index1].videoShortDescription ??
              ""),
              SizedBox(
              height: 12,
              ),
              Row(
              children: [

              GestureDetector(
              onDoubleTap:(){
              setState(() {
              like=1;

              });
              print("ADD LIKE $like");

              },
              child:  Row(
              children: [
             like==0? SvgPicture.asset(AppImages.like):SvgPicture.asset(AppImages.like,color: AppColors.primary,),
              SizedBox(
              width: 5,
              ),
              regulartext(AppColors.black, 14,
              "${list[index1].totalLike ?? ""!}")
              ],
              ),
              ),
              SizedBox(
              width: 10,
              ),
              Row(
              children: [
              SvgPicture.asset(
              AppImages.comment),
              SizedBox(
              width: 5,
              ),
              regulartext(AppColors.black, 14,
              "${list[index1].totalComments ?? ""!}")
              ],
              ),
              SizedBox(
              width: 10,
              ),
              Row(
              children: [
              SvgPicture.asset(AppImages.time),
              SizedBox(
              width: 5,
              ),
              regulartext(AppColors.black, 14,
              "${list[index1].videoDuration ?? ""!}")
              ],
              )
              ],
              )
              ],
              ),
              )
                            : SizedBox.shrink(),
                        list[index1].type == "polls"
                            ? Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    //set border radius more than 50% of height and width to make circle
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(top: 6),
                                          width: Get.width * 0.7,
                                          child: boldtext(AppColors.black, 16,
                                              list![index1].pollsQuestion!),
                                        ),
                                        vertical(10),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          controller: ScrollController(),
                                          itemCount:
                                              list![index1].option!.length,
                                          itemBuilder: (BuildContext context,
                                              int inner) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      getansAdd(
                                                          UserId,
                                                          list![index1]
                                                              .id!
                                                              .toString(),
                                                          sendOption[inner]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          list![index1]
                                                                      .option![
                                                                          inner]
                                                                      .option ==
                                                                  list![index1]
                                                                      .answerValue
                                                              ? Icons.circle
                                                              : Icons
                                                                  .circle_outlined,
                                                          color:
                                                              AppColors.primary,
                                                          size: 12,
                                                        ),
                                                        horizental(10),
                                                        regulartext(
                                                            AppColors.black,
                                                            14,
                                                            list![index1]
                                                                .option![inner]
                                                                .option
                                                                .toString())
                                                      ],
                                                    ),
                                                  ),
                                                  list![index1].answerValue !=
                                                          ""
                                                      ? list![index1]
                                                                  .option!
                                                                  .length ==
                                                              1
                                                          ? SizedBox.shrink()
                                                          : Container(
                                                              child: Row(
                                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  LinearPercentIndicator(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        100,
                                                                    animation:
                                                                        true,
                                                                    lineHeight:
                                                                        5.0,
                                                                    animationDuration:
                                                                        2500,
                                                                    percent: double
                                                                        .parse(
                                                                            "0.${100 == list![index1].percentage![inner].percetage! ? 99 : list![index1].percentage![inner].percetage!}"),
                                                                    linearStrokeCap:
                                                                        LinearStrokeCap
                                                                            .roundAll,
                                                                    barRadius:
                                                                        const Radius.circular(
                                                                            30),
                                                                    progressColor:
                                                                        AppColors
                                                                            .primary,
                                                                  ),
                                                                  Text(
                                                                    "${list![index1].percentage![inner].percetage!}%",
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "bold",
                                                                        fontSize:
                                                                            14),
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
                                        // Container(
                                        //   // margin:
                                        //   //     const EdgeInsets.only(left: 10, right: 10),
                                        //   child: Column(
                                        //     children: [
                                        //       InkWell(
                                        //         onTap: () {

                                        //         },
                                        //         child: Container(
                                        //             //height: 40,
                                        //             margin: const EdgeInsets.only(top: 10),
                                        //             child: Row(
                                        //               crossAxisAlignment:
                                        //                   CrossAxisAlignment.center,
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 // Icon(
                                        //                 //   viewpollsModelData![index]
                                        //                 //               .answerValue
                                        //                 //               .toString() ==
                                        //                 //           viewpollsModelData![index]
                                        //                 //               .optionB!
                                        //                 //               .toString()
                                        //                 //       ? Icons.circle
                                        //                 //       : Icons.circle_outlined,
                                        //                 //   size: 12,
                                        //                 // ),
                                        //                 horizental(8),
                                        //                 // Container(
                                        //                 //     width: Get.width * 0.6,
                                        //                 //     child: lighttext(
                                        //                 //         AppColors.blackShade4,
                                        //                 //         14,
                                        //                 //         viewpollsModelData![index]
                                        //                 //             .optionB!
                                        //                 //             .toString())),
                                        //               ],
                                        //             )),
                                        //       ),
                                        //       vertical(5),

                                        //       //     : Container(),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        list[index1].type == "news"
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(NewsDetailScreen(videos: list![index1],));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 10,
                                        top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    list[index1]
                                                            .thumbnailImage ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
//length>15?'${ list_circular[index].title.substring(0,14)}...' :list_circular[index].title,
                                                Text(
                                                  list![index1]!.title!,
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  list![index1]!
                                                      .createdAt
                                                      .toString()!,
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xffA6A6A6)),
                                                ),
                                                Text(list![index1]!
                                                            .link!
                                                            .length >
                                                        100
                                                    ? list![index1]!
                                                        .link!
                                                        .substring(0, 99)
                                                    : list![index1]!.link!),
                                              ],
                                            ))
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color:
                                              AppColors.hint.withOpacity(0.5),
                                        )
                                      ],
                                    )),
                              )
                            : SizedBox.shrink(),
                        list[index1].type == "quiz"
                            ? Container(
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
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "" + list![index1].quizQuestion!,
                                            style: const TextStyle(
                                                fontFamily: "bold",
                                                fontSize: 16),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              yesValue = true;
                                              NoValue = false;

                                              getansAdd(
                                                  UserId,
                                                  list![index1].id.toString(),
                                                  "A");
                                            });
                                          },
                                          child: list![index1].answerValue == ""
                                              ? Container(
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      top: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: list![index1]
                                                                  .answerValue ==
                                                              list![index1]
                                                                  .answerA
                                                          ? list![index1]
                                                                      .answerValue ==
                                                                  list![index1]
                                                                      .correctAnsValue
                                                              ? list![index1]
                                                                          .answerA ==
                                                                      list![index1]
                                                                          .correctAnsValue
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .primary
                                                              : AppColors.red
                                                          : AppColors.grey),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 15),
                                                        child: Text(
                                                          "" +
                                                              list![index1]
                                                                  .answerA!,
                                                          style: TextStyle(
                                                              color: list![index1]
                                                                          .answerValue ==
                                                                      list![index1]
                                                                          .answerA
                                                                  ? list![index1]
                                                                              .answerValue ==
                                                                          list![index1]
                                                                              .correctAnsValue
                                                                      ? list![index1].answerA ==
                                                                              list![index1]
                                                                                  .correctAnsValue
                                                                          ? AppColors
                                                                              .white
                                                                          : AppColors
                                                                              .white
                                                                      : AppColors
                                                                          .white
                                                                  : AppColors
                                                                      .black,
                                                              fontFamily:
                                                                  "reguler",
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      top: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: list![index1]
                                                                  .answerValue ==
                                                              list![index1]
                                                                  .answerA
                                                          ? list![index1]
                                                                      .answerValue ==
                                                                  list![index1]
                                                                      .correctAnsValue
                                                              ? AppColors
                                                                  .primary
                                                              : AppColors.red
                                                          : list![index1]
                                                                      .answerValue !=
                                                                  ""
                                                              ? list![index1]
                                                                          .correctAnsValue ==
                                                                      list![index1]
                                                                          .answerA
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .grey
                                                              : AppColors.grey),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 15),
                                                        child: Text(
                                                          "" +
                                                              list![index1]
                                                                  .answerA!,
                                                          style: TextStyle(
                                                              color: list![index1]
                                                                          .answerValue ==
                                                                      list![index1]
                                                                          .answerA
                                                                  ? list![index1]
                                                                              .answerValue ==
                                                                          list![index1]
                                                                              .correctAnsValue
                                                                      ? AppColors
                                                                          .white
                                                                      : AppColors
                                                                          .white
                                                                  : list![index1]
                                                                              .answerValue !=
                                                                          ""
                                                                      ? list![index1].correctAnsValue ==
                                                                              list![index1]
                                                                                  .answerA
                                                                          ? AppColors
                                                                              .white
                                                                          : AppColors
                                                                              .black
                                                                      : AppColors
                                                                          .black,
                                                              fontFamily:
                                                                  "reguler",
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
                                                  list![index1].id.toString(),
                                                  "B");
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: list![index1]
                                                            .answerValue ==
                                                        list![index1].answerB
                                                    ? list![index1]
                                                                .answerValue ==
                                                            list![index1]
                                                                .correctAnsValue
                                                        ? list![index1]
                                                                    .answerB ==
                                                                list![index1]
                                                                    .correctAnsValue
                                                            ? AppColors.primary
                                                            : AppColors.primary
                                                        : AppColors.red
                                                    : list![index1]
                                                                .answerValue !=
                                                            ""
                                                        ? list![index1]
                                                                    .correctAnsValue ==
                                                                list![index1]
                                                                    .answerB
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
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                    "" + list![index1].answerB!,
                                                    style: TextStyle(
                                                        color: list![index1]
                                                                    .answerValue ==
                                                                list![index1]
                                                                    .answerB
                                                            ? list![index1]
                                                                        .answerValue ==
                                                                    list![index1]
                                                                        .correctAnsValue
                                                                ? list![index1]
                                                                            .answerB ==
                                                                        list![index1]
                                                                            .correctAnsValue
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .white
                                                                : AppColors
                                                                    .white
                                                            : list![index1]
                                                                        .answerValue !=
                                                                    ""
                                                                ? list![index1]
                                                                            .correctAnsValue ==
                                                                        list![index1]
                                                                            .answerB
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black
                                                                : AppColors
                                                                    .black,
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
                                                  list![index1].id.toString(),
                                                  "C");
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: list![index1]
                                                            .answerValue ==
                                                        list![index1].answerC
                                                    ? list![index1]
                                                                .answerValue ==
                                                            list![index1]
                                                                .correctAnsValue
                                                        ? list![index1]
                                                                    .answerC ==
                                                                list![index1]
                                                                    .correctAnsValue
                                                            ? AppColors.primary
                                                            : AppColors.primary
                                                        : AppColors.red
                                                    : list![index1]
                                                                .answerValue !=
                                                            ""
                                                        ? list![index1]
                                                                    .correctAnsValue ==
                                                                list![index1]
                                                                    .answerC
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
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                    "" + list![index1].answerC!,
                                                    style: TextStyle(
                                                        color: list![index1]
                                                                    .answerValue ==
                                                                list![index1]
                                                                    .answerC
                                                            ? list![index1]
                                                                        .answerValue ==
                                                                    list![index1]
                                                                        .correctAnsValue
                                                                ? list![index1]
                                                                            .answerC ==
                                                                        list![index1]
                                                                            .correctAnsValue
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .white
                                                                : AppColors
                                                                    .white
                                                            : list![index1]
                                                                        .answerValue !=
                                                                    ""
                                                                ? list![index1]
                                                                            .correctAnsValue ==
                                                                        list![index1]
                                                                            .answerC
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black
                                                                : AppColors
                                                                    .black,
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
                                                  list![index1].id.toString(),
                                                  "D");
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: list![index1]
                                                            .answerValue ==
                                                        list![index1].answerD
                                                    ? list![index1]
                                                                .answerValue ==
                                                            list![index1]
                                                                .correctAnsValue
                                                        ? list![index1]
                                                                    .answerD ==
                                                                list![index1]
                                                                    .correctAnsValue
                                                            ? AppColors.primary
                                                            : AppColors.primary
                                                        : AppColors.red
                                                    : list![index1]
                                                                .answerValue !=
                                                            ""
                                                        ? list![index1]
                                                                    .correctAnsValue ==
                                                                list![index1]
                                                                    .answerD
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
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                    "" + list![index1].answerD!,
                                                    style: TextStyle(
                                                        color: list![index1]
                                                                    .answerValue ==
                                                                list![index1]
                                                                    .answerD
                                                            ? list![index1]
                                                                        .answerValue ==
                                                                    list![index1]
                                                                        .correctAnsValue
                                                                ? list![index1]
                                                                            .answerD ==
                                                                        list![index1]
                                                                            .correctAnsValue
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .white
                                                                : AppColors
                                                                    .white
                                                            : list![index1]
                                                                        .answerValue !=
                                                                    ""
                                                                ? list![index1]
                                                                            .correctAnsValue ==
                                                                        list![index1]
                                                                            .answerD
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black
                                                                : AppColors
                                                                    .black,
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
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void callAPI() async {
    print("CALL subject API");
    dynamic country = await getAllfeeddata(UserId);
    if (country['status']) {
      AllFeedModel subject = AllFeedModel.fromJson(country);
      setState(() {
        list = subject.data;
      });
      print(list.length);
      // print(list[0].videos!.length);
      // print(list[0].videos![0].type);
      //  print(list[0].videos![0].videoTital);
      print(list[0].videoTital);
    } else {
      setState(() {});
    }
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    // print("Ashish" + UserId);
    // print("Ashish tiken${usertoken}");
    await getAllfeeddata(UserId);
    callAPI();
  }

  Future<dynamic> getAllfeeddata(
    String userid,
  ) async {
    showLoader(context);
    print(ApiUrl.getfeedall + userid);
    try {
      final res = await http.get(Uri.parse(ApiUrl.getfeedall + userid),
          headers: {"Authorization": USERTOKKEN.toString()});
      if (res.statusCode == 200) {
        print(res.statusCode);
        var data = json.decode(res.body);
        print(data);
        hideLoader();
        print(data['status']);
        if (data['status']) {
          return data;
        } else {
          hideLoader();
          return Text("data");
        }
      } else {
        hideLoader();
        return {"status": false, "Message": "Some thing went wrong"};
      }
    } catch (_) {
      hideLoader();
      return {"status": false, "Message": "Exceptions occurred"};
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
        await getAllfeeddata(UserId);
        setState(() {});

        return true;
      }
      print(response.statusCode);
    } catch (e) {
      hideLoader();
      print("sdfok" + e.toString());
    }
  }
}
