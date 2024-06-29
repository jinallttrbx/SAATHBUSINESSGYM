// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:businessgym/Screen/FeedScreen/LoneScreens.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';

import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/getRecommandedServiceModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';




class RecomandedServiceScreen extends StatefulWidget {
  @override
  String? type;
  RecomandedServiceScreen(this.type);
  RecomandedServiceState createState() => RecomandedServiceState();
}

class RecomandedServiceState extends State<RecomandedServiceScreen> {
  SharedPreference _sharedPreference = SharedPreference();
  String UserId = "";
  Future<GetRecommendedService?>?  providerdatalist;
  List<GetRecommendedService>? providerdata = [];
  List<GetRecommendedServicedata>? getrecommandedservicedata = [];
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  @override
  void initState() {
    getuserType();
    super.initState();

  }

  void getuserType() async {
    String? usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId);
    getCityStateIdDataDatad();
    setState(() {

    });
  }
  Future<List<GetRecommendedServicedata>?> getCityStateIdDataDatad() async {
    try{
      showLoader(context);
      print(ApiUrl.getreccomandedservice);
      final response = await http.get(
        Uri.parse(ApiUrl.getreccomandedservice),
        headers: {"Authorization": "$USERTOKKEN"},
      );
      if (response.statusCode == 200) {
        hideLoader();
        print(response.statusCode);
        GetRecommendedService vehicalTypeModel =
        GetRecommendedService.fromJson(jsonDecode(response.body));
        getrecommandedservicedata = vehicalTypeModel.data;
        print(getrecommandedservicedata![0].name);
        //  Navigator.of(context).pop();
        setState(() {});
      } else {
        hideLoader();
      }
    }catch(e){
 print(e);
    }


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APPBar(
        title: "Recommended Service",
      ),
        backgroundColor: AppColors.BGColor,
        body:ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: getrecommandedservicedata!.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: (){

                CommonBottomSheet.show(context,getrecommandedservicedata![i].userId.toString(),getrecommandedservicedata![i].id.toString(),"service","");

              },
              child:Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.all(
                          Radius.circular(16))),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        NetworkImage(getrecommandedservicedata![i].serviceImage!),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Container(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            boldtext(Colors.black,16,
                              getrecommandedservicedata![i].username==null?"-":getrecommandedservicedata![i].username!,

                            ),
                            Row(
                              children: [
                                Expanded(
                                  child:  regulartext(Colors.black,13,
                                    getrecommandedservicedata![i].name==null?"-":getrecommandedservicedata![i].name!,
                                  ),),

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                          color: getrecommandedservicedata![i].tag!="Supplier Service"?AppColors.primary.withOpacity(0.05):AppColors.LightGreens,
                                          borderRadius: BorderRadius.all(Radius.circular(9))
                                      ),
                                      child:  getrecommandedservicedata![i].tag!="Supplier Service"?boldtext1(AppColors.Green,10,
                                        "ME",
                                      ):boldtext1(AppColors.primary,10,
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
                                    rating: getrecommandedservicedata![i].averageRating==null?0:getrecommandedservicedata![i].averageRating.toDouble()!,
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
                                      12, '    ${getrecommandedservicedata![i].averageRating==null?0:getrecommandedservicedata![i].averageRating.toStringAsFixed(1)} Rating')
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                      SvgPicture.asset(AppImages.altarroe)
                    ],
                  )) ,
            );

          },
        )
    );

  }







}
