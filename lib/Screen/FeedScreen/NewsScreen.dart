import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:http/http.dart' as http;

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/ViewNewsModel.dart';
import '../../values/Colors.dart';
import 'NewsDetailsScreen.dart';
import 'Video_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();
  String? usertoken = "";
  String? usertype = "";
  // Future<List<ViewNewsModelData?>?>? viewnewsmodel;
  List<ViewNewsModelData?>? viewnewsmodelData = [];
  List<ViewNewsModelData?>? searchList = [];

  @override
  void initState() {
    getuserType();
    super.initState();
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId!);
    print("Ashish tiken$usertoken");
    //listData1=getcategotyData();
    News();
  }

  Future<List<ViewNewsModelData?>?>? News() async {
    try {
      print(ApiUrl.viewNews);
      showLoader(context);

      final response = await http.post(
        Uri.parse(ApiUrl.viewNews),
      );

      print("response data my news =================" + response.body);
      //  Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();

        ViewNewsModel? viewNewsModel =
        ViewNewsModel.fromJson(jsonDecode(response.body));
        viewnewsmodelData = viewNewsModel.data;
        setState(() {});

        print("Success");

        return viewNewsModel.data;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {
      print("data==1=$e");
    }
  }

  searchFromList(String value) async {
    searchList = [];
    if (value.isNotEmpty) {
      for (var element in viewnewsmodelData!) {
        if (element?.title.toLowerCase().contains(value.toLowerCase()) ??
            false) {
          searchList?.add(element);
        }
      }

      setState(() {});
    } else {
      searchList = [];
      setState(() {});
    }
  }

  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: textAreasearchfield(
            search,
            "Search",
                (value) {
              if (debounce?.isActive ?? false) debounce?.cancel();
              debounce = Timer(const Duration(milliseconds: 500), () {
                searchFromList(value);
              });
            },
          ),
        ),
        search.text.isNotEmpty
            ? searchList?.isEmpty ?? false
            ? const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Center(
                child: Text("No data found"),
              ),
            ),
          ],
        )
            : ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemCount: searchList!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(NewsDetailsScreen(
                  videos: searchList![index],
                ));
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12))),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(12),
                                child: Image.network(
                                  searchList![index]!.image,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchList![index]!.title,
                                    style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ).translate(),
                                  Text(
                                    searchList![index]!.createTime,
                                    style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffA6A6A6)),
                                  ).translate(),
                                  Text(
                                      searchList![index]!.urlLink.length >
                                          100
                                          ? searchList![index]!
                                          .urlLink
                                          .substring(0, 99)
                                          : searchList![index]!.urlLink).translate(),
                                ],
                              ))
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.hint.withOpacity(0.5),
                      )
                    ],
                  )),
            );
          },
        )
            : ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemCount: viewnewsmodelData!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(NewsDetailsScreen(
                  videos: viewnewsmodelData![index],
                ));
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12))),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  viewnewsmodelData![index]!.image,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    viewnewsmodelData![index]!.title,
                                    style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ).translate(),
                                  Text(
                                    viewnewsmodelData![index]!.createTime,
                                    style: const TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffA6A6A6)),
                                  ).translate(),
                                  Text(viewnewsmodelData![index]!
                                      .urlLink
                                      .length >
                                      100
                                      ? viewnewsmodelData![index]!
                                      .urlLink
                                      .substring(0, 99)
                                      : viewnewsmodelData![index]!.urlLink).translate(),
                                ],
                              ))
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.hint.withOpacity(0.5),
                      )
                    ],
                  )),
            );
          },
        )
      ],
    );
  }
}
