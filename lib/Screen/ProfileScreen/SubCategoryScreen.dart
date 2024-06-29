

import 'dart:async';
import 'dart:convert';
import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/filter_screen.dart';
import 'package:businessgym/model/SearchListModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/ProviderModel.dart';
import '../../values/Colors.dart';
import '../../values/assets.dart';
import '../../conts/global_values.dart';
import '../../conts/stars_view.dart';


class SubCategoryScreen extends StatefulWidget {
  int? id;
  String? name;
  String? categoryImage;
  bool? isSupplier;
  SubCategoryScreen(this.id, this.name, this.categoryImage, this.isSupplier, {super.key});

  @override
  SubCategoryScreenState createState() => SubCategoryScreenState();
}

class SubCategoryScreenState extends State<SubCategoryScreen> {
  TextEditingController search=TextEditingController();
  Future<ProviderModel?>? allserviceCategory;
  List<ProviderData> allserviceCategory1 = [];
  List<Serchlistmodeldata> searchlist = [];
  List<ProviderData> data =[];
  SharedPreference _sharedPreference = new SharedPreference();
  String? UserId;
  String? cdate;
  Timer? _debounce;
  var categoryIdList = [];
  String? ratingValue;
  String? catType;
  double? lat;
  double? lng;
  String? openAt;
  String? closeAt;
  double? startPrice;
  double? endPrice;
  String? Number;
  List<Getservicebyuseriddata>? productsellerdata = [];
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
      print( "${ApiUrl.provider_list}?subcategory_id=$id&user_id=$UserId");
      print(ApiUrl.SupplierServiceBySubCategoryID);

      final response = widget.isSupplier == true
          ? await http.post(Uri.parse(ApiUrl.SupplierServiceBySubCategoryID),
              headers: {"Authorization": USERTOKKEN.toString()},
              body: {"subcategory_id": widget.id.toString()})
          : await http.get(Uri.parse(
              "${ApiUrl.provider_list}?subcategory_id=$id&user_id=$UserId"));

      if (kDebugMode) {
        print("Success==== ${response.body}${ApiUrl.provider_list}?subcategory_id=$id&user_id=$UserId");
      }

      if (response.statusCode == 200) {
        ProviderModel? allServiceModel =
            ProviderModel.fromJson(jsonDecode(response.body));
        setState(() {
          data=allServiceModel.data!;
        });
        return allServiceModel;
      } else {
        hideLoader();
        print("Something went wronge");
      }
    } catch (e) {
      print("data===$e");
    }
    return null;
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  controller: search,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    // getSearch(controller.text);
                    if (_debounce?.isActive ?? false) {
                      _debounce!.cancel();
                    }
                    _debounce = Timer(
                      const Duration(milliseconds: 1000),
                          () {
                        if (value.isNotEmpty) {
                          searchWithFilter(value);
                        } else {
                          setState(() {
                            searchlist = [];
                          });
                        }
                      },
                    );
                  },
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SvgPicture.asset(AppImages.search),
                      ),

                      contentPadding: const EdgeInsets.all(10),
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
                      fillColor: const Color(0xffEEEEEE),
                      hintText: "Search For Service"),
                ),
              ),
              // textAreasearch(
              //   search,
              //   'Search ',
              // ),

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 35,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.filter),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Get.to(const filterscreen());
                              },
                              child: const Text(
                                "Filter",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "OpenSans",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/2),
                  GestureDetector(
                    onTap: () {
                      search.clear();
                    },
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15,),
              Text("  Showing ${data.length} results"),
              const SizedBox(height: 15,),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                //height: 550,
                child: data.length==0?const Center(child: Text("No Items Found"),):searchlist.isEmpty?
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return searchText == "" ||
                          (searchText != "" &&
                              data[index].serviceName!
                                  .contains(searchText))
                          ? GestureDetector(
                        onTap: (){
                          CommonBottomSheet.show(context,data[index].providerId.toString(),data[index].serviceId.toString(),"service","");


                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),


                            child:Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "${data[index].service_attachment}",
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        boldtext(
                                          AppColors.black,
                                          14,
                                          "Service: ${data[index].serviceName}",
                                        ),
                                        boldtext(
                                          AppColors.blackShade3,
                                          12,
                                          "Provider: ${data[index].displayName}",
                                        ),
                                        StarsView(
                                            total: 5,
                                            colored: double.parse(data[index]
                                                .rating
                                                .toString())
                                                .toInt(),
                                            ontap: () {
                                              Get.to(() =>
                                                  RatingandReviewByUserScreens(
                                                    isProduct: false,
                                                    user_id: UserId,
                                                    serviceOrProductId:
                                                   data[index]
                                                        .serviceId
                                                        .toString(),
                                                    providerId: data[index]
                                                        .providerId
                                                        .toString(),
                                                  ));
                                            })
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                const Divider(height: 1,thickness: 1,)
                              ],
                            )
                        ),
                      )
                          : const SizedBox.shrink();
                    }):
                  ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchlist.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return searchText == "" ||
                        (searchText != "" &&
                            data[index].serviceName!
                                .contains(searchText))
                        ? GestureDetector(
                      onTap: (){
                        CommonBottomSheet.show(context,data[index].providerId.toString(),data[index].serviceId.toString(),"service","");


                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),


                          child:Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "${searchlist[index].profileImage}",
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      boldtext(
                                        AppColors.black,
                                        14,
                                        "Service: ${searchlist[index].subCategoryName}",
                                      ),
                                      boldtext(
                                        AppColors.blackShade3,
                                        12,
                                        "Provider: ${searchlist[index].name}",
                                      ),
                                      StarsView(
                                          total: 5,
                                          colored: double.parse(searchlist[index]
                                              .rating
                                              .toString())
                                              .toInt(),
                                          ontap: () {
                                            Get.to(() =>
                                                RatingandReviewByUserScreens(
                                                  isProduct: false,
                                                  user_id: UserId,
                                                  serviceOrProductId:
                                                  searchlist[index]
                                                      .typeId
                                                      .toString(),
                                                  providerId: searchlist[index]
                                                      .typeId
                                                      .toString(),
                                                ));
                                          })
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Divider(height: 1,thickness: 1,)
                            ],
                          )
                      ),
                    )
                        : const SizedBox.shrink();
                  })
              ),
            ],
          ),
        ),
      ),
    );
  }










  searchWithFilter(String value) async {
    searchlist = [];
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.searchFilterUrl),
      );
      request.fields['text'] = value;
      if (categoryIdList != []) {
        for (var i = 0; i < categoryIdList.length; i++) {
          request.fields['category_id[$i]'] = categoryIdList[i].toString();
        }
      }
      if (ratingValue != null) {
        request.fields['rating'] = ratingValue ?? '';
      }
      if (startPrice != null) {
        request.fields['min_price'] =  startPrice.toString();
      }
      if (endPrice != null) {
        request.fields['max_price'] = endPrice.toString() ;
      }
      if (lat != null) {
        request.fields['latitude'] = lat.toString() ;
      }
      if (lng != null) {
        request.fields['longitude'] = lng.toString() ;
      }
      if (openAt != null) {
        request.fields['open_at'] = openAt ?? '';
      }
      if (closeAt != null) {
        request.fields['close_at'] = closeAt ?? '';
      }
      final response = await request.send();
      final data = await http.Response.fromStream(response);
      if (kDebugMode) {
        print(data.body);
      }
      if (kDebugMode) {
        print(data.statusCode);
      }
      if (response.statusCode == 200) {
        Serchlistmodel vehicalTypeModel =
        Serchlistmodel.fromJson(jsonDecode(data.body));
        searchlist = vehicalTypeModel.data;
        setState(() {});
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(AppImages.search),
              ),

              contentPadding: const EdgeInsets.all(10),
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
              fillColor: const Color(0xffEEEEEE),
              hintText: hint),
        ),
      ),
    ],
  );
}


// import 'dart:async';
// import 'dart:convert';
//
// import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
// import 'package:businessgym/components/commonBottomSheet.dart';
// import 'package:businessgym/components/snackbar.dart';
//
// import 'package:businessgym/conts/appbar_global.dart';
// import 'package:businessgym/conts/filter_screen.dart';
// import 'package:businessgym/model/AllServiceModel.dart';
// import 'package:businessgym/model/SearchListModel.dart';
// import 'package:businessgym/model/getproductbyuserid.dart';
// import 'package:businessgym/model/getservicebyuserid.dart';
// import 'package:businessgym/olddocument/document.dart';
// import 'package:businessgym/values/const_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../Utils/ApiUrl.dart';
// import '../../Utils/SharedPreferences.dart';
// import '../../Utils/common_route.dart';
//
// import '../../model/ProviderModel.dart';
// import '../../values/Colors.dart';
// import '../../values/assets.dart';
// import '../../conts/global_values.dart';
// import '../../conts/stars_view.dart';
// import 'productServices.dart';
//
// class SubCategoryScreen extends StatefulWidget {
//   int? id;
//   String? name;
//   String? categoryImage;
//   bool? isSupplier;
//   SubCategoryScreen(this.id, this.name, this.categoryImage, this.isSupplier);
//
//   @override
//   SubCategoryScreenState createState() => SubCategoryScreenState();
// }
//
// class SubCategoryScreenState extends State<SubCategoryScreen> {
//   TextEditingController search=TextEditingController();
//   Future<ProviderModel?>? allserviceCategory;
//   List<ProviderData> allserviceCategory1 = [];
//   List<Serchlistmodeldata> searchlist = [];
//   List<ProviderData?>? data;
//   SharedPreference _sharedPreference = new SharedPreference();
//   String? UserId;
//   String? cdate;
//   Timer? _debounce;
//   var categoryIdList = [];
//   String? ratingValue;
//   String? catType;
//   double? lat;
//   double? lng;
//   String? openAt;
//   String? closeAt;
//   double? startPrice;
//   double? endPrice;
//   // Future<List<GetproductbyuseridData?>?>? productbyid;
//   //List<GetproductbyuseridData>? productbyiddata = [];
//   String? Number;
//   List<Getservicebyuseriddata>? productsellerdata = [];
//   // Future<List<Getservicebyuseriddata?>?>? servicebyid;
//   // List<Getservicebyuseriddata>? servicebyiddata = [];
//   Future<List<GetproductbyuseridData?>?>? productbyid;
//   List<GetproductbyuseridData>? productbyiddata = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     userid();
//     setState(() {});
//   }
//
//   Future<void> userid() async {
//     UserId = await _sharedPreference.isUsetId();
//     // print("Ashish" + UserId!);
//     cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
//     allserviceCategory = getAllserviceCategory(UserId!);
//     setState(() {});
//   }
//
//   String searchText = "";
//   Future<ProviderModel?> getAllserviceCategory(String UserId) async {
//     try {
//       //showLoader(context);
//
//       String id = widget.id.toString();
//       print(id);
//       print("new id======");
//       print( ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId");
//       print(ApiUrl.SupplierServiceBySubCategoryID);
//
//       final response = widget.isSupplier == true
//           ? await http.post(Uri.parse(ApiUrl.SupplierServiceBySubCategoryID),
//           headers: {"Authorization": USERTOKKEN.toString()},
//           body: {"subcategory_id": widget.id.toString()})
//           : await http.get(Uri.parse(
//           ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId"));
//
//       print("Success==== ${response.body}" +
//           ApiUrl.provider_list +
//           "?subcategory_id=$id&user_id=$UserId");
//       Map<String, dynamic> map = json.decode(response.body);
//       if (response.statusCode == 200) {
//         ProviderModel? allServiceModel =
//         ProviderModel.fromJson(jsonDecode(response.body));
//         setState(() {
//           data=allServiceModel!.data!;
//         });
//         return allServiceModel;
//       } else {
//         hideLoader();
//         print("Something went wronge");
//       }
//     } catch (e) {
//       print("data===$e");
//     }
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.BGColor,
//       appBar: APPBar(title: "${widget.name}"),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 0),
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: TextField(
//                   controller: search,
//                   keyboardType: TextInputType.text,
//                   onChanged: (value) {
//                     // getSearch(controller.text);
//                     if (_debounce?.isActive ?? false) {
//                       _debounce!.cancel();
//                     }
//                     _debounce = Timer(
//                       const Duration(milliseconds: 1000),
//                           () {
//                         if (value.isNotEmpty) {
//                           searchWithFilter(value);
//                         } else {
//                           setState(() {
//                             searchlist = [];
//                           });
//                         }
//                       },
//                     );
//                   },
//                   decoration: InputDecoration(
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.all(20),
//                         child: SvgPicture.asset(AppImages.search),
//                       ),
//
//                       contentPadding: EdgeInsets.all(10),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(color: Colors.grey, width: 0.25),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:
//                         const BorderSide(color: Colors.white, width: 0.25),
//                       ),
//                       filled: true,
//                       border: InputBorder.none,
//                       fillColor: Color(0xffEEEEEE),
//                       hintText: "Search For Service"),
//                 ),
//               ),
//               // textAreasearch(
//               //   search,
//               //   'Search ',
//               // ),
//
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Container(
//                       padding: EdgeInsets.only(left: 15, right: 15),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.primary),
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                       height: 35,
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(AppImages.filter),
//                             SizedBox(width: 5),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(filterscreen());
//                               },
//                               child: Text(
//                                 "Filter",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: "OpenSans",
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width/2),
//                   GestureDetector(
//                     onTap: () {
//                       search.clear();
//                     },
//                     child: Text(
//                       "Clear All",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: "OpenSans",
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 15,),
//               Text("  Showing ${data?.length} results"),
//               SizedBox(height: 15,),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(16))
//                 ),
//                 //height: 550,
//                 child: FutureBuilder<ProviderModel?>(
//                     future: allserviceCategory,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Text(
//                               '${snapshot.error} occurred',
//                               style: const TextStyle(fontSize: 18),
//                             ),
//                           );
//                         } else if (snapshot.hasData || snapshot.data!.data!.isNotEmpty) {
//
//     return Center(child: Text('No items found.'));
//
//     } else {
//                           return searchlist.isEmpty?ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: snapshot.data!.data!.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return searchText == "" ||
//                                     (searchText != "" &&
//                                         snapshot
//                                             .data!.data![index].serviceName!
//                                             .contains(searchText))
//                                     ? GestureDetector(
//                                   onTap: (){
//                                     CommonBottomSheet.show(context,snapshot.data!.data![index].providerId.toString(),snapshot.data!.data![index].serviceId.toString(),"service","");
//
//
//                                   },
//                                   child: Container(
//                                       padding: EdgeInsets.all(10),
//
//
//                                       child:Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 40,
//                                                 backgroundImage: NetworkImage(
//                                                   "${snapshot.data!.data![index].service_attachment}",
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10,),
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   boldtext(
//                                                     AppColors.black,
//                                                     14,
//                                                     "Service: ${snapshot.data!.data![index].serviceName}",
//                                                   ),
//                                                   boldtext(
//                                                     AppColors.blackShade3,
//                                                     12,
//                                                     "Provider: ${snapshot.data!.data![index].displayName}",
//                                                   ),
//                                                   StarsView(
//                                                       total: 5,
//                                                       colored: double.parse(snapshot
//                                                           .data!
//                                                           .data![index]
//                                                           .rating
//                                                           .toString())
//                                                           .toInt(),
//                                                       ontap: () {
//                                                         Get.to(() =>
//                                                             RatingandReviewByUserScreens(
//                                                               isProduct: false,
//                                                               user_id: UserId,
//                                                               serviceOrProductId:
//                                                               snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .serviceId
//                                                                   .toString(),
//                                                               providerId: snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .providerId
//                                                                   .toString(),
//                                                             ));
//                                                       })
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(height: 10,),
//                                           Divider(height: 1,thickness: 1,)
//                                         ],
//                                       )
//                                   ),
//                                 )
//                                     : SizedBox.shrink();
//                               }):
//                           ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: searchlist.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return searchText == "" ||
//                                     (searchText != "" &&
//                                         snapshot
//                                             .data!.data![index].serviceName!
//                                             .contains(searchText))
//                                     ? GestureDetector(
//                                   onTap: (){
//                                     CommonBottomSheet.show(context,snapshot.data!.data![index].providerId.toString(),snapshot.data!.data![index].serviceId.toString(),"service","");
//
//
//                                   },
//                                   child: Container(
//                                       padding: EdgeInsets.all(10),
//
//
//                                       child:Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 40,
//                                                 backgroundImage: NetworkImage(
//                                                   "${searchlist[index].profileImage}",
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10,),
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   boldtext(
//                                                     AppColors.black,
//                                                     14,
//                                                     "Service: ${searchlist[index].subCategoryName}",
//                                                   ),
//                                                   boldtext(
//                                                     AppColors.blackShade3,
//                                                     12,
//                                                     "Provider: ${searchlist[index].name}",
//                                                   ),
//                                                   StarsView(
//                                                       total: 5,
//                                                       colored: double.parse(searchlist[index]
//                                                           .rating
//                                                           .toString())
//                                                           .toInt(),
//                                                       ontap: () {
//                                                         Get.to(() =>
//                                                             RatingandReviewByUserScreens(
//                                                               isProduct: false,
//                                                               user_id: UserId,
//                                                               serviceOrProductId:
//                                                               searchlist[index]
//                                                                   .typeId
//                                                                   .toString(),
//                                                               providerId: searchlist[index]
//                                                                   .typeId
//                                                                   .toString(),
//                                                             ));
//                                                       })
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(height: 10,),
//                                           Divider(height: 1,thickness: 1,)
//                                         ],
//                                       )
//                                   ),
//                                 )
//                                     : SizedBox.shrink();
//                               });
//                         }
//                       }
//
//
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//   // onSearchTextChanged(String text) async {
//   //   print(text);
//   //   searchlist.clear();
//   //   if (text.isEmpty) {
//   //     setState(() {});
//   //     return;
//   //   }
//   //
//   //   allserviceCategory1.forEach((userDetail) {
//   //     if (userDetail.displayName!.isCaseInsensitiveContains(text) || userDetail.companyName!.isCaseInsensitiveContains(text))
//   //       searchlist.add(userDetail);
//   //   });
//   //   print(searchlist.length);
//   //
//   //   setState(() {});
//   // }
//
//   searchWithFilter(String value) async {
//     searchlist = [];
//     try {
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse(ApiUrl.searchFilterUrl),
//       );
//       request.fields['text'] = value;
//       if (categoryIdList != []) {
//         for (var i = 0; i < categoryIdList.length; i++) {
//           request.fields['category_id[$i]'] = categoryIdList[i].toString();
//         }
//       }
//       if (ratingValue != null) {
//         request.fields['rating'] = ratingValue ?? '';
//       }
//       if (startPrice != null) {
//         request.fields['min_price'] =  startPrice.toString() ??  '';
//       }
//       if (endPrice != null) {
//         request.fields['max_price'] = endPrice.toString() ??  '';
//       }
//       if (lat != null) {
//         request.fields['latitude'] = lat.toString() ?? '';
//       }
//       if (lng != null) {
//         request.fields['longitude'] = lng.toString() ?? '';
//       }
//       if (openAt != null) {
//         request.fields['open_at'] = openAt ?? '';
//       }
//       if (closeAt != null) {
//         request.fields['close_at'] = closeAt ?? '';
//       }
//       final response = await request.send();
//       final data = await http.Response.fromStream(response);
//       print(data.body);
//       print(data.statusCode);
//       if (response.statusCode == 200) {
//         Serchlistmodel vehicalTypeModel =
//         Serchlistmodel.fromJson(jsonDecode(data.body));
//         searchlist = vehicalTypeModel.data;
//         setState(() {});
//       } else {}
//     } catch (e) {
//       print(e);
//     }
//   }
//
//
//
//
//
//
// }
// Widget textAreasearch(TextEditingController controller, String hint, {double? width}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         margin: const EdgeInsets.symmetric(horizontal: 0),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: TextField(
//           minLines: hint.contains("Description")?5:1,
//           maxLines: hint.contains("Description")?5:1,
//           controller: controller,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: SvgPicture.asset(AppImages.search),
//               ),
//
//               contentPadding: EdgeInsets.all(10),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: const BorderSide(color: Colors.grey, width: 0.25),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide:
//                 const BorderSide(color: Colors.white, width: 0.25),
//               ),
//               filled: true,
//               border: InputBorder.none,
//               fillColor: Color(0xffEEEEEE),
//               hintText: hint),
//         ),
//       ),
//     ],
//   );
// }
