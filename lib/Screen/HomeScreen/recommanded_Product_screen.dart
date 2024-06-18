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
import 'package:businessgym/model/getRecommandedProductModel.dart';
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




class RecomandedProductScreen extends StatefulWidget {
  @override
  String? type;
  RecomandedProductScreen(this.type);
  RecomandedProductState createState() => RecomandedProductState();
}

class RecomandedProductState extends State<RecomandedProductScreen> {
  SharedPreference _sharedPreference = SharedPreference();
  String UserId = "";
  List<GetRecommendedProductdata>? getrecommandedproductdata = [];
  @override
  void initState() {
    getuserType();
    super.initState();

  }

  void getuserType() async {

    UserId = await _sharedPreference.isUsetId();

    Getrecommendedproduct();
    setState(() {

    });
  }
  Future<List<GetRecommendedServicedata>?> Getrecommendedproduct() async {
    try{
      showLoader(context);
      print(ApiUrl.getreccomandedproduct);
      final response = await http.get(
        Uri.parse(ApiUrl.getreccomandedproduct),
        headers: {"Authorization": "$USERTOKKEN"},
      );
      if (response.statusCode == 200) {
        hideLoader();
        print(response.statusCode);
        GetRecommendedProduct vehicalTypeModel =
        GetRecommendedProduct.fromJson(jsonDecode(response.body));
        getrecommandedproductdata = vehicalTypeModel.data;

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
          title: "Recommended Product",
        ),
        backgroundColor: AppColors.BGColor,
        body:getrecommandedproductdata!.isEmpty?Center(child: Text("No Recommended Product Found"),):ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: getrecommandedproductdata!.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: (){
                CommonBottomSheet.show(context,getrecommandedproductdata![i].userId.toString(),getrecommandedproductdata![i].id.toString(),"product","");
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
                        NetworkImage(getrecommandedproductdata![i].productImage!),
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
                              getrecommandedproductdata![i].username==null?"-":getrecommandedproductdata![i].username!,

                            ),
                            Row(
                              children: [
                                Expanded(
                                  child:  regulartext(Colors.black,13,
                                    getrecommandedproductdata![i].name==null?"-":getrecommandedproductdata![i].name!,
                                  ),),

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                          color: getrecommandedproductdata![i].tag!="Supplier Service"?AppColors.primary.withOpacity(0.05):AppColors.LightGreens,
                                          borderRadius: BorderRadius.all(Radius.circular(9))
                                      ),
                                      child:  getrecommandedproductdata![i].tag!="Supplier Service"?boldtext(AppColors.Green,10,
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
                                    rating: getrecommandedproductdata![i].averageRating==null?0:getrecommandedproductdata![i].averageRating.toDouble()!,
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
                                      12, '    ${getrecommandedproductdata![i].averageRating==null?0:getrecommandedproductdata![i].averageRating.toStringAsFixed(1)} Rating')
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
