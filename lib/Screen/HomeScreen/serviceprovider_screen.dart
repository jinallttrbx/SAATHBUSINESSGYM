// // ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, must_be_immutable
//
// import 'dart:convert';
//
// import 'package:businessgym/Screens/RatingandReviewByUserScreens.dart';
// import 'package:businessgym/Screens/globalWidgets/appbar_global.dart';
// import 'package:businessgym/Screens/view_profile_on_service.dart';
// import 'package:businessgym/model/SupplierServiceSubCategoryListModel.dart';
// import 'package:businessgym/values/const_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../Utils/ApiUrl.dart';
// import '../../../Utils/SharedPreferences.dart';
// import '../../../Utils/common_route.dart';
// import '../../../model/AddCallModel.dart';
// import '../../../model/ProviderModel.dart';
// import '../../../values/Colors.dart';
// import '../../../values/assets.dart';
// import '../../globalWidgets/global_values.dart';
// import '../../globalWidgets/stars_view.dart';
// import '../../homepage/widgets/viewprofileSearch.dart';
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
//   Future<ProviderModel?>? allserviceCategory;
//   SharedPreference _sharedPreference = new SharedPreference();
//   String? UserId;
//   String? cdate;
//
//   String? Number;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserType();
//
//     print("id========${widget.id}");
//     print("name========${widget.name}");
//     print("supplier========${widget.isSupplier}");
//     print("supplier========${userType}");
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
//   SupplierServiceSubCategoryListModel? supplierServiceSubCategoryListModel;
//   Future<ProviderModel?> getAllserviceCategory(String UserId) async {
//     print('ID================>${widget.id}');
//
//     try {
//       //showLoader(context);
//
//       String id = widget.id.toString();
//       print(id);
//       print(widget.isSupplier);
//       String type = await _sharedPreference.isUserType();
//
//       final response = widget.isSupplier == true //type == 'supplier' //
//           ? await http.post(
//               Uri.parse(
//                 ApiUrl.SupplierServiceBySubCategoryID,
//               ),
//               headers: {"Authorization": USERTOKKEN.toString()},
//               body: {"subcategory_id": widget.id.toString()})
//           : await http.get(
//               Uri.parse(
//                 ApiUrl.provider_list + "?subcategory_id=$id&user_id=$UserId",
//               ),
//             );
//
//       print("Success==== ${response.body}" +
//           ApiUrl.provider_list +
//           "?subcategory_id=$id&user_id=$UserId");
//       Map<String, dynamic> map = json.decode(response.body);
//       if (response.statusCode == 200) {
//         if (type == 'supplier') {
//           supplierServiceSubCategoryListModel =
//               SupplierServiceSubCategoryListModel.fromJson(map);
//         }
//         ProviderModel? allServiceModel =
//             ProviderModel.fromJson(jsonDecode(response.body));
//         setState(() {});
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
//   String? userType;
//   getUserType() async {
//     await _sharedPreference.isUserType().then((value) {
//       print('USER TYPE =============>$value');
//       userType = value;
//     });
//   }
//
//   Future<bool?> addcallloges(String userId, String serviceid, String cdate,
//       String providerId, String number) async {
//     try {
//       // showLoader(context);
//       print(userId);
//       String type = await _sharedPreference.isUserType();
//       // print(type);
//       Map<String, String> requestBody = USER_TYPE == "supplier"
//           ? {
//               "supplier_id": providerId,
//               'date':
//                   DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
//               'service_id': serviceid
//             }
//           : {
//               "provider_id": providerId,
//               "service_id": serviceid,
//               "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
//             };
//
//       print(requestBody);
//       final response = type == "user" || type == "provider"
//           ? await http.post(
//               Uri.parse(ApiUrl.add_call_logs),
//               headers: {"Authorization": USERTOKKEN.toString()},
//               body: requestBody,
//             )
//           : await http.post(
//               Uri.parse(ApiUrl.add_supplier_call_logs),
//               headers: {"Authorization": USERTOKKEN.toString()},
//               body: requestBody,
//             );
//       Map<String, dynamic> map = json.decode(response.body);
//
//       print("call log response" + response.body.toString());
//
//       if (response.statusCode == 200) {
//         print('<==========_ ADD CALL LOG _===========>');
//         print(response.body);
//         hideLoader();
//
//         AddCallModel? addCallModel =
//             AddCallModel.fromJson(jsonDecode(response.body));
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("${addCallModel.message}"),
//         ));
//
//         // _launchPhoneURL(number);
//
//         return true;
//       } else {
//         print("Something went wrong");
//         return false;
//       }
//     } catch (e) {
//       print("data==1=$e");
//     }
//   }
//
//   _launchPhoneURL(String phoneNumber) async {
//     Uri phoneno = Uri.parse('tel:+$phoneNumber');
//     if (await launchUrl(phoneno)) {
//     } else {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: APPBar(title: "${widget.name}"),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Container(
//                 height: 45,
//                 margin: const EdgeInsets.all(10),
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.white,
//                   child: Center(
//                     child: TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           searchText = value;
//                         });
//                       },
//                       style: const TextStyle(
//                           color: Colors.black, fontFamily: "caviarbold"),
//                       decoration: InputDecoration(
//                         hintText: "Search ....",
//                         hintStyle: const TextStyle(
//                             color: Color(0xff808080), fontFamily: 'caviarbold'),
//                         fillColor: Colors.white,
//                         filled: true,
//                         focusColor: Colors.white,
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Colors.white,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Colors.white,
//                           ),
//                         ),
//                         prefixIcon: const Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
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
//                         } else if (snapshot.hasData) {
//                           return ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: snapshot.data!.data!.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return searchText == "" ||
//                                         (searchText != "" &&
//                                             snapshot
//                                                 .data!.data![index].serviceName!
//                                                 .contains(searchText))
//                                     ? userType == "supplier"
//                                         ? Card(
//                                             color: index > 10
//                                                 ? colorList[
//                                                     index.remainder(10).abs()]
//                                                 : colorList[index],
//                                             margin: const EdgeInsets.all(
//                                               10,
//                                             ),
//                                             elevation: 4,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 Get.to(
//                                                   () => ViewProfileOnService(
//                                                     rating: 0,
//                                                     profilePic: '',
//                                                     name:
//                                                         supplierServiceSubCategoryListModel
//                                                                 ?.data?[index]
//                                                                 .name ??
//                                                             '',
//                                                     userType: userType,
//                                                     mobileNumber:
//                                                         supplierServiceSubCategoryListModel
//                                                             ?.data?[index]
//                                                             .mobile,
//                                                     id: supplierServiceSubCategoryListModel
//                                                         ?.data?[index].id
//                                                         .toString()!,
//                                                     providerId:
//                                                         supplierServiceSubCategoryListModel
//                                                             ?.data?[index]
//                                                             .providerId
//                                                             .toString(),
//                                                     data:
//                                                         supplierServiceSubCategoryListModel
//                                                             ?.data?[index],
//                                                     userId: '',
//                                                     productView: false,
//                                                     isSupplier:
//                                                         widget.isSupplier,
//                                                   ),
//                                                 );
//                                               },
//                                               child: ListTile(
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 10),
//                                                 leading: const CircleAvatar(
//                                                   radius: 40,
//                                                   backgroundImage: NetworkImage(
//                                                       ''
//                                                       // "${supplierServiceSubCategoryListModel?.data?[index].}",
//                                                       ),
//                                                 ),
//                                                 title: boldtext(
//                                                   AppColors.black,
//                                                   13,
//                                                   "${supplierServiceSubCategoryListModel?.data?[index].name}",
//                                                 ),
//                                                 subtitle: boldtext(
//                                                   AppColors.blackShade3,
//                                                   12,
//                                                   "${supplierServiceSubCategoryListModel?.data?[index].description}",
//                                                 ),
//                                                 trailing: IconButton(
//                                                     onPressed: () async {
//                                                       if (supplierServiceSubCategoryListModel
//                                                               ?.data?[index]
//                                                               .mobile ==
//                                                           null) {
//                                                         ScaffoldMessenger.of(
//                                                                 context)
//                                                             .showSnackBar(
//                                                           const SnackBar(
//                                                             content: Text(
//                                                                 'Mobile number not available'),
//                                                           ),
//                                                         );
//                                                       } else {
//                                                         await addcallloges(
//                                                                 UserId!,
//                                                                 supplierServiceSubCategoryListModel
//                                                                         ?.data?[
//                                                                             index]
//                                                                         .providerId
//                                                                         .toString() ??
//                                                                     '',
//                                                                 cdate!,
//                                                                 supplierServiceSubCategoryListModel
//                                                                         ?.data?[
//                                                                             index]
//                                                                         .providerId
//                                                                         .toString() ??
//                                                                     '',
//                                                                 supplierServiceSubCategoryListModel
//                                                                         ?.data?[
//                                                                             index]
//                                                                         .mobile ??
//                                                                     "")
//                                                             .then((value) =>
//                                                                 _launchPhoneURL(snapshot
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .contactNumber
//                                                                     .toString()));
//                                                       }
//                                                     },
//                                                     icon: Image.asset(AppImages
//                                                         .HOME_MYSERVICE)),
//                                               ),
//                                             ),
//                                           )
//                                         : Card(
//                                             color: index > 10
//                                                 ? colorList[
//                                                     index.remainder(10).abs()]
//                                                 : colorList[index],
//                                             margin: const EdgeInsets.all(
//                                               10,
//                                             ),
//                                             elevation: 4,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 Get.to(
//                                                   () => ViewProfileOnService(
//                                                     profilePic: snapshot
//                                                             .data!
//                                                             .data![index]
//                                                             .profile_pic ??
//                                                         '',
//                                                     rating: snapshot.data!
//                                                         .data![index].rating,
//                                                     mobileNumber: snapshot
//                                                         .data!
//                                                         .data![index]
//                                                         .contactNumber,
//                                                     id: snapshot.data!
//                                                         .data![index].serviceId
//                                                         .toString(),
//                                                     providerId: snapshot.data!
//                                                         .data![index].providerId
//                                                         .toString(),
//                                                     data: snapshot
//                                                         .data!.data![index],
//                                                     userId: snapshot.data!
//                                                         .data![index].user_id
//                                                         .toString(),
//                                                     productView: false,
//                                                     isSupplier:
//                                                         widget.isSupplier,
//                                                   ),
//                                                 );
//                                               },
//                                               child: ListTile(
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 10),
//                                                 leading: CircleAvatar(
//                                                   radius: 40,
//                                                   backgroundImage: NetworkImage(
//                                                     "${snapshot.data!.data![index].service_attachment}",
//                                                   ),
//                                                 ),
//                                                 title: boldtext(
//                                                   AppColors.black,
//                                                   13,
//                                                   "Service: ${snapshot.data!.data![index].serviceName}",
//                                                 ),
//                                                 subtitle: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     boldtext(
//                                                       AppColors.blackShade3,
//                                                       12,
//                                                       "Provider: ${snapshot.data!.data![index].displayName}",
//                                                     ),
//                                                     StarsView(
//                                                         total: 5,
//                                                         colored: double.parse(
//                                                                 snapshot
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .rating
//                                                                     .toString())
//                                                             .toInt(),
//                                                         ontap: () {
//                                                           Get.to(
//                                                             () =>
//                                                                 RatingandReviewByUserScreens(
//                                                               user_id: UserId,
//                                                               providerId: snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .providerId
//                                                                   .toString(),
//                                                             ),
//                                                           );
//                                                         })
//                                                   ],
//                                                 ),
//                                                 trailing: IconButton(
//                                                     onPressed: () async {
//                                                       await addcallloges(
//                                                               UserId!,
//                                                               snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .serviceId
//                                                                   .toString(),
//                                                               cdate!,
//                                                               snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .providerId
//                                                                   .toString(),
//                                                               snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .contactNumber
//                                                                   .toString())
//                                                           .then((value) =>
//                                                               _launchPhoneURL(snapshot
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .contactNumber
//                                                                   .toString()));
//                                                     },
//                                                     icon: Image.asset(AppImages
//                                                         .HOME_MYSERVICE)),
//                                               ),
//                                             ),
//                                           )
//                                     : const SizedBox.shrink();
//                               });
//                         }
//                       }
//
//                       // Displaying LoadingSpinner to indicate waiting state
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
// }

// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/conts/stars_view.dart';
import 'package:businessgym/conts/filter_screen.dart';
import 'package:businessgym/model/ProductSellerModel.dart';
import 'package:businessgym/model/SearchListModel.dart';
import 'package:businessgym/model/ServiceProvider.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/olddocument/personal.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../../Utils/ApiUrl.dart';
import '../../../../Utils/SharedPreferences.dart';
import '../../../../Utils/common_route.dart';
import '../../../../values/Colors.dart';
import '../../../../values/assets.dart';

class serviceproviderScreen extends StatefulWidget {
  String title;
  serviceproviderScreen(this.title);

  @override
  _serviceproviderScreenState createState() => _serviceproviderScreenState();
}

class _serviceproviderScreenState extends State<serviceproviderScreen> {
  TextEditingController search=TextEditingController();
 // Future<ProviderModel?>? allserviceCategory;
  SharedPreference _sharedPreference = new SharedPreference();
  String? UserId;
  String? cdate;
  String? Number;
  List<Serchlistmodeldata> searchlist = [];
  //Future<List<ProductSellerList>?>? listData1;
  List<ProductSellerdata>? productsellerdata = [];
  List<ServiceProviderdata>  serviceproviderdata=[];
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  var categoryIdList = [];
  String? ratingValue;
  String? catType;
  double? lat;
  double? lng;
  String? openAt;
  String? closeAt;
  double? startPrice;
  double? endPrice;
  Timer? _debounce;
  @override
  void initState() {
    getuserType();
    super.initState();
  }
  @override

  Future<List<ProductSellerdata?>?>? getproductseller() async {
    try {
      print(ApiUrl.getproductseller);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.getproductseller),
        body: {

        },
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      print("response data my news ================="+response.statusCode.toString());
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        ProductSellerList? viewNewsModel = ProductSellerList.fromJson(jsonDecode(response.body));
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
  Future<List<ServiceProviderdata?>?>? getserviceprovider() async {
    try {
      print(ApiUrl.getserviceprovider);
      showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.getserviceprovider),
        headers: {"Authorization": USERTOKKEN.toString()},
      );
      print("response data my news ================="+response.body);
      //  Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        ServiceProviderList? viewNewsModel = ServiceProviderList.fromJson(jsonDecode(response.body));
        serviceproviderdata = viewNewsModel.data;
        setState(() {
          serviceproviderdata = viewNewsModel.data;
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

  String searchText = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: widget.title=="Service Provider"?"Service provider":"Product Seller"),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              widget.title=="Service Provider"?Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
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
                  minLines:1,
                  maxLines: 1,
                  controller: search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
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
                      hintText: "search service"),
                ),
              ): Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
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
                  minLines:1,
                  maxLines: 1,
                  controller: search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
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
                      hintText: "search product"),
                ),
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
                       child: GestureDetector(
                         onTap: ()async {

                           final result = await Get.to(
                                 () => filterscreen(
                               catType: catType,
                               categoryList: categoryIdList,
                               rating: ratingValue,
                               lat: lat.toString(),
                               lng: lng.toString(),
                               openAt: openAt,
                               closeAt: closeAt,
                               min: startPrice,
                               max: endPrice,
                             ),
                           );
                           if (result != null) {
                             catType = result['type'];
                             categoryIdList = result['category_id'];
                             ratingValue = result['rating'];
                             lat = result['lat'];
                             lng = result['lng'];
                             openAt = result['open_at'];
                             closeAt = result['close_at'];
                             startPrice = result['min_price'];
                             endPrice = result['max_price'];
                           }

                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>filterscreen()));
                           // Get.to(const filterscreen());

                         },
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SvgPicture.asset(AppImages.filter),
                             SizedBox(width: 5,),
                             Text("Filter",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",),)
                           ],
                         ),
                       )
                   ),
                 ),
                 Expanded(
                   flex:3,child:  SizedBox(width: 5,),),
               //   Expanded(child: Text("2 filters apply",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",),),),
                 GestureDetector(
                   onTap: (){
                     search.clear();
                     print("searchsearchsearchsearchsearchsearchsearch");
                   getuserType();
                   },

                   child:  Text("Clear All",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600
                       ,fontFamily: "OpenSans",color: AppColors.primary),),
                 )

                ],
              ),

              SizedBox(height: 15,),
             widget.title=="Service Provider"? searchlist.isEmpty || search.text.isEmpty?ListView.builder(
                 shrinkWrap: true,
                 itemCount: serviceproviderdata.length,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   return GestureDetector(
                     onTap: (){
                       CommonBottomSheet.show(context,serviceproviderdata![index].userId.toString(),serviceproviderdata![index].userId.toString(),"service","");


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
                                     "${serviceproviderdata[index].profileImage??""}",
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Expanded(child:  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     boldtext(
                                       AppColors.black,
                                       14,
                                       "${serviceproviderdata[index].username??""}",
                                     ),
                                     boldtext(
                                       AppColors.blackShade3,
                                       12,
                                       "${serviceproviderdata[index].categoryName==null?"-":serviceproviderdata[index].categoryName}",
                                     ),
                                     StarsView(
                                         total:  5,
                                         colored: serviceproviderdata?[index].averageRating.toInt(),

                                         ontap: () {
                                           // Get.to(() =>
                                           //     RatingandReviewByUserScreens(
                                           //       isProduct: false,
                                           //       user_id: UserId,
                                           //       serviceOrProductId:
                                           //       1
                                           //           .toString(),
                                           //       providerId: 1
                                           //           .toString(),
                                           //     ));
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
                   ) ;

                 }):
             ListView.builder(
                 shrinkWrap: true,
                 itemCount: searchlist.length,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   return GestureDetector(
                     onTap: (){
                       CommonBottomSheet.show(context,searchlist![index].userid.toString(),searchlist![index].userid.toString(),"service","");


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
                                     "${searchlist[index].profileImage??""}",
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Expanded(child:  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     boldtext(
                                       AppColors.black,
                                       14,
                                       "${searchlist[index].providername??""}",
                                     ),
                                     boldtext(
                                       AppColors.blackShade3,
                                       12,
                                       "${searchlist[index].subCategoryName==null?"-":searchlist[index].subCategoryName}",
                                     ),
                                     StarsView(
                                         total:  5,
                                         colored: searchlist?[index].rating!.toInt(),

                                         ontap: () {
                                           // Get.to(() =>
                                           //     RatingandReviewByUserScreens(
                                           //       isProduct: false,
                                           //       user_id: UserId,
                                           //       serviceOrProductId:
                                           //       1
                                           //           .toString(),
                                           //       providerId: 1
                                           //           .toString(),
                                           //     ));
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
                   ) ;

                 }):
     search.text.isEmpty||   searchlist!.isEmpty?ListView.builder(
                 shrinkWrap: true,
                 itemCount: productsellerdata!.length,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   return GestureDetector(
                     onTap: (){
                       CommonBottomSheet.show(context,productsellerdata![index].userId.toString(),productsellerdata![index].userId.toString(),"product","");


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
                                     "${productsellerdata![index].profileImage??""}",
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Expanded(child:  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     boldtext(
                                       AppColors.black,
                                       14,
                                       "${productsellerdata![index].username??""}",
                                     ),
                                     boldtext(
                                       AppColors.blackShade3,
                                       12,
                                       "${productsellerdata![index].categoryName==null?"-":productsellerdata![index].categoryName}",
                                     ),
                                     StarsView(
                                         total:  5,
                                         colored: productsellerdata?[index].averageRating.toInt(),

                                         ontap: () {
                                           // Get.to(() =>
                                           //     RatingandReviewByUserScreens(
                                           //       isProduct: false,
                                           //       user_id: UserId,
                                           //       serviceOrProductId:
                                           //       1
                                           //           .toString(),
                                           //       providerId: 1
                                           //           .toString(),
                                           //     ));
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
                   );

                 }):
             ListView.builder(
                 shrinkWrap: true,
                 itemCount: searchlist!.length,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   return GestureDetector(
                     onTap: (){
                       CommonBottomSheet.show(context,searchlist![index].userid.toString(),searchlist![index].userid.toString(),"product","");

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
                                     "${searchlist![index].profileImage??""}",
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Expanded(child:  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     boldtext(
                                       AppColors.black,
                                       14,
                                       "${searchlist![index].providername??""}",
                                     ),
                                     boldtext(
                                       AppColors.blackShade3,
                                       12,
                                       "${searchlist![index].subCategoryName==null?"-":searchlist![index].subCategoryName}",
                                     ),
                                     StarsView(
                                         total:  5,
                                         colored: searchlist?[index].rating.toInt(),

                                         ontap: () {
                                           // Get.to(() =>
                                           //     RatingandReviewByUserScreens(
                                           //       isProduct: false,
                                           //       user_id: UserId,
                                           //       serviceOrProductId:
                                           //       1
                                           //           .toString(),
                                           //       providerId: 1
                                           //           .toString(),
                                           //     ));
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
                   );

                 })



            ],
          ),
        ),
      ),
    );
  }

  void getuserType() async {
   // usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
   // usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId!);
    getproductseller();
    getserviceprovider();
  }




  // onSearchTextChanged(String text) async {
  //   searchlist!.clear();
  //   if (text.isEmpty) {
  //     setState(() {});
  //     return;
  //   }
  //   productsellerdata!.forEach((userDetail) {
  //     if (userDetail.username!.isCaseInsensitiveContains(text) || userDetail.categoryName!.isCaseInsensitiveContains(text))
  //       searchlist!.add(userDetail);
  //   });
  //   setState(() {});
  // }
  // onSearchTextChanged1(String text) async {
  //   searchlist1!.clear();
  //   if (text.isEmpty) {
  //     setState(() {});
  //     return;
  //   }
  //   serviceproviderdata!.forEach((userDetail) {
  //     if (userDetail.username!.isCaseInsensitiveContains(text) || userDetail.categoryName!.isCaseInsensitiveContains(text))
  //       searchlist1!.add(userDetail);
  //   });
  //   setState(() {});
  // }



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
        request.fields['min_price'] =  startPrice.toString() ??  '';
      }
      if (endPrice != null) {
        request.fields['max_price'] = endPrice.toString() ??  '';
      }
      if (lat != null) {
        request.fields['latitude'] = lat.toString() ?? '';
      }
      if (lng != null) {
        request.fields['longitude'] = lng.toString() ?? '';
      }
      if (openAt != null) {
        request.fields['open_at'] = openAt ?? '';
      }
      if (closeAt != null) {
        request.fields['close_at'] = closeAt ?? '';
      }
      final response = await request.send();
      final data = await http.Response.fromStream(response);
      print(data.body);
      print(data.statusCode);
      if (response.statusCode == 200) {
        Serchlistmodel vehicalTypeModel =
        Serchlistmodel.fromJson(jsonDecode(data.body));
        searchlist = vehicalTypeModel.data;
        setState(() {});
      } else {}
    } catch (e) {
      print(e);
    }
  }


}

