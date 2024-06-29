// // ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print
//
// import 'dart:convert';
//
//
// import 'package:businessgym/conts/appbar_global.dart';
// import 'package:businessgym/model/getRatingModel.dart';
// import 'package:businessgym/values/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// import '../../Utils/ApiUrl.dart';
// import '../../Utils/SharedPreferences.dart';
// import '../../Utils/common_route.dart';
// import '../../model/GetUserReviews.dart';
// import '../../values/Colors.dart';
// import '../../values/const_text.dart';
// import '../../conts/global_values.dart';
//
// class RatingandReviewByUserScreens extends StatefulWidget {
//   String? user_id;
//   bool? showOnly;
//   bool? isProduct;
//   String? serviceOrProductId;
//   String? providerId;
//   bool? isSupplier;
//   RatingandReviewByUserScreens(
//       {super.key,
//       this.user_id,
//       this.showOnly,
//       this.providerId,
//       this.isSupplier,
//       this.serviceOrProductId,
//       this.isProduct});
//   @override
//   RatingandReviewByUserScreensState createState() =>
//       RatingandReviewByUserScreensState();
// }
//
// class RatingandReviewByUserScreensState
//     extends State<RatingandReviewByUserScreens> {
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//
//   bool rating = false;
//   String? UserId;
//   String? usertype;
//   String ratingcount="";
//   SharedPreference _sharedPreference = SharedPreference();
//   Future<GetratingClass?>? allservice1;
//   List<GetratingClassdata>? ratingdata = [];
//   double avgrating=0.0;
//   int totalReview=0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     userid();
//
//   }
//
//   Future<void> userid() async {
//     usertype = await _sharedPreference.isUserType();
//     print("Ashish" + usertype!);
//     UserId = await _sharedPreference.isUsetId();
//     print("Ashish" + UserId!);
//      getratingreview();
//   }
//
//   Future<List<GetratingClassdata?>?>? getratingreview() async {
//     try {
//       print(ApiUrl.ratingreview);
//       showLoader(context);
//       final response = await http.post(
//         Uri.parse(ApiUrl.ratingreview),
//         body: {
//         },
//         headers: {"Authorization": USERTOKKEN.toString()},
//       );
//       print("response data my news ================="+response.body);
//       print("response data my news ================="+response.statusCode.toString());
//       //  Map<String, dynamic> map = json.decode(response.body);
//       if (response.statusCode == 200) {
//         hideLoader();
//         GetratingClass? viewNewsModel = GetratingClass.fromJson(jsonDecode(response.body));
//         ratingdata = viewNewsModel.data!;
//         avgrating=viewNewsModel.avgStar;
//         totalReview=viewNewsModel.totalReview;
//
//         setState(() {
//         });
//
//         print("Success");
//         return viewNewsModel.data;
//       } else {
//         hideLoader();
//         print("Something went wronge");
//       }
//     } catch (e) {
//
//       print("data==1=$e");
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldkey,
//       appBar: APPBar(title: "Rating And Review"),
//       backgroundColor: AppColors.BGColor,
//       body:Container(
//         margin: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
//                 decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.all(Radius.circular(16))
//                 ),
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             boldtext(AppColors.black,18,'Rating',
//                             ),
//                             regulartext(Colors.black,14,"From ${avgrating} Ratings", )
//                           ],
//                         ),),
//                         Expanded(child: InkWell(
//
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment:
//                             MainAxisAlignment.end,
//                             children: [
//                               RatingBarIndicator(
//                                 direction: Axis
//                                     .horizontal,
//                                 rating: double
//                                     .parse(
//                                     "${avgrating}"),
//                                 itemCount: 5,
//                                 itemSize: 14,
//                                 itemPadding:
//                                 const EdgeInsets
//                                     .all(2),
//                                 unratedColor:
//                                 Colors.grey,
//                                 itemBuilder:
//                                     (context,
//                                     _) =>
//                                     SvgPicture.asset(AppImages.rating),
//                               ),
//
//                               boldtext(Colors.black, 12,
//                                   '${avgrating}/5')
//                             ],
//                           ),
//                         ),)
//                       ],
//                     ),
//                     SizedBox(height: 10,),
//                     Divider(height: 1,thickness: 1,color: Color(0xffEEEEEE),),
//                     SizedBox(height: 10,),
//                     boldtext(AppColors.black,14,"${totalReview} Reviews",  )
//                   ],
//                 )
//             ),
//             SizedBox(height: 20,),
//             Padding(padding: EdgeInsets.only(left: 18),child: regulartext(Color(0xff656565),14,"All Reviews and Ratings",
//             ),),
//            SizedBox(height: 20,),
//          Expanded(child:  Container(
//            decoration: BoxDecoration(
//                color: AppColors.primaryColor,
//                borderRadius: BorderRadius.all(Radius.circular(16))
//            ),
//            child:  Expanded(child:  ratingdata!.isEmpty?Center(child: Text("No Any One Given Rating"),):Container(child: ListView.builder(
//                shrinkWrap: true,
//                physics: BouncingScrollPhysics(),
//                itemCount: ratingdata!.length,
//                itemBuilder: (context,index){
//                  return Container(
//                    margin: EdgeInsets.only(left: 20,right: 20,top: 20),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Row(
//                          children: [
//                            Expanded(child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                boldtext(AppColors.black,16,ratingdata![index].customerName),
//                                SizedBox(height: 5,),
//                                InkWell(
//
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    mainAxisAlignment:
//                                    MainAxisAlignment.start,
//                                    children: [
//                                      RatingBarIndicator(
//                                        direction: Axis
//                                            .horizontal,
//                                        rating: double
//                                            .parse(
//                                            "${ratingdata![index].rating}"),
//                                        itemCount: 5,
//                                        itemSize: 14,
//                                        itemPadding:
//                                        const EdgeInsets
//                                            .all(2),
//                                        unratedColor:
//                                        Colors.grey,
//                                        itemBuilder:
//                                            (context,
//                                            _) =>
//                                            SvgPicture.asset(AppImages.rating),
//                                      ),
//
//                                      boldtext(Colors.black, 12,
//                                        '${ratingdata![index].rating} Rating',)
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),),
//                            regulartext(AppColors.hint,12,"${DateFormat("dd-MM-yyyy").format(ratingdata![index].createdAt)}",),
//                          ],
//                        ),
//                        SizedBox(height: 10,),
//                        regulartext(AppColors.black,12,"${ratingdata![index].review}",),
//                        SizedBox(height: 10,),
//                        Divider(height: 1,thickness: 1,color: Color(0xffEEEEEE),),
//                        SizedBox(height: 10,),
//                      ],
//                    ),
//                  );
//                }),)),
//          ))
//           ],
//         ),
//       )
//
//     );
//   }
// }
//
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
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  bool rating = false;
  String? UserId;
  String? usertype;
  String ratingcount = "";
  SharedPreference _sharedPreference = SharedPreference();
  Future<GetratingClass?>? allservice1;
  List<GetratingClassdata>? ratingdata = [];
  double avgrating = 0.0;
  int totalReview = 0;

  @override
  void initState() {
    super.initState();
    userid();
  }

  Future<void> userid() async {
    usertype = await _sharedPreference.isUserType();
    print("Ashish" + usertype!);
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    getratingreview();
  }

  Future<List<GetratingClassdata?>?>? getratingreview() async {
    try {
      print(ApiUrl.ratingreview);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.ratingreview),
        body: {},
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news =================" + response.body);
      print("response data my news =================" +
          response.statusCode.toString());
      if (response.statusCode == 200) {
        hideLoader();
        GetratingClass? viewNewsModel =
        GetratingClass.fromJson(jsonDecode(response.body));
        ratingdata = viewNewsModel.data!;
        avgrating = viewNewsModel.avgStar;
        totalReview = viewNewsModel.totalReview;

        setState(() {});

        print("Success");
        return viewNewsModel.data;
      } else {
        hideLoader();
        print("Something went wrong");
      }
    } catch (e) {
      print("data==1=$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: APPBar(title: "Rating And Review"),
        backgroundColor: AppColors.BGColor,
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldtext(AppColors.black, 18, 'Rating'),
                              regulartext(Colors.black, 14,
                                  "From $avgrating Ratings"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              direction: Axis.horizontal,
                              rating: avgrating,
                              itemCount: 5,
                              itemSize: 14,
                              itemPadding: const EdgeInsets.all(2),
                              unratedColor: Colors.grey,
                              itemBuilder: (context, _) =>
                                  SvgPicture.asset(AppImages.rating),
                            ),
                            boldtext(Colors.black, 12, '$avgrating/5'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 1, thickness: 1, color: Color(0xffEEEEEE)),
                    SizedBox(height: 10),
                    boldtext(AppColors.black, 14, "$totalReview Reviews")
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: regulartext(
                  Color(0xff656565),
                  14,
                  "All Reviews and Ratings",
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: ratingdata!.isEmpty
                      ? Center(child: Text("No Any One Given Rating"))
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: ratingdata!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      boldtext(AppColors.black, 16,
                                          ratingdata![index].customerName),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            direction: Axis.horizontal,
                                            rating: double.parse(
                                                "${ratingdata![index].rating}"),
                                            itemCount: 5,
                                            itemSize: 14,
                                            itemPadding:
                                            const EdgeInsets.all(2),
                                            unratedColor: Colors.grey,
                                            itemBuilder: (context, _) =>
                                                SvgPicture.asset(
                                                    AppImages.rating),
                                          ),
                                          boldtext(Colors.black, 12,
                                              '${ratingdata![index].rating} Rating'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                regulartext(AppColors.hint, 12,
                                    "${DateFormat("dd-MM-yyyy").format(ratingdata![index].createdAt)}"),
                              ],
                            ),
                            SizedBox(height: 10),
                            regulartext(AppColors.black, 12,
                                "${ratingdata![index].review}"),
                            SizedBox(height: 10),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
