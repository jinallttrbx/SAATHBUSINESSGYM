import 'dart:convert';


import 'package:businessgym/Screen/FeedScreen/VideosDetailsScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/model/GetVideosModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;



class ViewAllCategoryScreen extends StatefulWidget {
  String? catname;
  List<Videos>? videos;
  ViewAllCategoryScreen({Key? key, this.videos, this.catname})
      : super(key: key);

  @override
  State<ViewAllCategoryScreen> createState() => _ViewAllCategoryScreenState();
}

class _ViewAllCategoryScreenState extends State<ViewAllCategoryScreen> {
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  int? pendingvideo = 0;
  SharedPreference _sharedPreference = new SharedPreference();
  @override
  void initState() {
    super.initState();
    getuserType();
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId);
    print("Ashish tiken${usertoken}");
    // getAllservice(""+UserId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: APPBar(title: widget.catname!),
      body:Container(
        margin: EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(padding: EdgeInsets.only(left: 16,top: 10),child:  boldtext(AppColors.black, 16,"All videos",),),
            Expanded(child: ListView.builder(
              //  shrinkWrap: true,
              //  physics: NeverScrollableScrollPhysics(),

                itemCount: widget.videos!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index1) {
                  return InkWell(
                    onTap: () {
                      getViewVideo(UserId, widget.videos![index1].vid!.toString(),
                          widget.videos![index1]);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>VideosDetailsScreen(videos: data![index].videos![index1],)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),

                          height: 300,
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.only(top: 10, left: 6, right: 6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    height: 200,
                                    imageUrl: "" + widget.videos![index1].image!,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, string) => ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                          'assets/images/icons/app_logo.png',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    ),
                                    errorWidget: (context, string, dynamic) =>
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 10,left: 16),
                                      // width: 110,
                                      child: boldtext(AppColors.black, 14,
                                        "" + widget.videos![index1].videoTital!,
                                        fontFamily: "bold",
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 0,left: 16),
                                      // width: 110,
                                      child: boldtext(AppColors.hint, 12,
                                        widget.catname! +  "4h",
                                        fontFamily: "bold",
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10,left: 16),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImages.like),
                                            SizedBox(width: 5,),
                                            Text(widget.videos![index1].totalLikes.toString()!)
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImages.comment),
                                            SizedBox(width: 5,),
                                            Text(widget.videos![index1].totalComment.toString()!)
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImages.time),
                                            SizedBox(width: 5,),
                                            Text( widget.videos![index1].videoDuration.toString()!)
                                          ],
                                        )



                                      ],

                                    ),
                                  )

                                ],
                              ),


                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  );
                }),)

          ],
        ),
      )
    ));
  }

  Future<bool?> getViewVideo(
      String user_id, String video_id, Videos? videos) async {
    try {
      showLoader(context);
      final response = await http.post(Uri.parse(ApiUrl.viewVideo),
          body: {"user_id": user_id, "video_id": video_id});

      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        print("Success");
        hideLoader();
        print("Success" + response.body.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideosDetailsScreen(
                      videos: videos,
                    )));


        setState(() {});

        return true;
      } else {
        print("Something went worange");
      }
    } catch (e) {
      print("data===$e");
    }
  }
}
