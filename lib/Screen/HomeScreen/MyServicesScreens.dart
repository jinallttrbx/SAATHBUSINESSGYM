// ignore_for_file: must_be_immutable, file_names

import 'dart:convert';


import 'package:businessgym/Screen/ProfileScreen/SubCategoryScreen.dart';
import 'package:businessgym/Utils/common_route.dart';

import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../model/AllServiceModel.dart';




import '../../conts/global_values.dart';


class MyServicesScreens extends StatefulWidget {
  bool? productView;
  MyServicesScreens({super.key, this.productView});

  @override
  MyServicesScreensState createState() => MyServicesScreensState();
}

class MyServicesScreensState extends State<MyServicesScreens> {
  SharedPreference sharedPreference = SharedPreference();
  List<AllProductModeldata>? productsellerdata = [];
  List<AllServiceModelData>  serviceproviderdata=[];
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];

  bool focus = false;
  FocusNode inputNode = FocusNode();
  TextEditingController controller = TextEditingController();
  String? UserId;
  String? userType;
  String? filter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usetId();
    setState(() {});
  }

  Future<void> usetId() async {
    UserId = await sharedPreference.isUsetId();
    getproductseller();
    getserviceprovider();

    setState(() {});
  }

  Future<List<AllProductModeldata?>?>? getproductseller() async {
    try {
      print(ApiUrl.getprovideproduct);
      showLoader(context);
      final response = await http.get(
        Uri.parse(ApiUrl.getprovideproduct),
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        AllProductModel? viewNewsModel = AllProductModel.fromJson(jsonDecode(response.body));
        productsellerdata = viewNewsModel.data!;
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
  Future<List<AllServiceModelData>?> getserviceprovider() async {
    try {
      print(ApiUrl.getservicecategory);
      showLoader(context);



      final response = await http.get(
        Uri.parse(ApiUrl.getservicecategory),
        headers: {"Authorization": USERTOKKEN.toString()},
      );

      print("response data my news ================="+response.body);
      //  Map<String, dynamic> map = json.decode(response.body);



      if (response.statusCode == 200) {

        hideLoader();


        AllServiceModel? viewNewsModel = AllServiceModel.fromJson(jsonDecode(response.body));
        serviceproviderdata = viewNewsModel.data!;
        setState(() {


        });

        print("Success");


        return viewNewsModel.data!;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {

      print("data==1=$e");

    }
  }


  int? viewall1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
     // appBar: widget.appbar == false ? null : APPBar(title: 'Search Service'),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              // textAreasearch(
              //   search,
              //   'Search ',
              // ),
              SizedBox(height: 15,),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:serviceproviderdata.length,
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          boldtext(Colors.black,16,serviceproviderdata[index].name!),
                          SizedBox(height: 20,),
                          Container(

                              child:  StaggeredGridView.countBuilder(
                                  staggeredTileBuilder: (int index) => StaggeredTile.fit(
                                    index.isEven ? 3 : 2,
                                  ),
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  crossAxisCount: 8,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: serviceproviderdata[index].subData!.length ,
                                  itemBuilder: (BuildContext context, int index1) {
                                    return InkWell(
                                    onTap: (){
              Get.to(
                    () => SubCategoryScreen(
                  serviceproviderdata[index].subData![index1]
                      .id,
                  serviceproviderdata[index].subData![index1]
                      .name,
                  serviceproviderdata[index].subData![index1]
                      .categoryImage,
                  false,
                ),
              );
            },
                                      child:  Container(
                                        width: 50,
                                        padding: EdgeInsets.all(5),

                                                     decoration: BoxDecoration(
                                                         color: Colors.white,
                                                         borderRadius: BorderRadius.all(Radius.circular(50))
                                                     ),
                                        child: boldtext(AppColors.black,14,serviceproviderdata[index].subData![index1].name!,
                                        ),
                                      ),
                                    );
                                  })

                          )
                        ],
                      ),
                    );
                  }),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:productsellerdata!.length,
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          boldtext(Colors.black,16,productsellerdata![index].name!),
                          SizedBox(height: 20,),
                          Container(

                              child:  StaggeredGridView.countBuilder(
                                  staggeredTileBuilder: (int index) => StaggeredTile.fit(
                                    index.isEven ? 3 : 2,
                                  ),
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  crossAxisCount: 8,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: productsellerdata![index].subData!.length ,
                                  itemBuilder: (BuildContext context, int index1) {
                                    return InkWell(
                                      onTap: (){
                                        Get.to(
                                              () => SubCategoryScreen(
                                            productsellerdata![index].subData![index1]
                                                .id,
                                            productsellerdata![index].subData![index1]
                                                .name,
                                            productsellerdata![index]
                                                .categoryImage,
                                            false,
                                          ),
                                        );
                                      },
                                      child:  Container(
                                        width: 50,
                                        padding: EdgeInsets.all(5),

                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: boldtext(AppColors.black,14,productsellerdata![index].subData![index1].name!,
                                        ),
                                      ),
                                    );
                                  })

                          )
                        ],
                      ),
                    );
                  }),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                //height: 550,

              ),
            ],
          ),
        ),
      ),
    );

  }


}
