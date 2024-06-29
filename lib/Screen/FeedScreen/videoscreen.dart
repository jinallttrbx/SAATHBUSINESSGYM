import 'dart:async';
import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/VideosDetailsScreen.dart';
import 'package:businessgym/Screen/FeedScreen/ViewAllCategoryScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/all_videos_model.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../model/GetVideosModel.dart';
import 'Video_screen.dart';

class videoScreen extends StatefulWidget {
  State<videoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<videoScreen> {
  List<Data>? data = [];
  List<Videos>? featuredVideos = [];
  List<Videos>? resentVideos = [];
  List<Data> searchList = [];
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  final SharedPreference _sharedPreference = SharedPreference();
  @override
  void initState() {
    super.initState();
    getuserType();
  }

  searchFromList(String value) async {
    searchList = [];
    if (value.isNotEmpty) {
      for (var element in data!) {
        if (element.title?.toLowerCase().contains(value.toLowerCase()) ??
            false) {
          searchList.add(element);
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
            ? searchList.isEmpty
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16, top: 20, bottom: 10, right: 16),
                      child: boldtext(AppColors.black, 15,
                          searchList[index].title!),
                    ),
                    const Spacer(),
                    textbutton(
                      "See all (${searchList[index].videos!.length})",
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewAllCategoryScreen(
                                  videos: searchList[index].videos,
                                  catname: searchList[index].title!,
                                ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchList[index].videos!.length,
                    itemBuilder: (BuildContext context, int index1) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideosDetailsScreen(
                                        videos: searchList[index]
                                            .videos![index1],
                                      ))).then(
                                (value) => setState(
                                  () {
                                getAllservice(UserId);
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 16),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: searchList[index]
                                        .videos![index1]
                                        .image!,
                                    height: 140,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        1.5,
                                    fit: BoxFit.cover,
                                    placeholder: (context, string) =>
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image.asset(
                                              'assets/images/icons/app_logo.png',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover),
                                        ),
                                    errorWidget:
                                        (context, string, dynamic) =>
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image.asset(
                                              'assets/images/icons/app_logo.png',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover),
                                        ),
                                  ),
                                  // Image.network(
                                  //   "" + widget.videos![index1].image!,
                                  //   width: 100,
                                  //   height: 100,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                              boldtext(
                                  Colors.black,
                                  14,
                                  searchList[index]
                                      .videos![index1]
                                      .videoTital!
                                      .length >
                                      35
                                      ? '${searchList[index].videos![index1].videoTital!.substring(0, 34)}...'
                                      : searchList[index]
                                      .videos![index1]
                                      .videoTital!),
                              regulartext(
                                  AppColors.hint,
                                  12,
                                  searchList[index]
                                      .videos![index1]
                                      .videoDuration!),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.like),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(searchList[index]
                                            .videos![index1]
                                            .totalLikes
                                            .toString()),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.comment),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(searchList[index]
                                          .videos![index1]
                                          .totalComment
                                          .toString())
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.time),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(searchList[index]
                                          .videos![index1]
                                          .videoDuration
                                          .toString())
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        )
            : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, top: 20, bottom: 10, right: 16),
                        child: boldtext(
                            AppColors.black, 15, data![index].title!),
                      ),
                      const Spacer(),
                      textbutton(
                        "See all (${data![index].videos!.length})",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllCategoryScreen(
                                videos: data![index].videos,
                                catname: data![index].title!,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data![index].videos!.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VideosDetailsScreen(
                                          videos:
                                          data![index].videos![index1],
                                        ))).then((value) => setState(() {
                              getAllservice(UserId);
                            }));
                          },
                          child: Container(
                            padding:
                            const EdgeInsets.only(left: 20, right: 16),
                            margin:
                            const EdgeInsets.only(left: 10, right: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: data![index]
                                          .videos![index1]
                                          .image!,
                                      height: 140,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1.5,
                                      fit: BoxFit.cover,
                                      placeholder: (context, string) =>
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.asset(
                                                'assets/images/icons/app_logo.png',
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover),
                                          ),
                                      errorWidget:
                                          (context, string, dynamic) =>
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.asset(
                                                'assets/images/icons/app_logo.png',
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover),
                                          ),
                                    ),
                                    // Image.network(
                                    //   "" + widget.videos![index1].image!,
                                    //   width: 100,
                                    //   height: 100,
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                ),
                                boldtext(
                                    Colors.black,
                                    14,
                                    data![index]
                                        .videos![index1]
                                        .videoTital!
                                        .length >
                                        35
                                        ? '${data![index].videos![index1].videoTital!.substring(0, 34)}...'
                                        : data![index]
                                        .videos![index1]
                                        .videoTital!),
                                regulartext(
                                    AppColors.hint,
                                    12,
                                    data![index]
                                        .videos![index1]
                                        .videoDuration!),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.like),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(data![index]
                                              .videos![index1]
                                              .totalLikes
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.comment),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(data![index]
                                            .videos![index1]
                                            .totalComment
                                            .toString())
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.time),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(data![index]
                                            .videos![index1]
                                            .videoDuration
                                            .toString())
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }),
      ],
    );
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    // print("Ashish" + UserId);
    // print("Ashish tiken${usertoken}");
    getAllservice(UserId);
  }

  Future<GetVideosModel?> getAllservice(String user_id) async {
    data = [];
    featuredVideos = [];
    resentVideos = [];
    all_videoList = [];
    try {
      showLoader(context);
      final response = await http
          .post(Uri.parse(ApiUrl.getVideos), body: {"user_id": user_id});

      Map<String, dynamic> map = json.decode(response.body);

      for (var i = 0; i < map['data'].length; i++) {
        if (map['data'][i]['videos'].length > 0) {
          for (var j = 0; j < map['data'][i]['videos'].length; j++) {
            all_videoList.add(AllVideosModal(
              title: map['data'][i]['videos'][j]["video_tital"],
              imgUrl: map['data'][i]['videos'][j]["image"],
              videoUrl: map['data'][i]['videos'][j]["youtube_url"],
              description: map['data'][i]['videos'][j]
              ["video_short_description"],
            ));
          }
        }
      }

      if (response.statusCode == 200) {
        hideLoader();
        GetVideosModel? allServiceModel =
        GetVideosModel.fromJson(jsonDecode(response.body));
        data = allServiceModel.data;
        print('featured video');
        print(response.body);
        print(allServiceModel.featuredVideos?.length);
        featuredVideos = allServiceModel.featuredVideos;
        resentVideos = allServiceModel.resentVideos;
        // pendingvideo = allServiceModel.pendingVideo;
        setState(() {});

        return allServiceModel;
      } else {
        print("Something went worange");
      }
    } catch (e) {
      print("data===$e");
    }
  }

  Widget textbutton(text, VoidCallback ontap) {
    return TextButton(
        onPressed: ontap, child: boldtext(AppColors.primary, 15, text));
  }
}
