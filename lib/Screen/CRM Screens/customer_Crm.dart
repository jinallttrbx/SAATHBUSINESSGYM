// ignore_for_file: must_be_immutable

import 'dart:convert';


import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/Screen/HomeScreen/MyServicesScreensProvider.dart';
import 'package:businessgym/Screen/ProfileScreen/feedbackScreen.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/GetHomeModel.dart';
import 'package:businessgym/model/MyservicesrequestModel.dart';
import 'package:businessgym/model/getClientModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/model/getviewProfile.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CustomerCRMScreen extends StatefulWidget {
  bool? appbar;
  CustomerCRMScreen({super.key, this.appbar});

  @override
  State<CustomerCRMScreen> createState() => _CustomerCRMScreensState();
}

class _CustomerCRMScreensState extends State<CustomerCRMScreen> {
  String selectedTop = "Viewed profile";
  SharedPreference _sharedPreference = SharedPreference();
  List<LeadDataModeldata>? uniqueList = [];
  String UserId = "";
  String? usertype;
  var now = DateTime.now();
  // Future<List<ViewprofileModeldata?>?>? viewprofilelist;
  // List<ViewprofileModeldata>? viewprofiledata = [];
//  Future<List<LeadDataModeldata?>?>? leadlist;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List<LeadDataModeldata>? leaddata = [];
  List<ViewprofileModeldata>? viewprofiledata = [];
  // Future<List<GetClientModeldata?>?>? clientlist;
  List<GetClientModeldata>? clientdata = [];
  // Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  // Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
    userid();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldkey,
            backgroundColor: AppColors.BGColor,
            appBar: APPBar(title: 'History'),

            body: leaddata!.isEmpty?Center(child: Text("History Not Found"),):ListView.builder(
              itemCount: leaddata!.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return    leaddata![index].userId.toString()==UserId?

              GestureDetector(
                onTap: () {
                  CommonBottomSheet.show(context,leaddata![index].providerId.toString(),leaddata![index].id.toString(),"service","");
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    leaddata![index]
                                        .recieverImage
                                        .toString()),
                              ),
                              Positioned(
                                left: 40,
                                top: 40,
                                child:
                                leaddata![index].myBooking ==
                                    1
                                    ? SvgPicture.asset(
                                    AppImages.roundright)
                                    : SvgPicture.asset(
                                    AppImages.roundleft),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                boldtext(
                                    AppColors.black,
                                    14,
                                    leaddata![index]
                                        .receiverName!
                                ),
                                Row(
                                  children: [
                                    Expanded(flex: 1,child:  regulartext(
                                      const Color(0xff656565),
                                      12,
                                      leaddata![index]
                                          .name
                                          .toString(),
                                    ),),
                                    Expanded(flex: 1,
                                        child:  Container(
                                            height: 18,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: leaddata![
                                                index]
                                                    .receiverTag !=
                                                    "supplier"
                                                    ? const Color(
                                                    0xffF2FFF7)
                                                    : const Color(
                                                    0xffF1FAFF),
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                    Radius
                                                        .circular(
                                                        9))),
                                            child: Center(
                                              child: regulartext(
                                                  leaddata![index]
                                                      .receiverTag !=
                                                      "supplier"
                                                      ? const Color(
                                                      0xff1B9346)
                                                      : const Color(
                                                      0xff1D84C7),
                                                  10,
                                                  leaddata![index]
                                                      .receiverTag ==
                                                      "supplier"
                                                      ? "Supplier"
                                                      : "ME"),
                                            ))),
                                    Expanded(flex: 1,child: SizedBox(width: 10,))
                                  ],
                                ),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                        direction:
                                        Axis.horizontal,
                                        rating: leaddata![index].rating??0.0.toDouble(),
                                        itemCount: 5,
                                        itemSize: 14,
                                        itemPadding:
                                        const EdgeInsets.all(
                                            2),
                                        unratedColor: Colors.grey,
                                        itemBuilder: (context,
                                            _) =>
                                            SvgPicture.asset(
                                                AppImages.rating),
                                      ),
                                      boldtext(
                                          const Color(0xff656565),
                                          12,
                                          '    ${leaddata![index].rating==null?0.0:leaddata![index].rating} Rating')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(AppImages.altarroe)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(
                                    0xffF5F5F5)),
                            onPressed: () {

                              // leaddata![index].rating==0.0?
                              ratenow(leaddata![index].type!,leaddata![index].typeId.toString(),leaddata![index].id.toString(),leaddata![index].userId.toString(),leaddata![index].rating==null?0.0:leaddata![index].rating!.toDouble(),leaddata![index].review==null?"Description":leaddata![index].review!,"recevier",leaddata![index].callLogRatingsId.toString(),context);
                              //:
                              // ratenow1(leaddata![index].type!,leaddata![index].typeId.toString(),leaddata![index].id.toString(),leaddata![index].userId.toString(),leaddata![index].callLogRatingsId.toString(),"recevier",context);
                            },
                            child: boldtext(
                              AppColors.black,
                              12,
                              leaddata![index].rating==0.0? "Rate Now":"Edit Rating",
                            )),
                      ),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                ),
              ):
              GestureDetector(
                onTap: () {
                  CommonBottomSheet.show(context,leaddata![index].userId.toString(),leaddata![index].id.toString(),"service","");
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    leaddata![index]
                                        .senderImage
                                        .toString()),
                              ),
                              Positioned(
                                left: 40,
                                top: 40,
                                child:
                                leaddata![index].myBooking ==
                                    1
                                    ? SvgPicture.asset(
                                    AppImages.roundright)
                                    : SvgPicture.asset(
                                    AppImages.roundleft),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(child: Container(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                boldtext(Colors.black,16,
                                  leaddata![index].senderName==null?"-":leaddata![index].senderName!,

                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child:  regulartext(Colors.black,13,
                                        leaddata![index].name==null?"-":leaddata![index].name!,
                                      ),),

                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                          decoration: BoxDecoration(
                                              color: leaddata![index].senderTag!="Supplier"?AppColors.primary.withOpacity(0.05):AppColors.LightGreens,
                                              borderRadius: BorderRadius.all(Radius.circular(9))
                                          ),
                                          child:  leaddata![index].senderTag!="Supplier"?boldtext(AppColors.Green,10,
                                            "ME",
                                          ):boldtext(AppColors.primary,10,
                                            "Supplier",
                                          )
                                      ),),
                                    Expanded(
                                        child: SizedBox.shrink())
                                  ],
                                ),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                        direction:
                                        Axis.horizontal,
                                        rating: leaddata![index].rating==null?0:leaddata![index].rating!.toDouble()!,
                                        itemCount: 5,
                                        itemSize: 14,
                                        itemPadding:
                                        const EdgeInsets.all(
                                            2),
                                        unratedColor: Colors.grey,
                                        itemBuilder: (context,
                                            _) =>
                                            SvgPicture.asset(
                                                AppImages.rating),
                                      ),
                                      boldtext(const Color(0xff656565),
                                          12, '    ${leaddata![index].rating==null?0:leaddata![index].rating} Rating')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                          SvgPicture.asset(AppImages.altarroe)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:   ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(
                                  0xffF5F5F5)),
                          onPressed: () {
                            ratenow(leaddata![index].type!,leaddata![index].typeId.toString(),leaddata![index].id.toString(),leaddata![index].userId.toString(),leaddata![index].rating==null?0.0:leaddata![index].rating!.toDouble(),leaddata![index].review==null?"Description":leaddata![index].review!, "sender",leaddata![index].callLogRatingsId.toString(),context);
                          },
                          child: boldtext(
                            AppColors.black,
                            12,
                            leaddata![index].rating==0.0?"Rate Now":"Edit Rating",
                          )),
                    ),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                ),
              );
            })));
  }



  ratenow(String type,String typeid,String calllogid,String userid,double rating,String review,String typeuser,String calllogratingid, BuildContext context,) async {
    TextEditingController description = TextEditingController();
    setState(() {
      description.text=review;
    });
    double addrating =4;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close_rounded),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(subMenu.image),
                      const SizedBox(
                        width: 10,
                      ),
                      boldtext(AppColors.black, 18, "Rating and review"),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              SvgPicture.asset(AppImages.rating),
                          onRatingUpdate: (rating) {
                            setState(() {
                              addrating=rating;
                            });
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textAreamo(description, "Description"),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () async{

                          typeuser!="receiver"?print("user receiver"):print("user sender");
                          if(typeuser!="receiver"){
                            print(typeuser);
                            print(ApiUrl.addleadrating);

                            final response = await http.post(
                                Uri.parse(ApiUrl.addleadrating),
                                headers: {"Authorization": "$USERTOKKEN"},
                                body:
                                // rating==0.0?
                                {
                                  "id": calllogid,
                                  "type": type,
                                  "type_id": typeid,
                                  "call_log_id": calllogid,
                                  "rating": addrating.toString(),
                                  "review": description.text,
                                  "user_id":userid
                                }
                              //:
                              // {
                              //   "id":"33",
                              //   "type": type,
                              //   "type_id": typeid,
                              //   "call_log_id": calllogid,
                              //   "rating": addrating.toString(),
                              //   "review": description.text,
                              //   "user_id":userid
                              // },
                            );
                            print("${type}${typeid}${calllogid}${addrating}${description.text}${userid}");


                            print(response.body);
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                content: Text(
                                    "Rating Add Successfully"),
                              ));
                              Navigator.of(context).pop();
                              getlead();
                              getclient();
                              //  alltransactionmodel = myfinancelist(userid!);
                              if (kDebugMode) {
                                print(response.statusCode);

                              }
                            } else {
                              if (kDebugMode) {
                                print("object");
                                Navigator.pop(context);
                              }
                            }
                          }else{
                            print(typeuser);
                            print(ApiUrl.adduserrating);
                            final response = await http.post(
                              Uri.parse(ApiUrl.adduserrating),
                              headers: {"Authorization": "$USERTOKKEN"},
                              body: {
                                "id":calllogid,
                                "type": type,
                                "type_id": typeid,
                                "call_log_id": calllogid,
                                "rating": addrating.toString(),
                                "review": description.text,
                                "user_id":userid
                              },
                            );
                            print("${type}${typeid}${calllogid}${addrating}${description.text}${userid}");
                            print(response.body);
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                content: Text(
                                    "Rating Add Successfully"),
                              ));
                              Navigator.of(context).pop();
                              getlead();
                              getclient();
                              //  alltransactionmodel = myfinancelist(userid!);
                              if (kDebugMode) {
                                print(response.statusCode);

                              }
                            } else {
                              if (kDebugMode) {
                                print("object");
                                Navigator.pop(context);
                              }
                            }
                          }

                        },
                        child: boldtext(AppColors.white, 14, rating==0.0?"Rate Now":"Update"),
                      ),
                    ),
                  ),
                ],
              ),),
          );
        });
  }
  // ratenow1(String type,String typeid,String calllogid,String userid,String typeuser,String callratinid, BuildContext context,) async {
  //   TextEditingController description = TextEditingController();
  //   double addrating =4;
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //           ),
  //           insetPadding: const EdgeInsets.only(left: 10, right: 10),
  //           iconPadding: EdgeInsets.zero,
  //           content: Container(
  //               height: MediaQuery.of(context).size.height / 2.2,
  //               width: MediaQuery.of(context).size.width,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Icon(Icons.close_rounded),
  //                       )
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       // SvgPicture.asset(subMenu.image),
  //                       const SizedBox(
  //                         width: 10,
  //                       ),
  //                       boldtext(AppColors.black, 18, "Rating and review"),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     width: 25,
  //                   ),
  //                   InkWell(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         RatingBar.builder(
  //                           initialRating: 3,
  //                           minRating: 1,
  //                           direction: Axis.horizontal,
  //                           allowHalfRating: true,
  //                           itemCount: 5,
  //                           itemPadding:
  //                           const EdgeInsets.symmetric(horizontal: 4.0),
  //                           itemBuilder: (context, _) =>
  //                               SvgPicture.asset(AppImages.rating),
  //                           onRatingUpdate: (rating) {
  //                             setState(() {
  //                               addrating=rating;
  //                             });
  //                             print(rating);
  //                           },
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 30,
  //                   ),
  //                   textAreamo(description, "Description"),
  //                   const SizedBox(
  //                     height: 25,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 0, vertical: 0),
  //                     child: SizedBox(
  //                       height: 50,
  //                       width: double.infinity,
  //                       child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12.0),
  //                           ),
  //                           backgroundColor: AppColors.primary,
  //                         ),
  //                         onPressed: () async{
  //
  //                           typeuser=="receiver"?print("user receiver"):print("user sender");
  //                           if(typeuser!="receiver"){
  //                             print(typeuser);
  //                             print(ApiUrl.addleadrating);
  //                             final response = await http.post(
  //                               Uri.parse(ApiUrl.addleadrating),
  //                               headers: {"Authorization": "$USERTOKKEN"},
  //                               body: {
  //                                 "type": type,
  //                                 "type_id": typeid,
  //                                 "call_log_id": calllogid,
  //                                 "rating": addrating.toString(),
  //                                 "review": description.text,
  //                                 "user_id":userid
  //
  //
  //                               },
  //                             );
  //                             print(response.body);
  //                             if (response.statusCode == 200) {
  //                               getlead();
  //                               getclient();
  //                               ScaffoldMessenger.of(context).showSnackBar( SnackBar(
  //                                 content: Text(
  //                                     "Rating Add Successfully"),
  //                               ));
  //                               Navigator.of(context).pop();
  //                               //  alltransactionmodel = myfinancelist(userid!);
  //                               if (kDebugMode) {
  //                                 print(response.statusCode);
  //
  //                               }
  //                             } else {
  //                               if (kDebugMode) {
  //                                 print("object");
  //                                 Navigator.pop(context);
  //                               }
  //                             }
  //                           }else{
  //                             print(typeuser);
  //                             print(ApiUrl.adduserrating);
  //                             final response = await http.post(
  //                               Uri.parse(ApiUrl.adduserrating),
  //                               headers: {"Authorization": "$USERTOKKEN"},
  //                               body: {
  //                                 "id":callratinid,
  //                                 "type": type,
  //                                 "type_id": typeid,
  //                                 "call_log_id": calllogid,
  //                                 "rating": addrating.toString(),
  //                                 "review": description.text,
  //                                 "user_id":userid
  //                               },
  //                             );
  //                             print(response.body);
  //                             if (response.statusCode == 200) {
  //                               getlead();
  //                               getclient();
  //                               ScaffoldMessenger.of(context).showSnackBar( SnackBar(
  //                                 content: Text(
  //                                     "Rating Add Successfully"),
  //                               ));
  //                               Navigator.of(context).pop();
  //                               //  alltransactionmodel = myfinancelist(userid!);
  //                               if (kDebugMode) {
  //                                 print(response.statusCode);
  //
  //                               }
  //                             } else {
  //                               if (kDebugMode) {
  //                                 print("object");
  //                                 Navigator.pop(context);
  //                               }
  //                             }
  //                           }
  //
  //                         },
  //                         child: boldtext(AppColors.white, 14, "Update"),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),),
  //         );
  //       });
  // }

  markasclient(BuildContext context,String calllogid,) async {
    TextEditingController description = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close_rounded),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(subMenu.image),
                      const SizedBox(
                        width: 10,
                      ),
                      boldtext(AppColors.black, 18, "Mark as Client"),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  regulartext(
                    const Color(0xffA6A6A6),
                    18,
                    "Are you sure to mark this profile \n                    as Client?",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          AddClient(calllogid);
                        },
                        child: boldtext(AppColors.white, 14, "Confirm"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: regulartext(
                      AppColors.primary,
                      14,
                      "Cancel",
                    ),
                  )
                ],
              ),),
          );
        });
  }

  removeclient(BuildContext context, String clientid) async {
    print("PRINT DATA CLIENT ID $clientid");
    TextEditingController description = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close_rounded),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(subMenu.image),
                      const SizedBox(
                        width: 10,
                      ),
                      boldtext(AppColors.black, 18, "Remove from client"),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  regulartext(
                    const Color(0xffA6A6A6),
                    18,
                    "Are you sure to remove this profile \n                     as Client?",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          //for delete client use userid
                          print(clientid);
                          print(UserId);
                          showLoader(context);
                          print(ApiUrl.removeasclient);
                          try {
                            final response = await http.post(Uri.parse(ApiUrl.removeasclient),
                                headers: {"Authorization": USERTOKKEN.toString()},
                                body: {"id": clientid,
                                });
                            if (response.statusCode == 200) {
                              print("success");
                              //  showInSnackBar(
                              // "Addes successfully",
                              //  );
                              getlead();
                              getclient();
                              Navigator.pop(context);
                              hideLoader();
                            } else {
                              print("not success");
                              Navigator.pop(context);
                              hideLoader();
                            }
                          } catch (e) {
                            print("exception" + e.toString());
                            hideLoader();

                            // hideLoader();
                          }
                        },
                        child: boldtext(AppColors.white, 14, "Yes! Remove"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: regulartext(
                      AppColors.primary,
                      14,
                      "Cancel",
                    ),
                  )
                ],
              ),),
          );
        });
  }

  void getuserType() async {
    String? usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    // ignore: prefer_interpolation_to_compose_strings
    print("Ashish" + UserId);
    setState(() {
      //   viewprofilelist=getviewprofilelist();
      // leadlist = getleadlist();
      getviewdprofile();
      getlead();
      getclient();
      // clientlist = getclientlist();


    });
  }

  Future<List<ViewprofileModeldata?>?>? getviewdprofile() async {
    try {
      print(ApiUrl.getviewprofile);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.getviewprofile),
        body: {
        },
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      print("response data my news ================="+response.statusCode.toString());
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        ViewprofileModel? viewNewsModel = ViewprofileModel.fromJson(jsonDecode(response.body));
        viewprofiledata = viewNewsModel.data!;
        setState(() {
        });

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
  Future<List<LeadDataModeldata?>?>? getlead() async {
    try {
      print(ApiUrl.getleadlist);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.getleadlist),
        body: {
        },
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      print("response data my news ================="+response.statusCode.toString());
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        LeadDataModel? viewNewsModel = LeadDataModel.fromJson(jsonDecode(response.body));
        leaddata = viewNewsModel.data!;
        setState(() {
        });

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
  Future<List<GetClientModeldata?>?>? getclient() async {
    try {
      print(ApiUrl.getleadlist);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.getleadlist),
        body: {
          "mark_as_client":"1"
        },
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      print("response data my news ================="+response.statusCode.toString());
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        GetClientModel? viewNewsModel = GetClientModel.fromJson(jsonDecode(response.body));
        clientdata = viewNewsModel.data!;
        setState(() {
        });

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


  Future<void> userid() async {
    usertype = await _sharedPreference.isUserType();
    // print("Ashish" + usertype!);
    UserId = await _sharedPreference.isUsetId();
    // print("Ashish" + UserId!);
  }

  AddClient(
      String calllogid,
      ) async {
    print(ApiUrl.addmarkasclient);
    print("PRINT CLIENT ID $calllogid");
    showLoader(context);
    try {
      final response = await http.post(Uri.parse(ApiUrl.addmarkasclient),
          headers: {"Authorization": USERTOKKEN.toString()},
          body: {
            "call_log_id":calllogid});
      if (response.statusCode == 200) {
        print(response.body);
        print("success");
        // showInSnackBar(
        //   "Addes successfully",
        // );
        Navigator.pop(context);
        getlead();
        getclient();
        hideLoader();
      } else {
        print("not success");
        Navigator.pop(context);
        hideLoader();
      }
    } catch (e) {
      print("exception" + e.toString());
      hideLoader();

      // hideLoader();
    }
  }

  Future<List<Getservicebyuseriddata>?> getservicebyid(String userId) async {
    print(ApiUrl.getservicebyid + userId);
    try {
      var headers = {'Authorization': USERTOKKEN!};
      final response =
      await http.get(Uri.parse(ApiUrl.getservicebyid + userId), headers: headers);
      print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        Getservicebyuserid? allServiceModel =
        Getservicebyuserid.fromJson(jsonDecode(response.body));
        setState(() {});
        return allServiceModel.data;
      } else {
        print("homedata ====${response.body}");
      }
    } catch (e) {
      print("homedata ====$e");
    }
  }

  Future<List<GetproductbyuseridData?>?>? getproductbyid(String userId) async {
    print("BOKKING DARA LIST OF MYBOOKING");
    print(ApiUrl.getproductbyid + userId);
    try {
      showLoader(context);
      print(USERTOKKEN.toString());
      final response = await http.get(
        Uri.parse(ApiUrl.getproductbyid + userId),
        headers: {"Authorization": USERTOKKEN.toString()},
        // body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        Getproductbyuserid? myBookingModel =
        Getproductbyuserid.fromJson(jsonDecode(response.body));
        productbyiddata = myBookingModel.data!;
        print("Success");
        setState(() {});
        return productbyiddata;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {
      hideLoader();
      print("data==1=$e");
    }
  }








}

Widget topNavView1(String title, VoidCallback ontap, bool view) {
  return InkWell(
    onTap: ontap,
    child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 5, right: 5, left: 5),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: view ? Colors.blue : Colors.transparent, width: 1)),
        ),
        child: Row(
          children: [
            view
                ? regulartext1(view ? Colors.blue : Colors.black, 14, title)
                : regulartext(view ? Colors.blue : Colors.black, 14, title),
            const SizedBox(
              width: 10,
            ),
            view
                ? SvgPicture.asset(
              AppImages.lock,
              color: AppColors.primary,
            )
                : SvgPicture.asset(AppImages.lock)
          ],
        )),
  );
}

Widget topNavView(String title, VoidCallback ontap, bool view) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.only(top: 15, bottom: 5, right: 5, left: 5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: view ? Colors.blue : Colors.transparent, width: 1)),
      ),
      child: view
          ? regulartext1(view ? Colors.blue : Colors.black, 14, title)
          : regulartext(view ? Colors.blue : Colors.black, 14, title),
    ),
  );
}



final SharedPreference _sharedPreference = SharedPreference();

Widget textAreasearch(TextEditingController controller, String hint,
    {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(
            horizontal: hint.contains("Description") ? 5 : 16, vertical: 10),
        child: TextField(
          onTap: () async {
            String becomeSuplier = await _sharedPreference.isLoggedIn();
            hint.contains("Description")
                ? print("dgfhgj")
                : print("");
            // Get.to(MyServicesScreensProvider(becomeSuplier));
          },
          minLines: hint.contains("Description") ? 5 : 1,
          maxLines: hint.contains("Description") ? 5 : 1,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: hint.contains("Description")
                  ? const SizedBox.shrink()
                  : Padding(
                padding: const EdgeInsets.all(0),
                child: SvgPicture.asset(
                  AppImages.search,
                  height: 16,
                  width: 16,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: hint.contains("Description")
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: hint.contains("Description")
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.white, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: hint == "Search" || hint == "Description"
                  ? AppColors.gray
                  : Colors.white,
              hintText: hint),
        ),
      ),
    ],
  );
}
