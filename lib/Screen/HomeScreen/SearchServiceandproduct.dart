// // // ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, must_be_immutable
// //
// // import 'dart:convert';
// //
// // import 'package:businessgym/Screens/RatingandReviewByUserScreens.dart';
// // import 'package:businessgym/Screens/globalWidgets/appbar_global.dart';
// // import 'package:businessgym/Screens/view_profile_on_service.dart';
// // import 'package:businessgym/model/SupplierServiceSubCategoryListModel.dart';
// // import 'package:businessgym/values/const_text.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:intl/intl.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // import '../../../Utils/ApiUrl.dart';
// // import '../../../Utils/SharedPreferences.dart';
// // import '../../../Utils/common_route.dart';
// // import '../../../model/AddCallModel.dart';
// // import '../../../model/ProviderModel.dart';
// // import '../../../values/Colors.dart';
// // import '../../../values/assets.dart';
// // import '../../globalWidgets/global_values.dart';
// // import '../../globalWidgets/stars_view.dart';
// // import '../../homepage/widgets/viewprofileSearch.dart';
// //
// // class SubCategoryScreen extends StatefulWidget {
// //   int? id;
// //   String? name;
// //   String? categoryImage;
// //   bool? isSupplier;
// //   SubCategoryScreen(this.id, this.name, this.categoryImage, this.isSupplier);
// //
// //   @override
// //   SubCategoryScreenState createState() => SubCategoryScreenState();
// // }
// //
// // class SubCategoryScreenState extends State<SubCategoryScreen> {
// //   Future<ProviderModel?>? allserviceCategory;
// //   SharedPreference _sharedPreference = new SharedPreference();
// //   String? UserId;
// //   String? cdate;
// //
// //   String? Number;
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     getUserType();
// //
// //     print("id========${widget.id}");
// //     print("name========${widget.name}");
// //     print("supplier========${widget.isSupplier}");
// //     print("supplier========${userType}");
// //
// //     userid();
// //     setState(() {});
// //   }
// //
// //   Future<void> userid() async {
// //     UserId = await _sharedPreference.isUsetId();
// //     // print("Ashish" + UserId!);
// //     cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
// //     allserviceCategory = getAllserviceCategory(UserId!);
// //     setState(() {});
// //   }
// //
// //   String searchText = "";
// //   SupplierServiceSubCategoryListModel? supplierServiceSubCategoryListModel;
// //   Future<ProviderModel?> getAllserviceCategory(String UserId) async {
// //     print('ID================>${widget.id}');
// //
// //     try {
// //       //showLoader(context);
// //
// //       String id = widget.id.toString();
// //       print(id);
// //       print(widget.isSupplier);
// //       String type = await _sharedPreference.isUserType();
// //
// //       final response = widget.isSupplier == true //type == 'supplier' //
// //           ? await http.post(
// //               Uri.parse(
// //                 ApiUrl.SupplierServiceBySubCategoryID,
// //               ),
// //               headers: {"Authorization": USERTOKKEN.toString()},
// //               body: {"subcategory_id": widget.id.toString()})
// //           : await http.get(
// //               Uri.parse(
// //                 ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId",
// //               ),
// //             );
// //
// //       print("Success==== ${response.body}" +
// //           ApiUrl.provider_list +
// //           "?subcategory_id=$id&user_id=$UserId");
// //       Map<String, dynamic> map = json.decode(response.body);
// //       if (response.statusCode == 200) {
// //         if (type == 'supplier') {
// //           supplierServiceSubCategoryListModel =
// //               SupplierServiceSubCategoryListModel.fromJson(map);
// //         }
// //         ProviderModel? allServiceModel =
// //             ProviderModel.fromJson(jsonDecode(response.body));
// //         setState(() {});
// //         return allServiceModel;
// //       } else {
// //         hideLoader();
// //         print("Something went wronge");
// //       }
// //     } catch (e) {
// //       print("data===$e");
// //     }
// //   }
// //
// //   String? userType;
// //   getUserType() async {
// //     await _sharedPreference.isUserType().then((value) {
// //       print('USER TYPE =============>$value');
// //       userType = value;
// //     });
// //   }
// //
// //   Future<bool?> addcallloges(String userId, String serviceid, String cdate,
// //       String providerId, String number) async {
// //     try {
// //       // showLoader(context);
// //       print(userId);
// //       String type = await _sharedPreference.isUserType();
// //       // print(type);
// //       Map<String, String> requestBody = USER_TYPE == "supplier"
// //           ? {
// //               "supplier_id": providerId,
// //               'date':
// //                   DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
// //               'service_id': serviceid
// //             }
// //           : {
// //               "provider_id": providerId,
// //               "service_id": serviceid,
// //               "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
// //             };
// //
// //       print(requestBody);
// //       final response = type == "user" || type == "provider"
// //           ? await http.post(
// //               Uri.parse(ApiUrl.add_call_logs),
// //               headers: {"Authorization": USERTOKKEN.toString()},
// //               body: requestBody,
// //             )
// //           : await http.post(
// //               Uri.parse(ApiUrl.add_supplier_call_logs),
// //               headers: {"Authorization": USERTOKKEN.toString()},
// //               body: requestBody,
// //             );
// //       Map<String, dynamic> map = json.decode(response.body);
// //
// //       print("call log response" + response.body.toString());
// //
// //       if (response.statusCode == 200) {
// //         print('<==========_ ADD CALL LOG _===========>');
// //         print(response.body);
// //         hideLoader();
// //
// //         AddCallModel? addCallModel =
// //             AddCallModel.fromJson(jsonDecode(response.body));
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text("${addCallModel.message}"),
// //         ));
// //
// //         // _launchPhoneURL(number);
// //
// //         return true;
// //       } else {
// //         print("Something went wrong");
// //         return false;
// //       }
// //     } catch (e) {
// //       print("data==1=$e");
// //     }
// //   }
// //
// //   _launchPhoneURL(String phoneNumber) async {
// //     Uri phoneno = Uri.parse('tel:+$phoneNumber');
// //     if (await launchUrl(phoneno)) {
// //     } else {}
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.white,
// //       appBar: APPBar(title: "${widget.name}"),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           margin: const EdgeInsets.all(15),
// //           child: Column(
// //             children: [
// //               Container(
// //                 height: 45,
// //                 margin: const EdgeInsets.all(10),
// //                 child: Material(
// //                   elevation: 4,
// //                   borderRadius: BorderRadius.circular(8),
// //                   color: Colors.white,
// //                   child: Center(
// //                     child: TextField(
// //                       onChanged: (value) {
// //                         setState(() {
// //                           searchText = value;
// //                         });
// //                       },
// //                       style: const TextStyle(
// //                           color: Colors.black, fontFamily: "caviarbold"),
// //                       decoration: InputDecoration(
// //                         hintText: "Search ....",
// //                         hintStyle: const TextStyle(
// //                             color: Color(0xff808080), fontFamily: 'caviarbold'),
// //                         fillColor: Colors.white,
// //                         filled: true,
// //                         focusColor: Colors.white,
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                           borderSide: const BorderSide(
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                           borderSide: const BorderSide(
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         prefixIcon: const Icon(Icons.search),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 //height: 550,
// //                 child: FutureBuilder<ProviderModel?>(
// //                     future: allserviceCategory,
// //                     builder: (context, snapshot) {
// //                       if (snapshot.connectionState == ConnectionState.done) {
// //                         if (snapshot.hasError) {
// //                           return Center(
// //                             child: Text(
// //                               '${snapshot.error} occurred',
// //                               style: const TextStyle(fontSize: 18),
// //                             ),
// //                           );
// //                         } else if (snapshot.hasData) {
// //                           return ListView.builder(
// //                               shrinkWrap: true,
// //                               itemCount: snapshot.data!.data!.length,
// //                               physics: const NeverScrollableScrollPhysics(),
// //                               itemBuilder: (BuildContext context, int index) {
// //                                 return searchText == "" ||
// //                                         (searchText != "" &&
// //                                             snapshot
// //                                                 .data!.data![index].serviceName!
// //                                                 .contains(searchText))
// //                                     ? userType == "supplier"
// //                                         ? Card(
// //                                             color: index > 10
// //                                                 ? colorList[
// //                                                     index.remainder(10).abs()]
// //                                                 : colorList[index],
// //                                             margin: const EdgeInsets.all(
// //                                               10,
// //                                             ),
// //                                             elevation: 4,
// //                                             child: InkWell(
// //                                               onTap: () {
// //                                                 Get.to(
// //                                                   () => ViewProfileOnService(
// //                                                     rating: 0,
// //                                                     profilePic: '',
// //                                                     name:
// //                                                         supplierServiceSubCategoryListModel
// //                                                                 ?.data?[index]
// //                                                                 .name ??
// //                                                             '',
// //                                                     userType: userType,
// //                                                     mobileNumber:
// //                                                         supplierServiceSubCategoryListModel
// //                                                             ?.data?[index]
// //                                                             .mobile,
// //                                                     id: supplierServiceSubCategoryListModel
// //                                                         ?.data?[index].id
// //                                                         .toString()!,
// //                                                     providerId:
// //                                                         supplierServiceSubCategoryListModel
// //                                                             ?.data?[index]
// //                                                             .providerId
// //                                                             .toString(),
// //                                                     data:
// //                                                         supplierServiceSubCategoryListModel
// //                                                             ?.data?[index],
// //                                                     userId: '',
// //                                                     productView: false,
// //                                                     isSupplier:
// //                                                         widget.isSupplier,
// //                                                   ),
// //                                                 );
// //                                               },
// //                                               child: ListTile(
// //                                                 contentPadding:
// //                                                     const EdgeInsets.symmetric(
// //                                                         vertical: 10),
// //                                                 leading: const CircleAvatar(
// //                                                   radius: 40,
// //                                                   backgroundImage: NetworkImage(
// //                                                       ''
// //                                                       // "${supplierServiceSubCategoryListModel?.data?[index].}",
// //                                                       ),
// //                                                 ),
// //                                                 title: boldtext(
// //                                                   AppColors.black,
// //                                                   13,
// //                                                   "${supplierServiceSubCategoryListModel?.data?[index].name}",
// //                                                 ),
// //                                                 subtitle: boldtext(
// //                                                   AppColors.blackShade3,
// //                                                   12,
// //                                                   "${supplierServiceSubCategoryListModel?.data?[index].description}",
// //                                                 ),
// //                                                 trailing: IconButton(
// //                                                     onPressed: () async {
// //                                                       if (supplierServiceSubCategoryListModel
// //                                                               ?.data?[index]
// //                                                               .mobile ==
// //                                                           null) {
// //                                                         ScaffoldMessenger.of(
// //                                                                 context)
// //                                                             .showSnackBar(
// //                                                           const SnackBar(
// //                                                             content: Text(
// //                                                                 'Mobile number not available'),
// //                                                           ),
// //                                                         );
// //                                                       } else {
// //                                                         await addcallloges(
// //                                                                 UserId!,
// //                                                                 supplierServiceSubCategoryListModel
// //                                                                         ?.data?[
// //                                                                             index]
// //                                                                         .providerId
// //                                                                         .toString() ??
// //                                                                     '',
// //                                                                 cdate!,
// //                                                                 supplierServiceSubCategoryListModel
// //                                                                         ?.data?[
// //                                                                             index]
// //                                                                         .providerId
// //                                                                         .toString() ??
// //                                                                     '',
// //                                                                 supplierServiceSubCategoryListModel
// //                                                                         ?.data?[
// //                                                                             index]
// //                                                                         .mobile ??
// //                                                                     "")
// //                                                             .then((value) =>
// //                                                                 _launchPhoneURL(snapshot
// //                                                                     .data!
// //                                                                     .data![
// //                                                                         index]
// //                                                                     .contactNumber
// //                                                                     .toString()));
// //                                                       }
// //                                                     },
// //                                                     icon: Image.asset(AppImages
// //                                                         .HOME_MYSERVICE)),
// //                                               ),
// //                                             ),
// //                                           )
// //                                         : Card(
// //                                             color: index > 10
// //                                                 ? colorList[
// //                                                     index.remainder(10).abs()]
// //                                                 : colorList[index],
// //                                             margin: const EdgeInsets.all(
// //                                               10,
// //                                             ),
// //                                             elevation: 4,
// //                                             child: InkWell(
// //                                               onTap: () {
// //                                                 Get.to(
// //                                                   () => ViewProfileOnService(
// //                                                     profilePic: snapshot
// //                                                             .data!
// //                                                             .data![index]
// //                                                             .profile_pic ??
// //                                                         '',
// //                                                     rating: snapshot.data!
// //                                                         .data![index].rating,
// //                                                     mobileNumber: snapshot
// //                                                         .data!
// //                                                         .data![index]
// //                                                         .contactNumber,
// //                                                     id: snapshot.data!
// //                                                         .data![index].serviceId
// //                                                         .toString(),
// //                                                     providerId: snapshot.data!
// //                                                         .data![index].providerId
// //                                                         .toString(),
// //                                                     data: snapshot
// //                                                         .data!.data![index],
// //                                                     userId: snapshot.data!
// //                                                         .data![index].user_id
// //                                                         .toString(),
// //                                                     productView: false,
// //                                                     isSupplier:
// //                                                         widget.isSupplier,
// //                                                   ),
// //                                                 );
// //                                               },
// //                                               child: ListTile(
// //                                                 contentPadding:
// //                                                     const EdgeInsets.symmetric(
// //                                                         vertical: 10),
// //                                                 leading: CircleAvatar(
// //                                                   radius: 40,
// //                                                   backgroundImage: NetworkImage(
// //                                                     "${snapshot.data!.data![index].service_attachment}",
// //                                                   ),
// //                                                 ),
// //                                                 title: boldtext(
// //                                                   AppColors.black,
// //                                                   13,
// //                                                   "Service: ${snapshot.data!.data![index].serviceName}",
// //                                                 ),
// //                                                 subtitle: Column(
// //                                                   crossAxisAlignment:
// //                                                       CrossAxisAlignment.start,
// //                                                   children: [
// //                                                     boldtext(
// //                                                       AppColors.blackShade3,
// //                                                       12,
// //                                                       "Provider: ${snapshot.data!.data![index].displayName}",
// //                                                     ),
// //                                                     StarsView(
// //                                                         total: 5,
// //                                                         colored: double.parse(
// //                                                                 snapshot
// //                                                                     .data!
// //                                                                     .data![
// //                                                                         index]
// //                                                                     .rating
// //                                                                     .toString())
// //                                                             .toInt(),
// //                                                         ontap: () {
// //                                                           Get.to(
// //                                                             () =>
// //                                                                 RatingandReviewByUserScreens(
// //                                                               user_id: UserId,
// //                                                               providerId: snapshot
// //                                                                   .data!
// //                                                                   .data![index]
// //                                                                   .providerId
// //                                                                   .toString(),
// //                                                             ),
// //                                                           );
// //                                                         })
// //                                                   ],
// //                                                 ),
// //                                                 trailing: IconButton(
// //                                                     onPressed: () async {
// //                                                       await addcallloges(
// //                                                               UserId!,
// //                                                               snapshot
// //                                                                   .data!
// //                                                                   .data![index]
// //                                                                   .serviceId
// //                                                                   .toString(),
// //                                                               cdate!,
// //                                                               snapshot
// //                                                                   .data!
// //                                                                   .data![index]
// //                                                                   .providerId
// //                                                                   .toString(),
// //                                                               snapshot
// //                                                                   .data!
// //                                                                   .data![index]
// //                                                                   .contactNumber
// //                                                                   .toString())
// //                                                           .then((value) =>
// //                                                               _launchPhoneURL(snapshot
// //                                                                   .data!
// //                                                                   .data![index]
// //                                                                   .contactNumber
// //                                                                   .toString()));
// //                                                     },
// //                                                     icon: Image.asset(AppImages
// //                                                         .HOME_MYSERVICE)),
// //                                               ),
// //                                             ),
// //                                           )
// //                                     : const SizedBox.shrink();
// //                               });
// //                         }
// //                       }
// //
// //                       // Displaying LoadingSpinner to indicate waiting state
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, must_be_immutable
//
// import 'dart:convert';
// import 'package:businessgym/Screen/ProfileScreen/SubCategoryScreen.dart';
// import 'package:businessgym/conts/appbar_global.dart';
// import 'package:businessgym/conts/global_values.dart';
// import 'package:businessgym/conts/stars_view.dart';
// import 'package:businessgym/conts/filter_screen.dart';
// import 'package:businessgym/model/AllServiceModel.dart';
// import 'package:businessgym/model/ProductSellerModel.dart';
// import 'package:businessgym/model/ServiceProvider.dart';
// import 'package:businessgym/model/getproductbyuserid.dart';
// import 'package:businessgym/model/getservicebyuserid.dart';
// import 'package:businessgym/values/const_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../Utils/ApiUrl.dart';
// import '../../../../Utils/SharedPreferences.dart';
// import '../../../../Utils/common_route.dart';
// import '../../../../values/Colors.dart';
// import '../../../../values/assets.dart';
//
// class searchserviceandproductScreen extends StatefulWidget {
//   bool? appbar;
//   searchserviceandproductScreen(this.appbar);
//
//
//
//   @override
//   _searchserviceandproductScreenState createState() => _searchserviceandproductScreenState();
// }
//
// class _searchserviceandproductScreenState extends State<searchserviceandproductScreen> {
//   TextEditingController search=TextEditingController();
//   // Future<ProviderModel?>? allserviceCategory;
//   SharedPreference _sharedPreference = new SharedPreference();
//   String? UserId;
//   String? cdate;
//   int listToShow = 0;
//   String? Number;
//   //Future<List<ProductSellerList>?>? listData1;
//   List<AllProductModeldata>? productsellerdata = [];
//   List<AllServiceModelData>  serviceproviderdata=[];
//   Future<List<Getservicebyuseriddata?>?>? servicebyid;
//   List<Getservicebyuseriddata>? servicebyiddata = [];
//   Future<List<GetproductbyuseridData?>?>? productbyid;
//   List<GetproductbyuseridData>? productbyiddata = [];
//
//   @override
//   void initState() {
//     getuserType();
//     super.initState();
//   }
//   @override
//
//   Future<List<AllProductModeldata?>?>? getproductseller() async {
//     try {
//       print(ApiUrl.getprovideproduct);
//       showLoader(context);
//       final response = await http.get(
//         Uri.parse(ApiUrl.getprovideproduct),
//         headers: {"Authorization": USERTOKKEN.toString()},
//       );
//       print("response data my news ================="+response.body);
//       //  Map<String, dynamic> map = json.decode(response.body);
//       if (response.statusCode == 200) {
//         hideLoader();
//         AllProductModel? viewNewsModel = AllProductModel.fromJson(jsonDecode(response.body));
//         productsellerdata = viewNewsModel.data!;
//         setState(() {
//         });
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
//   Future<List<AllServiceModelData>?> getserviceprovider() async {
//     try {
//       print(ApiUrl.getservicecategory);
//       showLoader(context);
//
//
//
//       final response = await http.get(
//         Uri.parse(ApiUrl.getservicecategory),
//         headers: {"Authorization": USERTOKKEN.toString()},
//       );
//
//       print("response data my news ================="+response.body);
//       //  Map<String, dynamic> map = json.decode(response.body);
//
//
//
//       if (response.statusCode == 200) {
//
//         hideLoader();
//
//
//         AllServiceModel? viewNewsModel = AllServiceModel.fromJson(jsonDecode(response.body));
//         serviceproviderdata = viewNewsModel.data!;
//         setState(() {
//
//
//         });
//
//         print("Success");
//
//
//         return viewNewsModel.data!;
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
//   String searchText = "";
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.BGColor,
//       appBar: widget.appbar == false ? null : APPBar(title: 'Search Service'),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               textAreasearch(
//                 search,
//                 'Search ',
//               ),
//               SizedBox(height: 15,),
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount:serviceproviderdata.length,
//                 itemBuilder: (context,index){
//                   return Container(
//                     padding: EdgeInsets.only(left: 16,right: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20,),
//                         boldtext(Colors.black,16,serviceproviderdata[index].name!),
//                         SizedBox(height: 20,),
//                         Container(
//                             child:  GridView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: NeverScrollableScrollPhysics(),
//
//                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
//                                   childAspectRatio: MediaQuery.of(context).size.width /
//                                       (MediaQuery.of(context).size.height / 5),
//                                   mainAxisSpacing: 5.0,
//                                   crossAxisSpacing: 5.0,),
//                                 itemCount:serviceproviderdata[index].subData!.length ,
//                                 itemBuilder: (context,position){
//                                   return GestureDetector(
//                                     onTap: (){
//                                       Get.to(
//                                             () => SubCategoryScreen(
//                                               serviceproviderdata[index].subData![position]
//                                               .id,
//                                               serviceproviderdata[index].subData![position]
//                                               .name,
//                                               serviceproviderdata[index].subData![position]
//                                               .categoryImage,
//                                           false,
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                         padding: EdgeInsets.all(5),
//
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.all(Radius.circular(50))
//                                         ),
//                                         child: Center(
//                                           child: Text( serviceproviderdata[index].subData![position].name!),
//                                         )
//                                     ),
//                                   );
//                                 })
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//               ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount:productsellerdata!.length,
//                   itemBuilder: (context,index){
//                     return Container(
//                       padding: EdgeInsets.only(left: 16,right: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 20,),
//                           boldtext(Colors.black,16,productsellerdata![index].name!),
//                           SizedBox(height: 20,),
//                           Container(
//                               child:  GridView.builder(
//                                   physics: NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   padding: EdgeInsets.zero,
//
//                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
//                                     childAspectRatio: MediaQuery.of(context).size.width /
//                                         (MediaQuery.of(context).size.height / 5),
//                                     mainAxisSpacing: 5.0,
//                                     crossAxisSpacing: 5.0,),
//                                   itemCount:productsellerdata![index].subData!.length ,
//                                   itemBuilder: (context,position){
//                                     return GestureDetector(
//                                       onTap: (){
//                                         Get.to(
//                                               () => SubCategoryScreen(
//                                                 productsellerdata![index].subData![position]
//                                                 .id,
//                                                 productsellerdata![index].subData![position]
//                                                 .name,
//                                                 productsellerdata![index]
//                                                 .categoryImage,
//                                             false,
//                                           ),
//                                         );
//                                       },
//                                       child: Container(
//                                           padding: EdgeInsets.all(5),
//
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.all(Radius.circular(50))
//                                           ),
//                                           child: Center(
//                                             child: Text( productsellerdata![index].subData![position].name!),
//                                           )
//                                       ),
//                                     );
//                                   })
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(16))
//                 ),
//                 //height: 550,
//
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getuserType() async {
//     // usertype = await _sharedPreference.isUserType();
//     UserId = await _sharedPreference.isUsetId();
//     // usertoken = await _sharedPreference.isToken();
//     print("Ashish" + UserId!);
//     getproductseller();
//     getserviceprovider();
//   }
//
//   void _bottomSheet1(context,ServiceProviderdata search){
//     showModalBottomSheet(context: context,
//         isScrollControlled: true,
//         constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width,
//             MediaQuery.of(context).size.height * .8)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
//         builder: (BuildContext bc) {
//           return  StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
//             return Scaffold(
//               backgroundColor: Colors.transparent,
//               body: SingleChildScrollView(
//                 physics: NeverScrollableScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height,
//                       child:  Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 50),
//                             child: Column(
//                               children: [
//                                 Text("${search.firstName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "OpenSans"),),
//                                 Text( "${search.address==null?"-":search.address}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",color: Color(0xff656565)),),
//                                 SizedBox(height: 10,),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 100,right: 100,top: 10),
//                                   padding: EdgeInsets.all(11),
//                                   height: 45,
//
//                                   decoration: BoxDecoration(
//                                       color: Color(0xffF1FAFF),
//                                       borderRadius: BorderRadius.all(Radius.circular(17))
//                                   ),
//                                   child:  InkWell(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: [
//                                         RatingBarIndicator(
//                                           direction: Axis
//                                               .horizontal,
//                                           rating: search.providersServiceRating==null?0:double
//                                               .parse(
//                                             "${search.providersServiceRating}",),
//                                           itemCount: 5,
//                                           itemSize: 14,
//                                           itemPadding:
//                                           const EdgeInsets
//                                               .all(2),
//                                           unratedColor:
//                                           Colors.grey,
//                                           itemBuilder:
//                                               (context,
//                                               _) =>
//                                               SvgPicture.asset(AppImages.rating),
//                                         ),
//
//                                         boldtext(Color(0xff656565), 12,
//                                             search.providersServiceRating==null?'0 Rating':  '${search.providersServiceRating} Rating')
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Container(
//                                     margin: EdgeInsets.only(left: 10,right: 10,top: 10),
//
//
//
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           SizedBox(height: 10,),
//                                           Container(
//                                             margin: EdgeInsets.only(left: 15,right: 15),
//                                             padding: EdgeInsets.all(11),
//                                             height: 55,
//                                             decoration: BoxDecoration(
//                                                 color: Color(0xffF0F0F0),
//                                                 borderRadius: BorderRadius.all(Radius.circular(28))
//                                             ),
//                                             child:   Row(
//                                               children: [
//                                                 Expanded(child:  Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:50,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ? AppColors.white
//                                                         : listToShow == 1
//                                                         ? Color(0xffF0F0F0)
//                                                         : Color(0xffF0F0F0),
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child:  GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 0;
//                                                         });
//                                                         print(listToShow);
//                                                         //setEvents();
//                                                       },
//                                                       child: Center(
//                                                         child:  Text(
//                                                           "Overview",
//                                                           style: TextStyle(color: listToShow == 0
//                                                               ? AppColors.blue
//                                                               : listToShow == 1
//                                                               ? AppColors.black
//                                                               : AppColors.black,),
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ),),
//                                                 SizedBox(width: 2,),
//                                                 Expanded(child: Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:30,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ? Color(0xffF0F0F0)
//                                                         : listToShow == 1
//                                                         ?  AppColors.white
//                                                         : Color(0xffF0F0F0),
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child: GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 1;
//                                                         });
//                                                         print(listToShow);
//                                                         //setEvents();
//                                                       },
//                                                       child:  Center(
//                                                         child:  Text(
//                                                           "Services", style: TextStyle(color: listToShow == 0
//                                                             ? AppColors.black
//                                                             : listToShow == 1
//                                                             ? AppColors.blue
//                                                             : AppColors.black,),
//
//
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ),),
//                                                 SizedBox(width: 2,),
//                                                 Expanded(child: Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:30,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ?  Color(0xffF0F0F0)
//                                                         : listToShow == 1
//                                                         ?  Color(0xffF0F0F0)
//                                                         : AppColors.white,
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child:
//                                                   GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 2;
//                                                         });
//                                                         print(listToShow);
//
//                                                         //setEvents();
//                                                       },
//                                                       child:  Center(
//                                                         child:  Text(
//                                                           "Product" ,style: TextStyle(color: listToShow == 0
//                                                             ? AppColors.black
//                                                             : listToShow == 1
//                                                             ? AppColors.black
//                                                             : AppColors.blue,),
//
//
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ))
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(height: 10,),
//                                           Container(
//                                               height: 350,
//                                               child:  listToShow==0? Container(
//
//                                                 padding: EdgeInsets.only(left: 16),
//                                                 width: MediaQuery.of(context).size.width,
//                                                 child: Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     regulartext( Color(0xffA6A6A6), 12,"Contact no.",),
//                                                     boldtext(Colors.black,14,"${search.contactNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Email id",),
//                                                     boldtext(Colors.black,14,"${search.email==null?"-":search.email}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Address",),
//                                                     boldtext(Colors.black,14,"${search.address==null?"-":search.address}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"GST no.",),
//                                                     boldtext(Colors.black,14,"${search.gstNumber==null?"-":search.gstNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"FSSAI no.",),
//                                                     boldtext(Colors.black,14,"${search.fassaiNumber==null?"-":search.fassaiNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Working hour",),
//                                                     boldtext(Colors.black,14,"${search.workingHours==0?"-":search.workingHours}",),
//                                                     SizedBox(height: 20,),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       children: [
//                                                         Expanded(child: Container(
//                                                           height: 50,
//                                                           child: ElevatedButton.icon(
//
//                                                               style: ElevatedButton.styleFrom(
//                                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//                                                                   backgroundColor: Color(0xff25D366)
//                                                               ),
//                                                               onPressed: () async {
//                                                                 var url =
//                                                                     'https://api.whatsapp.com/send?phone=+91${search.contactNumber.substring(3,12)}&text';
//                                                                 await launch(url);
//                                                               },
//                                                               icon: SvgPicture.asset(AppImages.whatsapp,color: AppColors.white,),
//                                                               label:Text("Whatsapp",style: TextStyle(
//                                                                   fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//                                                                   color: Colors.white
//                                                               ),)),
//                                                         )),
//                                                         SizedBox(width: 10,),
//                                                         Expanded(
//                                                             child: Container(
//                                                               height: 50,
//                                                               child: ElevatedButton.icon(
//                                                                   icon: SvgPicture.asset(AppImages.call,color: AppColors.white,),
//                                                                   style: ElevatedButton.styleFrom(
//                                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//                                                                       backgroundColor: AppColors.primary
//                                                                   ),
//                                                                   onPressed: () {
//                                                                     final data = Uri(
//                                                                         scheme: 'tel',
//                                                                         path: '+91${search.contactNumber.substring(3,12)}');
//                                                                     launchUrl(data);
//                                                                   },
//                                                                   label: Text("Call",style: TextStyle(
//                                                                       fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//                                                                       color: Colors.white
//                                                                   ),)),
//                                                             ))
//                                                       ],
//                                                     )
//
//
//                                                   ],
//                                                 ),
//                                               ):listToShow==1?
//                                               SizedBox():SizedBox()
//
//                                           )
//
//                                         ],
//                                       ),
//                                     )
//                                 )
//
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//
//
//
//                     )
//                   ],
//                 ),
//               ),
//
//               floatingActionButton: Row(
//
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: 200,
//                     transform: Matrix4.translationValues(100.0, -100, 0.0),
//                     child: Stack(
//                       children: [
//                         Center(
//                           child:  CircleAvatar(
//                             radius: 50,
//                             backgroundImage: NetworkImage(
//                                 search.profileImage),
//                           ),
//                         ),
//                         Positioned(
//                           left: 110,
//                           top: 130,
//                           child: SvgPicture.asset(AppImages.roundleft),)
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 100),
//                     height: 30,
//                     transform: Matrix4.translationValues(45.0, -120, 0.0),  // translate up by 30
//                     child: FloatingActionButton(
//                       backgroundColor: Colors.white,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(Icons.close_rounded,color: Colors.black,),
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
//             );
//           });
//
//         });
//
//   }
//   void _bottomSheet(context,ProductSellerdata search){
//     showModalBottomSheet(context: context,
//         isScrollControlled: true,
//         constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width,
//             MediaQuery.of(context).size.height * .8)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
//         builder: (BuildContext bc) {
//           return  StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
//             return Scaffold(
//               backgroundColor: Colors.transparent,
//               body: SingleChildScrollView(
//                 physics: NeverScrollableScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height,
//                       child:  Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 50),
//                             child: Column(
//                               children: [
//                                 Text("${search.firstName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "OpenSans"),),
//                                 Text( "${search.address==null?"-":search.address}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",color: Color(0xff656565)),),
//                                 SizedBox(height: 10,),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 100,right: 100,top: 10),
//                                   padding: EdgeInsets.all(11),
//                                   height: 45,
//
//                                   decoration: BoxDecoration(
//                                       color: Color(0xffF1FAFF),
//                                       borderRadius: BorderRadius.all(Radius.circular(17))
//                                   ),
//                                   child:  InkWell(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: [
//                                         RatingBarIndicator(
//                                           direction: Axis
//                                               .horizontal,
//                                           rating: search.providersServiceRating==null?0:double
//                                               .parse(
//                                             "${search.providersServiceRating}",),
//                                           itemCount: 5,
//                                           itemSize: 14,
//                                           itemPadding:
//                                           const EdgeInsets
//                                               .all(2),
//                                           unratedColor:
//                                           Colors.grey,
//                                           itemBuilder:
//                                               (context,
//                                               _) =>
//                                               SvgPicture.asset(AppImages.rating),
//                                         ),
//
//                                         boldtext(Color(0xff656565), 12,
//                                             search.providersServiceRating==null?'0 Rating':  '${search.providersServiceRating} Rating')
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Container(
//                                     margin: EdgeInsets.only(left: 10,right: 10,top: 10),
//
//
//
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           SizedBox(height: 10,),
//                                           Container(
//                                             margin: EdgeInsets.only(left: 15,right: 15),
//                                             padding: EdgeInsets.all(11),
//                                             height: 55,
//                                             decoration: BoxDecoration(
//                                                 color: Color(0xffF0F0F0),
//                                                 borderRadius: BorderRadius.all(Radius.circular(28))
//                                             ),
//                                             child:   Row(
//                                               children: [
//                                                 Expanded(child:  Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:50,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ? AppColors.white
//                                                         : listToShow == 1
//                                                         ? Color(0xffF0F0F0)
//                                                         : Color(0xffF0F0F0),
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child:  GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 0;
//                                                         });
//                                                         print(listToShow);
//                                                         //setEvents();
//                                                       },
//                                                       child: Center(
//                                                         child:  Text(
//                                                           "Overview",
//                                                           style: TextStyle(color: listToShow == 0
//                                                               ? AppColors.blue
//                                                               : listToShow == 1
//                                                               ? AppColors.black
//                                                               : AppColors.black,),
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ),),
//                                                 SizedBox(width: 2,),
//                                                 Expanded(child: Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:30,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ? Color(0xffF0F0F0)
//                                                         : listToShow == 1
//                                                         ?  AppColors.white
//                                                         : Color(0xffF0F0F0),
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child: GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 1;
//                                                         });
//                                                         print(listToShow);
//                                                         // servicebyid = getservicebyid(search.providerId.toString());
//                                                         //setEvents();
//                                                       },
//                                                       child:  Center(
//                                                         child:  Text(
//                                                           "Services", style: TextStyle(color: listToShow == 0
//                                                             ? AppColors.black
//                                                             : listToShow == 1
//                                                             ? AppColors.blue
//                                                             : AppColors.black,),
//
//
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ),),
//                                                 SizedBox(width: 2,),
//                                                 Expanded(child: Container(
//                                                   padding: EdgeInsets.all(4),
//                                                   height:30,
//                                                   decoration: BoxDecoration(
//                                                     color: listToShow == 0
//                                                         ?  Color(0xffF0F0F0)
//                                                         : listToShow == 1
//                                                         ?  Color(0xffF0F0F0)
//                                                         : AppColors.white,
//
//                                                     borderRadius:
//                                                     const BorderRadius.all(Radius.circular(28)),
//
//                                                   ),
//                                                   child:
//                                                   GestureDetector(
//                                                       onTap: ()async{
//                                                         setState(() {
//                                                           listToShow = 2;
//                                                         });
//                                                         print(listToShow);
//                                                         //  productbyid = getproductbyid(search.providerId.toString());
//
//                                                         //setEvents();
//                                                       },
//                                                       child:  Center(
//                                                         child:  Text(
//                                                           "Product" ,style: TextStyle(color: listToShow == 0
//                                                             ? AppColors.black
//                                                             : listToShow == 1
//                                                             ? AppColors.black
//                                                             : AppColors.blue,),
//
//
//                                                         ),
//                                                       )
//                                                   ),
//                                                 ))
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(height: 10,),
//                                           Container(
//                                               height: 350,
//                                               child:  listToShow==0? Container(
//
//                                                 padding: EdgeInsets.only(left: 16),
//                                                 width: MediaQuery.of(context).size.width,
//                                                 child: Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     regulartext( Color(0xffA6A6A6), 12,"Contact no.",),
//                                                     boldtext(Colors.black,14,"${search.contactNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Email id",),
//                                                     boldtext(Colors.black,14,"${search.email}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Address",),
//                                                     boldtext(Colors.black,14,"${search.address}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"GST no.",),
//                                                     boldtext(Colors.black,14,"${search.gstNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"FSSAI no.",),
//                                                     boldtext(Colors.black,14,"${search.fassaiNumber}",),
//                                                     SizedBox(height: 10,),
//                                                     regulartext( Color(0xffA6A6A6), 12,"Working hour",),
//                                                     boldtext(Colors.black,14,"${search.workingHours}",),
//                                                     SizedBox(height: 20,),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       children: [
//                                                         Expanded(child: Container(
//                                                           height: 50,
//                                                           child: ElevatedButton.icon(
//
//                                                               style: ElevatedButton.styleFrom(
//                                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//                                                                   backgroundColor: Color(0xff25D366)
//                                                               ),
//                                                               onPressed: () async {
//                                                                 var url =
//                                                                     'https://api.whatsapp.com/send?phone=+91${search.contactNumber.substring(3,12)}&text';
//                                                                 await launch(url);
//                                                               },
//                                                               icon: SvgPicture.asset(AppImages.whatsapp,color: AppColors.white,),
//                                                               label:Text("Whatsapp",style: TextStyle(
//                                                                   fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//                                                                   color: Colors.white
//                                                               ),)),
//                                                         )),
//                                                         SizedBox(width: 10,),
//                                                         Expanded(
//                                                             child: Container(
//                                                               height: 50,
//                                                               child: ElevatedButton.icon(
//                                                                   icon: SvgPicture.asset(AppImages.call,color: AppColors.white,),
//                                                                   style: ElevatedButton.styleFrom(
//                                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//                                                                       backgroundColor: AppColors.primary
//                                                                   ),
//                                                                   onPressed: () {
//                                                                     final data = Uri(
//                                                                         scheme: 'tel',
//                                                                         path: '+91${search.contactNumber.substring(3,12)}');
//                                                                     launchUrl(data);
//                                                                   },
//                                                                   label: Text("Call",style: TextStyle(
//                                                                       fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//                                                                       color: Colors.white
//                                                                   ),)),
//                                                             ))
//                                                       ],
//                                                     )
//
//
//                                                   ],
//                                                 ),
//                                               ):listToShow==1?SizedBox():SizedBox()
//                                             // ListView.builder(
//                                             //     itemCount:
//                                             //     servicebyiddata!
//                                             //         .length,
//                                             //     shrinkWrap: true,
//                                             //     physics:
//                                             //     const BouncingScrollPhysics(),
//                                             //     itemBuilder:
//                                             //         (context, index) {
//                                             //       return Container(
//                                             //           child: Column(
//                                             //             children: [
//                                             //               Container(
//                                             //                 margin:
//                                             //                 const EdgeInsets
//                                             //                     .all(10),
//                                             //                 child: Row(
//                                             //                   children: [
//                                             //                     Container(
//                                             //                       decoration:
//                                             //                       const BoxDecoration(
//                                             //                         borderRadius:
//                                             //                         BorderRadius.all(Radius.circular(15)),
//                                             //                       ),
//                                             //                       height:
//                                             //                       60,
//                                             //                       width: 60,
//                                             //                       child: ClipRRect(
//                                             //                           borderRadius: const BorderRadius.all(Radius.circular(15)),
//                                             //                           child: Image.network(
//                                             //                             servicebyiddata![index].serviceImage,
//                                             //                             fit:
//                                             //                             BoxFit.cover,
//                                             //                           )),
//                                             //                     ),
//                                             //                     const SizedBox(
//                                             //                       width: 10,
//                                             //                     ),
//                                             //                     Expanded(
//                                             //                       child:
//                                             //                       Column(
//                                             //                         crossAxisAlignment:
//                                             //                         CrossAxisAlignment.start,
//                                             //                         children: [
//                                             //                           regulartext(
//                                             //                               AppColors.hint,
//                                             //                               12,
//                                             //                               servicebyiddata![index].name),
//                                             //                           boldtext(
//                                             //                               AppColors.black,
//                                             //                               14,
//                                             //                               servicebyiddata![index].tag),
//                                             //                         ],
//                                             //                       ),
//                                             //                     ),
//                                             //                     Column(
//                                             //                       crossAxisAlignment:
//                                             //                       CrossAxisAlignment
//                                             //                           .end,
//                                             //                       children: [
//                                             //                         regulartext(
//                                             //                             AppColors.hint,
//                                             //                             12,
//                                             //                             "Price range"),
//                                             //                         boldtext(
//                                             //                             AppColors.black,
//                                             //                             14,
//                                             //                             "${servicebyiddata![index].maxPrice.toString()} to ${servicebyiddata![index].minPrice.toString()} "),
//                                             //                       ],
//                                             //                     )
//                                             //                   ],
//                                             //                 ),
//                                             //               )
//                                             //             ],
//                                             //           ));
//                                             //     }):
//                                             // ListView.builder(
//                                             //     physics:
//                                             //     const BouncingScrollPhysics(),
//                                             //     itemCount:
//                                             //     productbyiddata!
//                                             //         .length,
//                                             //     shrinkWrap: true,
//                                             //     itemBuilder:
//                                             //         (context, index) {
//                                             //       return Container(
//                                             //           margin:
//                                             //           const EdgeInsets
//                                             //               .only(
//                                             //               bottom:
//                                             //               10),
//                                             //           child: Column(
//                                             //             children: [
//                                             //               Container(
//                                             //                 margin:
//                                             //                 const EdgeInsets.all(
//                                             //                     10),
//                                             //                 child: Row(
//                                             //                   children: [
//                                             //                     Container(
//                                             //                       decoration:
//                                             //                       const BoxDecoration(
//                                             //                         borderRadius:
//                                             //                         BorderRadius.all(Radius.circular(15)),
//                                             //                       ),
//                                             //                       height:
//                                             //                       60,
//                                             //                       width:
//                                             //                       60,
//                                             //                       child:
//                                             //                       ClipRRect(
//                                             //                         borderRadius:
//                                             //                         const BorderRadius.all(Radius.circular(15)),
//                                             //                         child:
//                                             //                         Image.network(
//                                             //                           productbyiddata![index].productImage ?? "",
//                                             //                           fit: BoxFit.cover,
//                                             //                         ),
//                                             //                       ),
//                                             //                     ),
//                                             //                     const SizedBox(
//                                             //                       width:
//                                             //                       10,
//                                             //                     ),
//                                             //                     Expanded(
//                                             //                       child:
//                                             //                       Column(
//                                             //                         crossAxisAlignment:
//                                             //                         CrossAxisAlignment.start,
//                                             //                         children: [
//                                             //                           regulartext(AppColors.hint, 12, productbyiddata![index].name!),
//                                             //                           boldtext(AppColors.black, 14, productbyiddata![index].subcategoryId.toString()),
//                                             //                         ],
//                                             //                       ),
//                                             //                     ),
//                                             //                     Column(
//                                             //                       crossAxisAlignment:
//                                             //                       CrossAxisAlignment.end,
//                                             //                       children: [
//                                             //                         regulartext(
//                                             //                             AppColors.hint,
//                                             //                             12,
//                                             //                             "Price range"),
//                                             //                         boldtext(
//                                             //                             AppColors.black,
//                                             //                             14,
//                                             //                             "${productbyiddata![index].maxPrice.toString()} to ${productbyiddata![index].maxPrice.toString()} "),
//                                             //                       ],
//                                             //                     )
//                                             //                   ],
//                                             //                 ),
//                                             //               )
//                                             //             ],
//                                             //           ));
//                                             //     }),
//
//                                           )
//
//                                         ],
//                                       ),
//                                     )
//                                 )
//
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//
//
//
//                     )
//                   ],
//                 ),
//               ),
//
//               floatingActionButton: Row(
//
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: 200,
//                     transform: Matrix4.translationValues(100.0, -100, 0.0),
//                     child: Stack(
//                       children: [
//                         Center(
//                           child:  CircleAvatar(
//                             radius: 50,
//                             backgroundImage: NetworkImage(
//                                 search.profileImage),
//                           ),
//                         ),
//                         Positioned(
//                           left: 110,
//                           top: 130,
//                           child: SvgPicture.asset(AppImages.roundleft),)
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 100),
//                     height: 30,
//                     transform: Matrix4.translationValues(45.0, -120, 0.0),  // translate up by 30
//                     child: FloatingActionButton(
//                       backgroundColor: Colors.white,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(Icons.close_rounded,color: Colors.black,),
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
//             );
//           });
//
//         });
//
//   }
//
//   Future<List<Getservicebyuseriddata?>?>? getservicebyid(String userId) async {
//     print("BOKKING DARA LIST OF MYBOOKING");
//     print(ApiUrl.getservicebyid + userId);
//
//     try {
//       showLoader(context);
//       print(USERTOKKEN.toString());
//       final response = await http.get(
//         Uri.parse(ApiUrl.getservicebyid + userId),
//         headers: {"Authorization": USERTOKKEN.toString()},
//         // body: requestBody,
//       );
//       Map<String, dynamic> map = json.decode(response.body);
//
//       if (response.statusCode == 200) {
//         hideLoader();
//
//         Getservicebyuserid? myBookingModel =
//         Getservicebyuserid.fromJson(jsonDecode(response.body));
//         servicebyiddata = myBookingModel.data!;
//
//         print("Success");
//         setState(() {});
//         return servicebyiddata;
//       } else {
//         hideLoader();
//         print("Something went wronge");
//       }
//     } catch (e) {
//       hideLoader();
//       print("data==1=$e");
//     }
//   }
//
//   Future<List<GetproductbyuseridData?>?>? getproductbyid(String userId) async {
//     print("BOKKING DARA LIST OF MYBOOKING");
//     print(ApiUrl.getproductbyid + userId);
//     try {
//       showLoader(context);
//       print(USERTOKKEN.toString());
//       final response = await http.get(
//         Uri.parse(ApiUrl.getproductbyid + userId),
//         headers: {"Authorization": USERTOKKEN.toString()},
//         // body: requestBody,
//       );
//       Map<String, dynamic> map = json.decode(response.body);
//       if (response.statusCode == 200) {
//         hideLoader();
//         Getproductbyuserid? myBookingModel =
//         Getproductbyuserid.fromJson(jsonDecode(response.body));
//         productbyiddata = myBookingModel.data!;
//         print("Success");
//         setState(() {});
//         return productbyiddata;
//       } else {
//         hideLoader();
//         print("Something went wronge");
//       }
//     } catch (e) {
//       hideLoader();
//       print("data==1=$e");
//     }
//   }
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
//                 padding: EdgeInsets.all(10),
//                 child: SvgPicture.asset(AppImages.search),
//               ),
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
