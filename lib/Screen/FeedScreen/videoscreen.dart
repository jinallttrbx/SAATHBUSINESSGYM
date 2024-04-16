import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/ViewAllCategoryScreen.dart';
import 'package:businessgym/Screen/FeedScreen/VideosDetailsScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/all_videos_model.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../../model/GetVideosModel.dart';

class videoScreen extends StatefulWidget{
  State<videoScreen> createState() => _VideoScreenState();

}
class _VideoScreenState extends State<videoScreen> {
  List<Data>? data = [];
  List<Videos>? featuredVideos = [];
  List<Videos>? resentVideos = [];
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  final SharedPreference _sharedPreference = SharedPreference();
  @override
  void initState() {
    super.initState();
    getuserType();
  }

  Widget build(BuildContext context) {
    return
    ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data!.length,
        itemBuilder:
            (BuildContext context, int index) {
          return Column(
            mainAxisAlignment:
                MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 16,
                        top: 20,
                        bottom: 10,
                        right: 16),
                    child: boldtext(AppColors.black,
                        15, data![index].title!),
                  ),
                  const Spacer(),
                  textbutton(
                    "See all (${data![index].videos!.length})",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewAllCategoryScreen(
                            videos:
                                data![index].videos,
                            catname:
                                data![index].title!,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width,
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:
                      data![index].videos!.length,
                  itemBuilder: (BuildContext context,
                      int index1) {

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideosDetailsScreen(
                                  videos:  data![index].videos![index1],
                                ))).then((value) => setState(() {
                          getAllservice(UserId);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 16),
                        margin: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(
                                    16))),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      15)),
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius
                                    .circular(15),
                                child:
                                CachedNetworkImage(
                                  imageUrl: "" +
                                      data![index]
                                          .videos![
                                      index1]
                                          .image!,
                                  height: 140,
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width /
                                      1.5,
                                  fit: BoxFit.cover,
                                  placeholder: (context,
                                      string) =>
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                        child: Image.asset(
                                            'assets/images/icons/app_logo.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit
                                                .cover),
                                      ),
                                  errorWidget: (context,
                                      string,
                                      dynamic) =>
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                        child: Image.asset(
                                            'assets/images/icons/app_logo.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit
                                                .cover),
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
                                    .videoTital!.length>35?'${  data![index]
                                    .videos![index1]
                                    .videoTital!.substring(0,34)}...' : data![index]
                                    .videos![index1]
                                    .videoTital!),
                            regulartext(
                                AppColors.hint,
                                12,
                                data![index]
                                    .videos![index1]
                                    .videoDuration!),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [

                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppImages.like),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Text(data![index]
                                          .videos![index1]
                                          .totalLikes
                                          .toString()!),
                                    )

                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppImages
                                            .comment),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(data![index]
                                        .videos![index1]
                                        .totalComment
                                        .toString()!)
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppImages.time),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(data![index]
                                        .videos![index1]
                                        .videoDuration
                                        .toString()!)
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
        });
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