import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/PollScreen.dart';

import 'package:businessgym/Screen/FeedScreen/NewsScreen.dart';
import 'package:businessgym/Screen/FeedScreen/QuizScreen.dart';


import 'package:businessgym/Screen/HomeScreen/JoinScreen.dart';


import 'package:businessgym/Screen/FeedScreen/VideosDetailsScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/GetVideosModel.dart';
import 'package:businessgym/model/ViewNewsModel.dart';
import 'package:businessgym/model/ViewpollsModel.dart';
import 'package:businessgym/model/ViewquizModel.dart';
import 'package:businessgym/model/all_videos_model.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:businessgym/Screen/FeedScreen/feedmain.dart';
import 'package:businessgym/Screen/FeedScreen/videoscreen.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TextEditingController search = TextEditingController();
  String selectedTop = "All";
  List<AllVideosModal> searchlist = [];
  final SharedPreference _sharedPreference = SharedPreference();
  List<ViewNewsModelData?>? viewnewsmodelData = [];
  List<ViewpollsModelData>? viewpollsModelData = [];
  List<ViewquizModelData>? viewquizModelData = [];
  List sendOption = ["A", "B", "C", "D", "E", "F", "G"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  textAreasearchfield(search, "Search"),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: topNavView("All", () {
                              setState(() {
                                selectedTop = "All";
                              });
                            }, selectedTop == "All" ? true : false),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Videos", () {
                              setState(() {
                                selectedTop = "Videos";
                              });
                            }, selectedTop == "Videos" ? true : false),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("News", () {
                              setState(() {
                                selectedTop = "News";
                              });
                            }, selectedTop == "News" ? true : false),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Poll", () {
                              setState(() {
                                selectedTop = "Poll";
                              });
                            }, selectedTop == "Poll" ? true : false),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Quiz", () {
                              setState(() {
                                selectedTop = "Quiz";
                              });
                            }, selectedTop == "Quiz" ? true : false),
                          )

                          // topNavView("All", () {
                          //   setState(() {
                          //     selectedTop = "All";
                          //   });
                          // }, selectedTop == "All" ? true : false),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(
                      top: 0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))),

                    // alignment: Alignment.center,
                    //height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 300),
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                             for (int index = 0; index < 1; index++)
                               if (selectedTop == "All")
                                 Container(child: FeedmainScreen()),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Videos")
                                  GestureDetector(
                                      child: Container(child: videoScreen())),
                              for (int index = 0;
                              index < 1;
                              index++)
                                if (selectedTop == "News")
                                  Container(
                                    child: NewsScreen(),
                                  ),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Poll")
                                  Container(child: PollScreen()),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Quiz")
                                  Container(
                                    child: QuizScreen(),
                                  )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

final SharedPreference _sharedPreference = SharedPreference();

Widget textAreasearchfield(TextEditingController controller, String hint,
    {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: TextField(
          onTap: () async {
            String becomeSuplier = await _sharedPreference.isLoggedIn();
            // Get.to(MyServicesScreensProvider(becomeSuplier));
          },
          minLines: hint.contains("Description") ? 5 : 1,
          maxLines: hint.contains("Description") ? 5 : 1,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(AppImages.search),
              ),
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: AppColors.grey,
              hintText: hint),
        ),
      ),
    ],
  );
}

Widget topNavView(String title, VoidCallback ontap, bool view) {
  return InkWell(
    onTap: ontap,
    child: Container(
        width: 50,
        height: 30,
        padding: const EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 5),
        decoration: BoxDecoration(
          color: view ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: view ? Colors.blue : Colors.transparent, width: 1),
        ),
        child: Center(
          child: regulartext(view ? Colors.white : Colors.black, 14, title),
        )),
  );
}
