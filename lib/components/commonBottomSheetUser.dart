import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/model/userModelbyid.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonBottomSheetUser extends StatefulWidget {
  String userid;
  String firstid;
  String type;
  String view;

  CommonBottomSheetUser(this.userid, this.firstid, this.type,this.view);

  @override
  _CommonBottomSheetUserState createState() => _CommonBottomSheetUserState();

  static void show(
      BuildContext context, String userid, String firstid, String type,String view) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints.tight(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * .8)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return CommonBottomSheetUser(userid, firstid, type,view);
          });
        });
  }
}

class _CommonBottomSheetUserState extends State<CommonBottomSheetUser> {
  String name = "";
  String address = "-";
  double ratingstart = 0.0;
  int listToShow = 0;
  String contactnmber = "";
  String email = "";
  String gstnumber = "-";
  String fassainumber = "-";
  String openat = "-";
  String closeat = "-";
  String image = "";
  String UserId = "";
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  SharedPreference _sharedPreference = SharedPreference();
  UserModelbyuserId? userdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
    userid();
  }

  Future<void> userid() async {
    // usertype = await _sharedPreference.isUserType();
    // print("Ashish" + usertype!);
    UserId = await _sharedPreference.isUsetId();
    // print("Ashish" + UserId!);
  }

  void getuserType() async {
    String? usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    // ignore: prefer_interpolation_to_compose_strings
    print("Ashish" + UserId);
    setState(() {
      getuserdata(widget.userid);
      print(UserId);
      print(widget.userid);
      addprofile(widget.userid);
      // UserId == widget.userid
      //     ? print("same user id")
      //     : addprofile(widget.userid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (
        BuildContext context,
        StateSetter setState,
        /*You can rename this!*/
        ) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text(
                            "${name}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans"),
                          ),
                          Text(
                            "${address}",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "OpenSans",
                                color: Color(0xff656565)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 100, right: 100, top: 10),
                            padding: EdgeInsets.all(8),
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color(0xffF1FAFF),
                                borderRadius:
                                BorderRadius.all(Radius.circular(17))),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    direction: Axis.horizontal,
                                    rating: ratingstart,
                                    itemCount: 5,
                                    itemSize: 14,
                                    itemPadding: const EdgeInsets.all(2),
                                    unratedColor: Colors.grey,
                                    itemBuilder: (context, _) =>
                                        SvgPicture.asset(AppImages.rating),
                                  ),
                                  boldtext(Color(0xff656565), 10,
                                      "${ratingstart==0.0?0:ratingstart.toStringAsFixed(1)} Rating")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(left: 15, right: 15),
                                      padding: EdgeInsets.all(11),
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF0F0F0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(28))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: listToShow == 0
                                                    ? AppColors.white
                                                    : listToShow == 1
                                                    ? Color(0xffF0F0F0)
                                                    : Color(0xffF0F0F0),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(28)),
                                              ),
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      listToShow = 0;
                                                    });
                                                    print(listToShow);
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      "Overview",
                                                      style: TextStyle(
                                                        color: listToShow == 0
                                                            ? AppColors.blue
                                                            : listToShow == 1
                                                            ? AppColors
                                                            .black
                                                            : AppColors
                                                            .black,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 350,
                                      child:  Container(
                                          padding:
                                          EdgeInsets.only(left: 16),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "Contact no.",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${contactnmber}",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "Email id",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${email}",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "Address",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${address}",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "GST no.",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${gstnumber}",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "FSSAI no.",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${fassainumber}",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                regulartext(
                                                  Color(0xffA6A6A6),
                                                  12,
                                                  "Working hour",
                                                ),
                                                boldtext(
                                                  Colors.black,
                                                  14,
                                                  "${openat} - ${closeat}",
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                          height: 50,
                                                          child: ElevatedButton
                                                              .icon(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(
                                                                          15))),
                                                                  backgroundColor:
                                                                  Color(
                                                                      0xff25D366)),
                                                              onPressed:
                                                                  () async {
                                                                // ontap();
                                                                addlead(
                                                                    widget
                                                                        .userid,
                                                                    widget
                                                                        .firstid);
                                                                var url =
                                                                    'https://api.whatsapp.com/send?phone=+91${contactnmber!.substring(3, 13)}&text';
                                                                await launch(
                                                                    url);
                                                              },
                                                              icon:
                                                              SvgPicture
                                                                  .asset(
                                                                AppImages
                                                                    .whatsapp,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                              label:
                                                              const Text(
                                                                "Whatsapp",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize:
                                                                    12,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                          height: 50,
                                                          child: ElevatedButton
                                                              .icon(
                                                              icon:
                                                              SvgPicture
                                                                  .asset(
                                                                AppImages
                                                                    .call,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(
                                                                          15))),
                                                                  backgroundColor:
                                                                  AppColors
                                                                      .primary),
                                                              onPressed:
                                                                  () {
                                                                addlead(
                                                                    widget
                                                                        .userid,
                                                                    widget
                                                                        .firstid);
                                                                final data = Uri(
                                                                    scheme:
                                                                    'tel',
                                                                    path:
                                                                    '+91${contactnmber?.substring(3, 13)}');
                                                                launchUrl(
                                                                    data);
                                                              },
                                                              label: Text(
                                                                "Call",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize:
                                                                    12,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))


                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(20 / 2, 0), //20 is the * box size
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    transform: Matrix4.translationValues(80.0, -100, 20.0),
                    alignment: Alignment.center,

                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(image as String),
                          ),
                        ),
                        Positioned(
                          left: 110,
                          top: 130,
                          child: SvgPicture.asset(AppImages.roundleft),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    height: 30,
                    transform: Matrix4.translationValues(0.0, -120, -50.0),
                    // translate up by 30
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      );
    });
  }

  Future<List<Getservicebyuseriddata?>?>? getservicebyid(String userId) async {
    print("BOKKING DARA LIST OF MYBOOKING");
    print(ApiUrl.getservicebyid + userId);
    try {
      showLoader(context);
      print(USERTOKKEN.toString());
      final response = await http.get(
        Uri.parse(ApiUrl.getservicebyid + userId),
        headers: {"Authorization": USERTOKKEN.toString()},
        // body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        Getservicebyuserid? myBookingModel =
        Getservicebyuserid.fromJson(jsonDecode(response.body));
        servicebyiddata = myBookingModel.data!;
        print("Success");
        print(servicebyiddata!.length);
        print(servicebyiddata![0].subCategoryName);
        setState(() {});
        return servicebyiddata;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {
      //hideLoader();
      print("data==1=$e");
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

  Future<UserModelbyuserIddata?> getuserdata(String userId) async {
    print("userId         ==>   $userId");
    print(ApiUrl.getuerdetailsbyuserid + userId);
    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
      };
      final response = await http.get(
          Uri.parse(ApiUrl.getuerdetailsbyuserid + userId),
          headers: {"Authorization": USERTOKKEN.toString()});
      print("response profile ==> ${response.body}");
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        userdata = UserModelbyuserId.fromJson(jsonDecode(response.body));
        print(userdata!.data.contactNumber);
        print(userdata!.data.email);
        print(userdata!.data.username);


        setState(() {
          contactnmber = userdata!.data.contactNumber;
          name = userdata!.data.username;
         // address = userdata!.data.a == null ? "-" : userdata!.data.businessAddress;
          email = userdata!.data.email == null||userdata!.data.email == "" ? "-" : userdata!.data.email;
         // gstnumber =
         // userdata!.data.gstNumber == null ? "-" : userdata!.data.gstNumber;
         // fassainumber = userdata!.data.fssaiNumber == null? "-": userdata!.data.fssaiNumber;
        //  openat = userdata!.data.openTime==null?"-":userdata!.data.openTime.toString();
        //  closeat = userdata!.data.closeTime==null?"-":userdata!.data.closeTime.toString();
          ratingstart = userdata!.data.rating == null
              ? 0.0
              : userdata!.data.rating.toDouble();
          image = userdata!.data.profileImage;
        });

        return userdata!.data;
      } else {
        return userdata!.data;
      }
    } catch (e) {
      print(
          "profile error -----------------------------------------------------------------$e");
    }
  }

  addprofile(
      String profileid,
      ) async {
    print(ApiUrl.addviewedprofile);
    print("subcatid $profileid");
    print(profileid);
    String url = ApiUrl.addviewedprofile;
    // showLoader(context);
    print(url);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = USERTOKKEN.toString();
      request.fields["profile_id"] = profileid;
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        // hideLoader();
        // showInSnackBar("Add Successfully");
        // hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      //  hideLoader();
      //showInSnackBar("Http Error Try Again Later $e");
      // hideLoader();
    }
  }

  addlead(String providerId, String id) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("subcatid $providerId");
    print(providerId);
    String url = ApiUrl.addlead;//"https://saath.lttrbx.in/api/add-call-logs";
    // showLoader(context);
    print(url);
    print("${providerId},${date},${id}${widget.type}");

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = USERTOKKEN.toString();
      request.fields["provider_id"] = providerId;
      request.fields['date'] = date;
      request.fields['type_id'] = id;
      request.fields['type'] = widget.type!;
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        print("${providerId},${date},${id}${widget.type}");
        // hideLoader();
        // showInSnackBar("Add Successfully");
        // hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      //  hideLoader();
      // showInSnackBar("Http Error Try Again Later $e");
      // hideLoader();
    }
  }
}

// Example of opening the bottom sheet from another page

