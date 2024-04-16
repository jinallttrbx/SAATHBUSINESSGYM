// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';


import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/model/getRatingModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/GetUserReviews.dart';
import '../../values/Colors.dart';
import '../../values/const_text.dart';
import '../../conts/global_values.dart';

class RatingandReviewByUserScreens extends StatefulWidget {
  String? user_id;
  bool? showOnly;
  bool? isProduct;
  String? serviceOrProductId;
  String? providerId;
  bool? isSupplier;
  RatingandReviewByUserScreens(
      {super.key,
      this.user_id,
      this.showOnly,
      this.providerId,
      this.isSupplier,
      this.serviceOrProductId,
      this.isProduct});
  @override
  RatingandReviewByUserScreensState createState() =>
      RatingandReviewByUserScreensState();
}

class RatingandReviewByUserScreensState
    extends State<RatingandReviewByUserScreens> {


  bool rating = false;
  String? UserId;
  String? usertype;
  String ratingcount="";
  SharedPreference _sharedPreference = SharedPreference();
  Future<GetratingClass?>? allservice1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid();

  }

  Future<void> userid() async {
    usertype = await _sharedPreference.isUserType();
    print("Ashish" + usertype!);
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);

    allservice1 = getratingreview();
  }

  Future<GetratingClass?> getratingreview() async {
    showLoader(context);
    try {
      var headers = {'Authorization': USERTOKKEN!};
      final response =  await http.post(Uri.parse(
          ApiUrl.ratingreview),
          headers: headers);
      print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        GetratingClass? allServiceModel =
        GetratingClass.fromJson(jsonDecode(response.body));

        setState(() {});
        return allServiceModel;

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
      appBar: APPBar(title: "Rating And Review"),
      backgroundColor: AppColors.BGColor,
      body:FutureBuilder<GetratingClass?>(
          future: allservice1,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(16))
                                  ),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              boldtext(AppColors.black,18,'Rating',
                                              ),
                                              regulartext(Colors.black,14,"From ${snapshot.data!.avgStar!} Ratings", )
                                            ],
                                          ),),
                                          Expanded(child: InkWell(

                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                RatingBarIndicator(
                                                  direction: Axis
                                                      .horizontal,
                                                  rating: double
                                                      .parse(
                                                      "${snapshot.data!.avgStar}"),
                                                  itemCount: 5,
                                                  itemSize: 14,
                                                  itemPadding:
                                                  const EdgeInsets
                                                      .all(2),
                                                  unratedColor:
                                                  Colors.grey,
                                                  itemBuilder:
                                                      (context,
                                                      _) =>
                                                      SvgPicture.asset(AppImages.rating),
                                                ),

                                                boldtext(Colors.black, 12,
                                                    '${snapshot.data!.avgStar}/5')
                                              ],
                                            ),
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Divider(height: 1,thickness: 1,color: Color(0xffEEEEEE),),
                                      SizedBox(height: 10,),
                                      boldtext(AppColors.black,14,"${snapshot.data!.totalReview} Reviews",  )

                                    ],
                                  )
                              ),
                              SizedBox(height: 16,),
                              Padding(padding: EdgeInsets.only(left: 18),child: regulartext(Color(0xff656565),14,"All Reviews and Ratings",
                              ),),
                              SizedBox(height: 12,),
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data.length,
                                    itemBuilder: (context,index){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  boldtext(AppColors.black,16,snapshot.data!.data![index].customerName),
                                                  SizedBox(height: 5,),
                                                  InkWell(

                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        RatingBarIndicator(
                                                          direction: Axis
                                                              .horizontal,
                                                          rating: double
                                                              .parse(
                                                              "${snapshot.data!.data[index].rating}"),
                                                          itemCount: 5,
                                                          itemSize: 14,
                                                          itemPadding:
                                                          const EdgeInsets
                                                              .all(2),
                                                          unratedColor:
                                                          Colors.grey,
                                                          itemBuilder:
                                                              (context,
                                                              _) =>
                                                              SvgPicture.asset(AppImages.rating),
                                                        ),

                                                        boldtext(Colors.black, 12,
                                                          '${snapshot.data!.data![index].rating} Rating',)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),),
                                              regulartext(AppColors.hint,12,"${DateFormat("dd-MM-yyyy").format(snapshot.data!.data![index].createdAt)}",),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          regulartext(AppColors.black,12,"${snapshot.data!.data![index].review}",),
                                          SizedBox(height: 10,),
                                          Divider(height: 1,thickness: 1,color: Color(0xffEEEEEE),),
                                          SizedBox(height: 10,),
                                        ],
                                      );
                                    }),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
                child: SizedBox()
            );
          }),

    );
  }
}

