

import 'dart:convert';

import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/components/snackbar.dart';

import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/model/AllServiceModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/olddocument/document.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';

import '../../model/ProviderModel.dart';
import '../../values/Colors.dart';
import '../../values/assets.dart';
import '../../conts/global_values.dart';
import '../../conts/stars_view.dart';
import 'productServices.dart';

class SubCategoryScreen extends StatefulWidget {
  int? id;
  String? name;
  String? categoryImage;
  bool? isSupplier;
  SubCategoryScreen(this.id, this.name, this.categoryImage, this.isSupplier);

  @override
  SubCategoryScreenState createState() => SubCategoryScreenState();
}

class SubCategoryScreenState extends State<SubCategoryScreen> {
  TextEditingController search=TextEditingController();
  Future<ProviderModel?>? allserviceCategory;
  List<Data?>? data;
  SharedPreference _sharedPreference = new SharedPreference();
  String? UserId;
  String? cdate;
 // Future<List<GetproductbyuseridData?>?>? productbyid;
  //List<GetproductbyuseridData>? productbyiddata = [];
  String? Number;
  List<Getservicebyuseriddata>? productsellerdata = [];
 // Future<List<Getservicebyuseriddata?>?>? servicebyid;
 // List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid();
    setState(() {});
  }

  Future<void> userid() async {
    UserId = await _sharedPreference.isUsetId();
    // print("Ashish" + UserId!);
    cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    allserviceCategory = getAllserviceCategory(UserId!);
    setState(() {});
  }

  String searchText = "";
  Future<ProviderModel?> getAllserviceCategory(String UserId) async {
    try {
      //showLoader(context);

      String id = widget.id.toString();
      print(id);
      print("new id======");
      print( ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId");
      print(ApiUrl.SupplierServiceBySubCategoryID);

      final response = widget.isSupplier == true
          ? await http.post(Uri.parse(ApiUrl.SupplierServiceBySubCategoryID),
              headers: {"Authorization": USERTOKKEN.toString()},
              body: {"subcategory_id": widget.id.toString()})
          : await http.get(Uri.parse(
              ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId"));

      print("Success==== ${response.body}" +
          ApiUrl.provider_list +
          "?subcategory_id=$id&user_id=$UserId");
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        ProviderModel? allServiceModel =
            ProviderModel.fromJson(jsonDecode(response.body));
        setState(() {
          data=allServiceModel!.data!;
        });
        return allServiceModel;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {
      print("data===$e");
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "${widget.name}"),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textAreasearch(
                search,
                'Search ',
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 35,
                    width: 100,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.filter),
                          SizedBox(width: 5,),
                          Text("Filter",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",),)
                        ],
                      )
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(child: Text("2 filters apply",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",),),),
                  Text("Clear All",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600
                      ,fontFamily: "OpenSans",color: AppColors.primary),)

                ],
              ),
              SizedBox(height: 15,),
              Text("  Showing ${data?.length} results"),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                //height: 550,
                child: FutureBuilder<ProviderModel?>(
                    future: allserviceCategory,
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
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return searchText == "" ||
                                        (searchText != "" &&
                                            snapshot
                                                .data!.data![index].serviceName!
                                                .contains(searchText))
                                    ? GestureDetector(
                                  onTap: (){
                                    CommonBottomSheet.show(context,snapshot.data!.data![index].providerId.toString(),snapshot.data!.data![index].serviceId.toString(),"service");


                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),


                                      child:Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                  "${snapshot.data!.data![index].service_attachment}",
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(child:  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  boldtext(
                                                    AppColors.black,
                                                    14,
                                                    "Service: ${snapshot.data!.data![index].serviceName}",
                                                  ),
                                                  boldtext(
                                                    AppColors.blackShade3,
                                                    12,
                                                    "Provider: ${snapshot.data!.data![index].displayName}",
                                                  ),
                                                  StarsView(
                                                      total: 5,
                                                      colored: double.parse(snapshot
                                                          .data!
                                                          .data![index]
                                                          .rating
                                                          .toString())
                                                          .toInt(),
                                                      ontap: () {
                                                        Get.to(() =>
                                                            RatingandReviewByUserScreens(
                                                              isProduct: false,
                                                              user_id: UserId,
                                                              serviceOrProductId:
                                                              snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .serviceId
                                                                  .toString(),
                                                              providerId: snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .providerId
                                                                  .toString(),
                                                            ));
                                                      })
                                                ],
                                              ))
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Divider(height: 1,thickness: 1,)
                                        ],
                                      )
                                  ),
                                )
                                    : SizedBox.shrink();
                              });
                        }
                      }


                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }












}
Widget textAreasearch(TextEditingController controller, String hint, {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextField(

          minLines: hint.contains("Description")?5:1,
          maxLines: hint.contains("Description")?5:1,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(AppImages.search),
              ),

              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                const BorderSide(color: Colors.white, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: Color(0xffEEEEEE),
              hintText: hint),
        ),
      ),
    ],
  );
}
