// import 'dart:async';
// import 'dart:convert';
//
//
// import 'package:businessgym/Screen/HomeScreen/MyServicesScreens.dart';
// import 'package:businessgym/Screen/HomeScreen/profileServiceProvider.dart';
// import 'package:businessgym/Screen/HomeScreen/shimmerEffectfindme.dart';
// import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
// import 'package:businessgym/Screen/ProfileScreen/SubCategoryScreen.dart';
// import 'package:businessgym/Screen/ProfileScreen/myservices.dart';
// import 'dart:math';
// import 'package:businessgym/Utils/ApiUrl.dart';
// import 'package:businessgym/Utils/common_route.dart';
// import 'package:businessgym/components/button.dart';
// import 'package:businessgym/components/commonBottomSheet.dart';
// import 'package:businessgym/conts/appbar_global.dart';
// import 'package:businessgym/conts/filter_screen.dart';
// import 'package:businessgym/conts/global_values.dart';
// import 'package:businessgym/conts/stars_view.dart';
// import 'package:businessgym/model/GetUserReviews.dart';
// import 'package:businessgym/model/SearchListModel.dart';
// import 'package:businessgym/model/getproductbyuserid.dart';
// import 'package:businessgym/model/getservicebyuserid.dart';
// import 'package:businessgym/searchproduct.dart';
// import 'package:businessgym/values/const_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../Utils/SharedPreferences.dart';
// import '../values/Colors.dart';
// import '../values/assets.dart';
// import '../values/spacer.dart';
//
//
//
// class SearchWidget extends StatefulWidget {
//   bool? appbar;
//   bool? productView;
//   SearchWidget({super.key, this.appbar, this.productView});
//
//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }
//
// class _SearchWidgetState extends State<SearchWidget> {
//   bool isLoading = false;
//   // Future<AllServiceModel?>? totalList;
//   dynamic totalList = [];
//   List<Serchlistmodeldata> searchlist = [];
//   Future<List<Getservicebyuseriddata?>?>? servicebyid;
//   List<Getservicebyuseriddata>? servicebyiddata = [];
//   Future<List<GetproductbyuseridData?>?>? productbyid;
//   List<GetproductbyuseridData>? productbyiddata = [];
//   // List searchlist = [];
//   String? filter;
//   // String mainFilter = 'name';
//
//   bool focus = false;
//   FocusNode inputNode = FocusNode();
//   void openKeyboard() {
//     FocusScope.of(context).requestFocus(inputNode);
//   }
//
//   TextEditingController controller = TextEditingController();
//
//   // Future<List<Serchlistmodeldata>?> getSearch(String text) async {
//   //   try{
//   //     showLoader(context);
//   //     print(ApiUrl.searchhomeservice+text);
//   //     final response = await http.post(
//   //         Uri.parse(ApiUrl.searchhomeservice+text),
//   //         headers: {"Authorization": "$USERTOKKEN"},
//   //         body: {
//   //           "text":text,
//   //         }
//   //     );
//   //     if (response.statusCode == 200) {
//   //       hideLoader();
//   //       print(response.statusCode);
//   //       Serchlistmodel vehicalTypeModel =
//   //       Serchlistmodel.fromJson(jsonDecode(response.body));
//   //       searchlist = vehicalTypeModel.data;
//   //       hideLoader();
//   //       setState(() {});
//   //     } else {
//   //       hideLoader();
//   //     }
//   //   }catch(e){
//   //     hideLoader();
//   //
//   //   }
//   //
//   //
//   // }
//
//   // find(String value) {
//   //   // print(value);
//   //   if (value == "" || value == null) {
//   //     // print("inside if");
//   //     searchlist = [];
//   //     setState(() {});
//   //   } else {
//   //     // print("inside else");
//   //     searchlist = totalList
//   //         .where((element) => element[filter]
//   //             .toString()
//   //             .toLowerCase()
//   //             .contains(value.toLowerCase()))
//   //         .toList();
//   //     setState(() {});
//   //
//   //     print("===========(SEARCH LIST)===============");
//   //     print(searchlist);
//   //   }
//   // }
//
//   // find(String value) {
//   //   if (value == "" || value == null) {
//   //     searchlist = [];
//   //     setState(() {});
//   //   } else {
//   //     //totalList = [];
//   //     // if (mainFilter == 'nearBy') {
//   //     //   widget.productView == true
//   //     //       ? totalList = NearByProductList
//   //     //       : totalList = NearByServiceList;
//   //     //   setState(() {});
//   //     // } else {
//   //     //   widget.productView == true
//   //     //       ? totalList = ByRatingProductList
//   //     //       : totalList = ByRatingServiceList;
//   //     //   setState(() {});
//   //     // }
//   //     // searchlist = (mainFilter == 'nearBy'
//   //     //         ? widget.productView == true
//   //     //             ? NearByProductList
//   //     //             : NearByServiceList
//   //     //         : widget.productView == true
//   //     //             ? ByRatingProductList
//   //     //             : ByRatingServiceList)
//   //     //     .where((element) => element[filter]
//   //     //         .toString()
//   //     //         .toLowerCase()
//   //     //         .contains(value.toLowerCase()))
//   //     //     .toList();
//   //     // print("search=============");
//   //     // print(searchlist);
//   //     // print("search=============");
//   //     //setState(() {});
//   //   }
//   // }
//
//   List NearByServiceList = [];
//   List NearByProductList = [];
//   List ByRatingServiceList = [];
//   List ByRatingProductList = [];
//   Timer? _debounce;
//
//   getNearByMeServiceList() async {
//     try {
//       final response = await http.get(
//           Uri.parse(ApiUrl.getnearbymeservice
//           ),
//           headers: {'Authorization': '$USERTOKKEN'});
//       final data = jsonDecode(response.body);
//       print('Service Data$data');
//       NearByServiceList = data['data'];
//       setState(() {});
//     } catch (e) {
//       NearByServiceList = [];
//       setState(() {});
//     }
//   }
//
//   getNearByMeProductList() async {
//     try {
//       final response = await http.get(
//           Uri.parse(ApiUrl.getnearbymeprocut
//           ),
//           headers: {'Authorization': '$USERTOKKEN'});
//       final data = jsonDecode(response.body);
//
//       NearByProductList = data['data']['data'];
//
//       setState(() {});
//     } catch (e) {
//       NearByProductList = [];
//       setState(() {});
//     }
//   }
//
//   getByRatingServiceList() async {
//     try {
//       final response = await http.get(
//           Uri.parse(ApiUrl.getnearbyratingservice
//           ),
//           headers: {'Authorization': '$USERTOKKEN'});
//       final data = jsonDecode(response.body);
//       ByRatingServiceList = data['data'];
//
//       setState(() {});
//     } catch (e) {
//       ByRatingServiceList = [];
//       setState(() {});
//     }
//   }
//
//   getByRatingProductList() async {
//     try {
//       final response = await http.get(
//           Uri.parse(
//               ApiUrl.getnearbyratingproduct),
//           headers: {'Authorization': '$USERTOKKEN'});
//       final data = jsonDecode(response.body);
//       ByRatingProductList = data['data'];
//
//       setState(() {});
//     } catch (e) {
//       ByRatingProductList = [];
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     //find('');
//
//     // getNearByMeServiceList();
//     // getNearByMeProductList();
//     // getByRatingServiceList();
//     // getByRatingProductList();
//   }
//   var categoryIdList = [];
//   String? ratingValue;
//   String? catType;
//   double? lat;
//   double? lng;
//   String? openAt;
//   String? closeAt;
//   double? startPrice;
//   double? endPrice;
//   @override
//   Widget build(BuildContext context) {
//     filter = widget.productView == true ? 'name' : 'service_name';
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         // appBar: widget.appbar == false ? null : APPBar(title: 'Search Service'),
//         body: SizedBox(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 40,
//                 margin: const EdgeInsets.all(15),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Material(
//                         elevation: 4,
//                         borderRadius: BorderRadius.circular(8),
//                         color: Colors.white,
//                         child: TextField(
//                           autofocus: focus,
//                           focusNode: inputNode,
//                           controller: controller,
//                           style: const TextStyle(
//                               color: Colors.black, fontFamily: "caviarbold"),
//                           onChanged: (value) {
//                             // getSearch(controller.text);
//                             if (_debounce?.isActive ?? false) {
//                               _debounce!.cancel();
//                             }
//                             _debounce = Timer(
//                               const Duration(milliseconds: 1000),
//                                   () {
//                                 if (value.isNotEmpty) {
//                                   searchWithFilter(value);
//                                 } else {
//                                   setState(() {
//                                     searchlist = [];
//                                   });
//                                 }
//                               },
//                             );
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.only(top: 10),
//                             hintText:
//                             "Search For ${widget.productView == true ? "Product" : "Service"}....",
//                             hintStyle: const TextStyle(
//                                 color: Color(0xff808080),
//                                 fontFamily: 'caviarbold'),
//                             fillColor: Colors.white,
//                             filled: true,
//                             focusColor: Colors.white,
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             prefixIcon: const Icon(Icons.search),
//                             // suffixIcon: Row(
//                             //   mainAxisSize: MainAxisSize.min,
//                             //   children: [
//                             //     PopupMenuButton(
//                             //       icon: SvgPicture.asset(
//                             //   AppImages.filter,
//                             //   width: 30,
//                             // ),
//                             //       itemBuilder: (_) => <PopupMenuItem<String>>[
//                             //         if (widget.productView == false) ...[
//                             //           PopupMenuItem<String>(
//                             //             value: "name",
//                             //             child: const Text('Category Name'),
//                             //           ),
//                             //           const PopupMenuItem<String>(
//                             //             value: 'service_category_name',
//                             //             child: Text('Services'),
//                             //           ),
//                             //           const PopupMenuItem<String>(
//                             //             value: 'provider_name',
//                             //             child: Text('Provider Name'),
//                             //           ),
//                             //         ] else ...[
//                             //           PopupMenuItem<String>(
//                             //             value: widget.productView == true
//                             //                 ? "name"
//                             //                 : 'service_name',
//                             //             child: const Text('Category Name'),
//                             //           ),
//                             //           const PopupMenuItem<String>(
//                             //             value: 'service_category_name',
//                             //             child: Text('Products'),
//                             //           ),
//                             //           const PopupMenuItem<String>(
//                             //             value: 'provider_name',
//                             //             child: Text('Provider Name'),
//                             //           ),
//                             //         ],
//                             //
//                             //       ],
//                             //       onSelected: (value) => setState(() {
//                             //         filter = value;
//                             //       }),
//                             //     ),
//                             //
//                             //   ],
//                             // ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Material(
//                         elevation: 4,
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: IconButton(
//                             onPressed: () async {
//                               final result = await Get.to(
//                                     () => filterscreen(
//                                   catType: catType,
//                                   categoryList: categoryIdList,
//                                   rating: ratingValue,
//                                   lat: lat,
//                                   lng: lng,
//                                   openAt: openAt,
//                                   closeAt: closeAt,
//                                   min: startPrice,
//                                   max: endPrice,
//                                 ),
//                               );
//                               if (result != null) {
//                                 catType = result['type'];
//                                 categoryIdList = result['category_id'];
//                                 ratingValue = result['rating'];
//                                 lat = result['lat'];
//                                 lng = result['lng'];
//                                 openAt = result['open_at'];
//                                 closeAt = result['close_at'];
//                                 startPrice = result['min_price'];
//                                 endPrice = result['max_price'];
//                               }
//                             },
//                             icon: const Icon(
//                               Icons.filter_alt_outlined,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               Expanded(
//                 child: isLoading
//                     ? const Text("Loading")
//                     : searchlist!.isEmpty
//                     ? MyServicesScreens(
//                   productView: widget.productView,
//                 )
//                     : MyServicessearch(controller.text,)
//               )
//             ],
//           ),
//         ));
//   }
//
//   modalsheet() {
//     return showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Wrap(
//             children: [
//               ListTile(
//                 leading: SvgPicture.asset(
//                   AppImages.filter,
//                   width: 30,
//                 ),
//                 title: const Text('Category Name'),
//                 onTap: () {
//                   setState(() {
//                     filter =
//                     widget.productView == true ? "name" : 'service_name';
//                     controller.clear();
//                     searchlist = [];
//                     Navigator.pop(context);
//                   });
//                 },
//               ),
//               // if (widget.productView == false) ...[
//               ListTile(
//                 leading: SvgPicture.asset(
//                   AppImages.filter,
//                   width: 30,
//                 ),
//                 title: const Text('Services '),
//                 onTap: () {
//                   setState(() {
//                     filter = 'service_category_name';
//                     controller.clear();
//                     searchlist = [];
//                     Navigator.pop(context);
//                   });
//                 },
//               ),
//               // ],
//               ListTile(
//                 leading: SvgPicture.asset(
//                   AppImages.filter,
//                   width: 30,
//                 ),
//                 title: const Text('Provider Name'),
//                 onTap: () {
//                   setState(() {
//                     filter = 'first_name';
//                     controller.clear();
//                     searchlist = [];
//                     Navigator.pop(context);
//                   });
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   // void _bottomSheet(context,Serchlistmodeldata search){
//   //   int listToShow = 0;
//   //   showModalBottomSheet(context: context,
//   //       isScrollControlled: true,
//   //       constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width,
//   //           MediaQuery.of(context).size.height * .8)),
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
//   //       builder: (BuildContext bc) {
//   //         return  StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
//   //           return Scaffold(
//   //
//   //             backgroundColor: Colors.transparent,
//   //             body: SingleChildScrollView(
//   //               physics: NeverScrollableScrollPhysics(),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.center,
//   //                 children: [
//   //                   Container(
//   //                     height: MediaQuery.of(context).size.height,
//   //                     child:  Column(
//   //                       children: [
//   //                         Container(
//   //                           margin: EdgeInsets.only(top: 50),
//   //                           child: Column(
//   //                             children: [
//   //                               Text("${search.userName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "OpenSans"),),
//   //                               Text( "${search.address}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "OpenSans",color: Color(0xff656565)),),
//   //                               SizedBox(height: 10,),
//   //                               Container(
//   //                                 margin: EdgeInsets.only(left: 100,right: 100,top: 10),
//   //                                 padding: EdgeInsets.all(11),
//   //                                 height: 45,
//   //
//   //                                 decoration: BoxDecoration(
//   //                                     color: Color(0xffF1FAFF),
//   //                                     borderRadius: BorderRadius.all(Radius.circular(17))
//   //                                 ),
//   //                                 child:  InkWell(
//   //                                   child: Row(
//   //                                     mainAxisAlignment:
//   //                                     MainAxisAlignment.center,
//   //                                     children: [
//   //                                       RatingBarIndicator(
//   //                                         direction: Axis
//   //                                             .horizontal,
//   //                                         rating: search==null?0:double
//   //                                             .parse(
//   //                                           "${search.rating}",),
//   //                                         itemCount: 5,
//   //                                         itemSize: 14,
//   //                                         itemPadding:
//   //                                         const EdgeInsets
//   //                                             .all(2),
//   //                                         unratedColor:
//   //                                         Colors.grey,
//   //                                         itemBuilder:
//   //                                             (context,
//   //                                             _) =>
//   //                                             SvgPicture.asset(AppImages.rating),
//   //                                       ),
//   //
//   //                                       boldtext(Color(0xff656565), 12,
//   //                                          '${search.rating} Rating')
//   //                                     ],
//   //                                   ),
//   //                                 ),
//   //                               ),
//   //                               SizedBox(height: 10,),
//   //                               Container(
//   //                                   margin: EdgeInsets.only(left: 10,right: 10,top: 10),
//   //
//   //
//   //
//   //                                   child: SingleChildScrollView(
//   //                                     child: Column(
//   //                                       children: [
//   //                                         SizedBox(height: 10,),
//   //                                         Container(
//   //                                           margin: EdgeInsets.only(left: 15,right: 15),
//   //                                           padding: EdgeInsets.all(11),
//   //                                           height: 55,
//   //                                           decoration: BoxDecoration(
//   //                                               color: Color(0xffF0F0F0),
//   //                                               borderRadius: BorderRadius.all(Radius.circular(28))
//   //                                           ),
//   //                                           child:   Row(
//   //                                             children: [
//   //                                               Expanded(child:  Container(
//   //                                                 padding: EdgeInsets.all(4),
//   //                                                 height:50,
//   //                                                 decoration: BoxDecoration(
//   //                                                   color: listToShow == 0
//   //                                                       ? AppColors.white
//   //                                                       : listToShow == 1
//   //                                                       ? Color(0xffF0F0F0)
//   //                                                       : Color(0xffF0F0F0),
//   //
//   //                                                   borderRadius:
//   //                                                   const BorderRadius.all(Radius.circular(28)),
//   //
//   //                                                 ),
//   //                                                 child:  GestureDetector(
//   //                                                     onTap: ()async{
//   //                                                       setState(() {
//   //                                                         listToShow = 0;
//   //                                                       });
//   //                                                       print(listToShow);
//   //                                                       //setEvents();
//   //                                                     },
//   //                                                     child: Center(
//   //                                                       child:  Text(
//   //                                                         "Overview",
//   //                                                         style: TextStyle(color: listToShow == 0
//   //                                                             ? AppColors.blue
//   //                                                             : listToShow == 1
//   //                                                             ? AppColors.black
//   //                                                             : AppColors.black,),
//   //                                                       ),
//   //                                                     )
//   //                                                 ),
//   //                                               ),),
//   //                                               SizedBox(width: 2,),
//   //                                               Expanded(child: Container(
//   //                                                 padding: EdgeInsets.all(4),
//   //                                                 height:30,
//   //                                                 decoration: BoxDecoration(
//   //                                                   color: listToShow == 0
//   //                                                       ? Color(0xffF0F0F0)
//   //                                                       : listToShow == 1
//   //                                                       ?  AppColors.white
//   //                                                       : Color(0xffF0F0F0),
//   //
//   //                                                   borderRadius:
//   //                                                   const BorderRadius.all(Radius.circular(28)),
//   //
//   //                                                 ),
//   //                                                 child: GestureDetector(
//   //                                                     onTap: ()async{
//   //                                                       setState(() {
//   //                                                         listToShow = 1;
//   //                                                       });
//   //                                                       print(listToShow);
//   //                                                       servicebyid = getservicebyid(search.uid.toString());
//   //                                                     },
//   //                                                     child:  Center(
//   //                                                       child:  Text(
//   //                                                         "Services", style: TextStyle(color: listToShow == 0
//   //                                                           ? AppColors.black
//   //                                                           : listToShow == 1
//   //                                                           ? AppColors.blue
//   //                                                           : AppColors.black,),
//   //
//   //
//   //                                                       ),
//   //                                                     )
//   //                                                 ),
//   //                                               ),),
//   //                                               SizedBox(width: 2,),
//   //                                               Expanded(child: Container(
//   //                                                 padding: EdgeInsets.all(4),
//   //                                                 height:30,
//   //                                                 decoration: BoxDecoration(
//   //                                                   color: listToShow == 0
//   //                                                       ?  Color(0xffF0F0F0)
//   //                                                       : listToShow == 1
//   //                                                       ?  Color(0xffF0F0F0)
//   //                                                       : AppColors.white,
//   //
//   //                                                   borderRadius:
//   //                                                   const BorderRadius.all(Radius.circular(28)),
//   //
//   //                                                 ),
//   //                                                 child:
//   //                                                 GestureDetector(
//   //                                                     onTap: ()async{
//   //                                                       setState(() {
//   //                                                         listToShow = 2;
//   //                                                       });
//   //                                                       print(listToShow);
//   //
//   //                                                       productbyid = getproductbyid(search.uid.toString());
//   //                                                     },
//   //                                                     child:  Center(
//   //                                                       child:  Text(
//   //                                                         "Product" ,style: TextStyle(color: listToShow == 0
//   //                                                           ? AppColors.black
//   //                                                           : listToShow == 1
//   //                                                           ? AppColors.black
//   //                                                           : AppColors.blue,),
//   //
//   //
//   //                                                       ),
//   //                                                     )
//   //                                                 ),
//   //                                               ))
//   //                                             ],
//   //                                           ),
//   //                                         ),
//   //                                         SizedBox(height: 10,),
//   //                                         Container(
//   //                                             height: 350,
//   //                                             child:  listToShow==0? Container(
//   //
//   //                                               padding: EdgeInsets.only(left: 16),
//   //                                               width: MediaQuery.of(context).size.width,
//   //                                               child: Column(
//   //                                                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                                                 children: [
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"Contact no.",),
//   //                                                   boldtext(Colors.black,14,"${search.contactNumber==null?"-":search.contactNumber}",),
//   //                                                   SizedBox(height: 10,),
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"Email id",),
//   //                                                   boldtext(Colors.black,14,"${search.email==null?"-":search.email}",),
//   //                                                   SizedBox(height: 10,),
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"Address",),
//   //                                                   boldtext(Colors.black,14,"${search.address==null?"-":search.address}",),
//   //                                                   SizedBox(height: 10,),
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"GST no.",),
//   //                                                   boldtext(Colors.black,14,"${search.fassaiNumber==null?"-":search.fassaiNumber}",),
//   //                                                   SizedBox(height: 10,),
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"FSSAI no.",),
//   //                                                   boldtext(Colors.black,14,"${search.fassaiNumber==null?"-":search.fassaiNumber}",),
//   //                                                   SizedBox(height: 10,),
//   //                                                   regulartext( Color(0xffA6A6A6), 12,"Working hour",),
//   //                                                   boldtext(Colors.black,14,"${search.workingHour==null?"-":search.workingHour}",),
//   //                                                   SizedBox(height: 20,),
//   //                                                   Row(
//   //                                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                                                     children: [
//   //                                                       Expanded(child: Container(
//   //                                                         height: 50,
//   //                                                         child: ElevatedButton.icon(
//   //
//   //                                                             style: ElevatedButton.styleFrom(
//   //                                                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//   //                                                                 backgroundColor: Color(0xff25D366)
//   //                                                             ),
//   //                                                             onPressed: () async {
//   //                                                             //  addlead(search.providerId.toString(),search.serviceId.toString(),type);
//   //
//   //                                                               var url =
//   //                                                                   'https://api.whatsapp.com/send?phone=+91${search.contactNumber!.substring(3,13)}&text';
//   //                                                               await launch(url);
//   //                                                             },
//   //                                                             icon: SvgPicture.asset(AppImages.whatsapp,color: AppColors.white,),
//   //                                                             label:Text("Whatsapp",style: TextStyle(
//   //                                                                 fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//   //                                                                 color: Colors.white
//   //                                                             ),)),
//   //                                                       )),
//   //                                                       SizedBox(width: 10,),
//   //                                                       Expanded(
//   //                                                           child: Container(
//   //                                                             height: 50,
//   //                                                             child: ElevatedButton.icon(
//   //                                                                 icon: SvgPicture.asset(AppImages.call,color: AppColors.white,),
//   //                                                                 style: ElevatedButton.styleFrom(
//   //                                                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
//   //                                                                     backgroundColor: AppColors.primary
//   //                                                                 ),
//   //                                                                 onPressed: () {
//   //                                                                   // addlead(search.providerId.toString(),search.serviceId.toString(),type);
//   //                                                                   final data = Uri(
//   //                                                                       scheme: 'tel',
//   //                                                                       path:'+91${search.contactNumber!.substring(3,13)}');
//   //                                                                   launchUrl(data);
//   //                                                                 },
//   //                                                                 label: Text("Call",style: TextStyle(
//   //                                                                     fontFamily: "OpenSans",fontWeight: FontWeight.w600,fontSize: 12,
//   //                                                                     color: Colors.white
//   //                                                                 ),)),
//   //                                                           ))
//   //                                                     ],
//   //                                                   )
//   //
//   //
//   //                                                 ],
//   //                                               ),
//   //                                             ):listToShow==1?
//   //                                             ListView.builder(
//   //                                                 physics:
//   //                                                 const BouncingScrollPhysics(),
//   //                                                 itemCount:
//   //                                                 servicebyiddata!
//   //                                                     .length,
//   //                                                 shrinkWrap: true,
//   //                                                 itemBuilder:
//   //                                                     (context, index) {
//   //                                                   return Container(
//   //                                                       margin:
//   //                                                       const EdgeInsets
//   //                                                           .only(
//   //                                                           bottom:
//   //                                                           10),
//   //                                                       child: Column(
//   //                                                         children: [
//   //                                                           Container(
//   //                                                             margin:
//   //                                                             const EdgeInsets.all(
//   //                                                                 10),
//   //                                                             child: Row(
//   //                                                               children: [
//   //                                                                 Container(
//   //                                                                   decoration:
//   //                                                                   const BoxDecoration(
//   //                                                                     borderRadius:
//   //                                                                     BorderRadius.all(Radius.circular(15)),
//   //                                                                   ),
//   //                                                                   height:
//   //                                                                   60,
//   //                                                                   width:
//   //                                                                   60,
//   //                                                                   child:
//   //                                                                   ClipRRect(
//   //                                                                     borderRadius:
//   //                                                                     const BorderRadius.all(Radius.circular(15)),
//   //                                                                     child:
//   //                                                                     Image.network(
//   //                                                                       servicebyiddata![index].serviceImage ?? "",
//   //                                                                       fit: BoxFit.cover,
//   //                                                                     ),
//   //                                                                   ),
//   //                                                                 ),
//   //                                                                 const SizedBox(
//   //                                                                   width:
//   //                                                                   10,
//   //                                                                 ),
//   //                                                                 Expanded(
//   //                                                                   child:
//   //                                                                   Column(
//   //                                                                     crossAxisAlignment:
//   //                                                                     CrossAxisAlignment.start,
//   //                                                                     children: [
//   //                                                                       regulartext(AppColors.hint, 12, servicebyiddata![index].name!),
//   //                                                                       boldtext(AppColors.black, 14, servicebyiddata![index].subcategoryId.toString()),
//   //                                                                     ],
//   //                                                                   ),
//   //                                                                 ),
//   //                                                                 Column(
//   //                                                                   crossAxisAlignment:
//   //                                                                   CrossAxisAlignment.end,
//   //                                                                   children: [
//   //                                                                     regulartext(
//   //                                                                         AppColors.hint,
//   //                                                                         12,
//   //                                                                         "Price range"),
//   //                                                                     boldtext(
//   //                                                                         AppColors.black,
//   //                                                                         14,
//   //                                                                         "${servicebyiddata![index].maxPrice.toString()} to ${servicebyiddata![index].maxPrice.toString()} "),
//   //                                                                   ],
//   //                                                                 )
//   //                                                               ],
//   //                                                             ),
//   //                                                           )
//   //                                                         ],
//   //                                                       ));
//   //                                                 }):
//   //                                             ListView.builder(
//   //                                                 physics:
//   //                                                 const BouncingScrollPhysics(),
//   //                                                 itemCount:
//   //                                                 productbyiddata!
//   //                                                     .length,
//   //                                                 shrinkWrap: true,
//   //                                                 itemBuilder:
//   //                                                     (context, index) {
//   //                                                   return Container(
//   //                                                       margin:
//   //                                                       const EdgeInsets
//   //                                                           .only(
//   //                                                           bottom:
//   //                                                           10),
//   //                                                       child: Column(
//   //                                                         children: [
//   //                                                           Container(
//   //                                                             margin:
//   //                                                             const EdgeInsets.all(
//   //                                                                 10),
//   //                                                             child: Row(
//   //                                                               children: [
//   //                                                                 Container(
//   //                                                                   decoration:
//   //                                                                   const BoxDecoration(
//   //                                                                     borderRadius:
//   //                                                                     BorderRadius.all(Radius.circular(15)),
//   //                                                                   ),
//   //                                                                   height:
//   //                                                                   60,
//   //                                                                   width:
//   //                                                                   60,
//   //                                                                   child:
//   //                                                                   ClipRRect(
//   //                                                                     borderRadius:
//   //                                                                     const BorderRadius.all(Radius.circular(15)),
//   //                                                                     child:
//   //                                                                     Image.network(
//   //                                                                       productbyiddata![index].productImage ?? "",
//   //                                                                       fit: BoxFit.cover,
//   //                                                                     ),
//   //                                                                   ),
//   //                                                                 ),
//   //                                                                 const SizedBox(
//   //                                                                   width:
//   //                                                                   10,
//   //                                                                 ),
//   //                                                                 Expanded(
//   //                                                                   child:
//   //                                                                   Column(
//   //                                                                     crossAxisAlignment:
//   //                                                                     CrossAxisAlignment.start,
//   //                                                                     children: [
//   //                                                                       regulartext(AppColors.hint, 12, productbyiddata?[index].name??""),
//   //                                                                       boldtext(AppColors.black, 14, productbyiddata![index].subcategoryId!.toString()),
//   //                                                                     ],
//   //                                                                   ),
//   //                                                                 ),
//   //                                                                 Column(
//   //                                                                   crossAxisAlignment:
//   //                                                                   CrossAxisAlignment.end,
//   //                                                                   children: [
//   //                                                                     regulartext(
//   //                                                                         AppColors.hint,
//   //                                                                         12,
//   //                                                                         "Price range"),
//   //                                                                     boldtext(
//   //                                                                         AppColors.black,
//   //                                                                         14,
//   //                                                                         "${productbyiddata![index].maxPrice.toString()} to ${productbyiddata![index].maxPrice.toString()} "),
//   //                                                                   ],
//   //                                                                 )
//   //                                                               ],
//   //                                                             ),
//   //                                                           )
//   //                                                         ],
//   //                                                       ));
//   //                                                 }),
//   //                                             // SizedBox():SizedBox()
//   //                                           // ListView.builder(
//   //                                           //     itemCount: servicedata.length,
//   //                                           //     shrinkWrap: true,
//   //                                           //     physics: BouncingScrollPhysics(),
//   //                                           //     itemBuilder: (context,index){
//   //                                           //       return ListView.builder(
//   //                                           //           physics: BouncingScrollPhysics(),
//   //                                           //           itemCount: servicedata[index].subMenu.length,
//   //                                           //           shrinkWrap: true,
//   //                                           //           itemBuilder: (context,position){
//   //                                           //
//   //                                           //             return Container(
//   //                                           //                 child: Column(
//   //                                           //                   children: [
//   //                                           //                     Container(
//   //                                           //                       margin: EdgeInsets.all(10),
//   //                                           //                       child: Row(
//   //                                           //                         children: [
//   //                                           //                           Container(
//   //                                           //                             decoration: BoxDecoration(
//   //                                           //                               color: Colors.green,
//   //                                           //                               borderRadius: BorderRadius.all(Radius.circular(15)),
//   //                                           //                             ),
//   //                                           //                             height: 60,
//   //                                           //                             width: 60,
//   //                                           //                             child:  ClipRRect(
//   //                                           //                               borderRadius: BorderRadius.all(Radius.circular(15)),
//   //                                           //                               child:  Image.asset(AppImages.APP_LOGO),
//   //                                           //                             ),
//   //                                           //                           ),
//   //                                           //                           SizedBox(width: 10,),
//   //                                           //                           Expanded(child:  Column(
//   //                                           //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                                           //                             children: [
//   //                                           //                              // regulartext(AppColors.hint,12,servicedata[index].subMenu[position].subname),
//   //                                           //                               boldtext(AppColors.black,14,servicedata[index].subMenu[position].name),
//   //                                           //                             ],
//   //                                           //                           ),),
//   //                                           //                           Column(
//   //                                           //                             crossAxisAlignment: CrossAxisAlignment.end,
//   //                                           //                             children: [
//   //                                           //                               regulartext(AppColors.hint,12,"Price range"),
//   //                                           //                             //  boldtext(AppColors.black,14,servicedata[index].subMenu[position].price),
//   //                                           //                             ],
//   //                                           //                           )
//   //                                           //
//   //                                           //
//   //                                           //                         ],
//   //                                           //                       ),
//   //                                           //                     )
//   //                                           //
//   //                                           //
//   //                                           //                   ],
//   //                                           //                 )
//   //                                           //             );
//   //                                           //           });
//   //                                           //     }):SizedBox()
//   //                                           // ListView.builder(
//   //                                           //     physics: BouncingScrollPhysics(),
//   //                                           //     itemCount: productdata.length,
//   //                                           //     shrinkWrap: true,
//   //                                           //     itemBuilder: (context,index){
//   //                                           //       return ListView.builder(
//   //                                           //           physics: BouncingScrollPhysics(),
//   //                                           //           itemCount: productdata[index].subMenu.length,
//   //                                           //           shrinkWrap: true,
//   //                                           //           itemBuilder: (context,position){
//   //                                           //             return Container(
//   //                                           //                 margin: EdgeInsets.only(bottom: 10),
//   //                                           //                 child: Column(
//   //                                           //                   children: [
//   //                                           //                     Container(
//   //                                           //                       margin: EdgeInsets.all(10),
//   //                                           //                       child: Row(
//   //                                           //                         children: [
//   //                                           //                           Container(
//   //                                           //                             decoration: BoxDecoration(
//   //                                           //                               color: Colors.green,
//   //                                           //                               borderRadius: BorderRadius.all(Radius.circular(15)),
//   //                                           //                             ),
//   //                                           //                             height: 60,
//   //                                           //                             width: 60,
//   //                                           //                             child:  ClipRRect(
//   //                                           //                               borderRadius: BorderRadius.all(Radius.circular(15)),
//   //                                           //                               child:  Image.asset(AppImages.APP_LOGO),
//   //                                           //                             ),
//   //                                           //                           ),
//   //                                           //                           SizedBox(width: 10,),
//   //                                           //                           Expanded(child:  Column(
//   //                                           //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                                           //                             children: [
//   //                                           //                               regulartext(AppColors.hint,12,productdata[index].subMenu[position].subname),
//   //                                           //                               boldtext(AppColors.black,14,productdata[index].subMenu[position].name),
//   //                                           //                             ],
//   //                                           //                           ),),
//   //                                           //                           Column(
//   //                                           //                             crossAxisAlignment: CrossAxisAlignment.end,
//   //                                           //                             children: [
//   //                                           //                               regulartext(AppColors.hint,12,"Price range"),
//   //                                           //                               boldtext(AppColors.black,14,productdata[index].subMenu[position].price),
//   //                                           //                             ],
//   //                                           //                           )
//   //                                           //
//   //                                           //
//   //                                           //                         ],
//   //                                           //                       ),
//   //                                           //                     )
//   //                                           //
//   //                                           //
//   //                                           //                   ],
//   //                                           //                 )
//   //                                           //             );
//   //                                           //           });
//   //                                           //     }),
//   //                                         )
//   //
//   //                                       ],
//   //                                     ),
//   //                                   )
//   //                               )
//   //
//   //                             ],
//   //                           ),
//   //                         )
//   //                       ],
//   //                     ),
//   //
//   //
//   //
//   //                   )
//   //                 ],
//   //               ),
//   //             ),
//   //
//   //             floatingActionButton: Row(
//   //
//   //               crossAxisAlignment: CrossAxisAlignment.center,
//   //               children: [
//   //                 Container(
//   //                   height: 200,
//   //                   width: 200,
//   //                   transform: Matrix4.translationValues(100.0, -100, 0.0),
//   //                   child: Stack(
//   //                     children: [
//   //                       Center(
//   //                         child:  CircleAvatar(
//   //                           radius: 50,
//   //                           backgroundImage: AssetImage(
//   //                              AppImages.APP_LOGO),
//   //                         ),
//   //                       ),
//   //                       Positioned(
//   //                         left: 110,
//   //                         top: 130,
//   //                         child: SvgPicture.asset(AppImages.roundleft),)
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   margin: EdgeInsets.only(left: 100),
//   //                   height: 30,
//   //                   transform: Matrix4.translationValues(45.0, -120, 0.0),  // translate up by 30
//   //                   child: FloatingActionButton(
//   //                     backgroundColor: Colors.white,
//   //                     onPressed: () {
//   //                       Navigator.pop(context);
//   //                     },
//   //                     child: Icon(Icons.close_rounded,color: Colors.black,),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //             floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
//   //           );
//   //         });
//   //
//   //       });
//   //
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
//         request.fields['min_price'] = ratingValue ?? '';
//       }
//       if (endPrice != null) {
//         request.fields['max_price'] = ratingValue ?? '';
//       }
//       if (lat != null) {
//         request.fields['latitude'] = ratingValue ?? '';
//       }
//       if (lng != null) {
//         request.fields['longitude'] = ratingValue ?? '';
//       }
//       if (openAt != null) {
//         request.fields['open_at'] = ratingValue ?? '';
//       }
//       if (closeAt != null) {
//         request.fields['close_at'] = ratingValue ?? '';
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
//   Future<List<Getservicebyuseriddata?>?>? getservicebyid(String userId) async {
//     print("BOKKING DARA LIST OF MYBOOKING");
//     print(ApiUrl.getservicebyid + userId);
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
//         Getservicebyuserid? myBookingModel =
//         Getservicebyuserid.fromJson(jsonDecode(response.body));
//         servicebyiddata = myBookingModel.data!;
//         print("Success");
//         print(servicebyiddata!.length);
//         print(servicebyiddata![0].name);
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
// }
// class ViewProfileSearchWidget extends StatefulWidget {
//   bool? isSupplier;
//   bool? productView;
//   // String? userId;
//   dynamic data;
//   ViewProfileSearchWidget(
//       {super.key, this.productView, this.data, this.isSupplier});
//
//   @override
//   State<ViewProfileSearchWidget> createState() =>
//       _ViewProfileSearchWidgetState();
// }
//
// class _ViewProfileSearchWidgetState extends State<ViewProfileSearchWidget> {
//   String? UserId;
//
//   Future<void> userid() async {
//     UserId = await _sharedPreference.isUsetId();
//     // print("Ashish" + UserId!);
//     setState(() {});
//   }
//
//   _launchPhoneURL(String phoneNumber) async {
//     Uri phoneno = Uri.parse('tel:+$phoneNumber');
//     if (await launchUrl(phoneno)) {
//     } else {}
//   }
//
//   List<ReviewData>? reviewList = [];
//   List<GetUserReviewsData>? mybookingdata = [];
//   Future<List<GetUserReviewsData>?> getUserRating() async {
//     try {
//       print("provider id");
//       print(widget.data["provider_id"].toString());
//       print("provider id");
//       Map<String, String> providerBody = <String, String>{
//         'provider_id': widget.data["provider_id"].toString()
//       };
//
//       final response = await http.post(Uri.parse(ApiUrl.getuserreviews),
//           headers: {"Authorization": USERTOKKEN.toString()},
//           body: providerBody);
//
//       print("response data RATING =================" + response.body);
//       Map<String, dynamic> map = json.decode(response.body);
//
//       if (response.statusCode == 200) {
//         if (widget.data["provider_id"].toString() != null) {
//           ReviewListByProviderModel model = ReviewListByProviderModel.fromJson(
//             jsonDecode(response.body),
//           );
//           reviewList = model.data;
//         }
//
//         print("Success");
//         //print(mybookingdata);
//         setState(() {});
//
//         return mybookingdata;
//       } else {
//         print(response.statusCode);
//         print("Something went wronge");
//       }
//     } catch (e) {
//       print("data==1=$e");
//     }
//   }
//
//   SharedPreference _sharedPreference = new SharedPreference();
//   Future<bool?> addcallloges(
//       String serviceid,
//       String providerId,
//       ) async {
//     try {
//       // showLoader(context);
//
//       String type = await _sharedPreference.isUserType();
//       // print(type);
//       // Map<String, String> requestBody = USER_TYPE == "supplier"
//       //     ? {
//       //         "supplier_id": providerId,
//       //         // 'provider_id': userId,
//       //         'date':
//       //             DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
//       //         'service_id': serviceid,
//       //       }
//       //     : type == "user"
//       //         ? {
//       //             // 'user_id': userId,
//       //             'provider_id': providerId,
//       //             'service_id': serviceid,
//       //             'date': DateFormat("yyyy-MM-dd")
//       //                 .format(DateTime.now())
//       //                 .toString(),
//       //           }
//       //         : {
//       //             'provider_id': providerId,
//       //             'service_id': serviceid,
//       //             'date': DateFormat("yyyy-MM-dd")
//       //                 .format(DateTime.now())
//       //                 .toString(),
//       //           };
//
//       Map<String, String> requestBody = {
//         'provider_id': widget.data["provider_id"].toString(),
//         'service_id': widget.data['id'].toString(),
//         'date': DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
//       };
//
//       // print("USerId1" + userId);
//       print("provider id-------------------" + providerId);
//       print("user" + UserId.toString());
//       print("service id " + serviceid);
//       print(USERTOKKEN.toString());
//       print("type----------------" + type);
//       final response = widget.productView == true
//           ? await http.post(
//           Uri.parse(widget.isSupplier == true
//               ? "https://saath.lttrbx.in/api/add-supplier-call-logs-product"
//               : "https://saath.lttrbx.in/api/add-call-logs-product"),
//           headers: {
//             "Authorization": USERTOKKEN.toString()
//           },
//           body: {
//             widget.isSupplier == true ? "supplier_id" : "provider_id":
//             providerId,
//             "product_id": serviceid,
//             "date":
//             DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
//           })
//           : await http.post(
//         Uri.parse(widget.isSupplier == true
//             ? "https://saath.lttrbx.in/api/add-supplier-call-logs"
//             : "https://saath.lttrbx.in/api/add-call-logs"),
//         headers: {"Authorization": USERTOKKEN.toString()},
//         body: {
//           widget.isSupplier == true ? "supplier_id" : "provider_id":
//           providerId,
//           "date":
//           DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
//           "service_id": serviceid
//         },
//       );
//       Map<String, dynamic> map = json.decode(response.body);
// //
//       print("AshishResponce" + response.body.toString());
//
//       if (response.statusCode == 200) {
//         // AddCallModel? addCallModel =
//         //     AddCallModel.fromJson(jsonDecode(response.body));
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Call Logs Added"),
//         ));
//
//         // _launchPhoneURL(number);
//         hideLoader();
//
//         return true;
//       } else {
//         print('call log');
//         print("Something went wrong");
//
//         return false;
//       }
//     } catch (e) {
//       print("call log error ====================>");
//       print("data==1=$e");
//     }
//   }
//
//   var controller = Get.find<ServiceProductProfile>();
//   @override
//   void initState() {
//     getUserRating();
//     // TODO: implement initState
//     super.initState();
//     userid();
//     controller.getProfile(widget.data["provider_id"].toString());
//     // controller.getProfile(widget.userId.toString());
//     print("PROVIDER ID");
//     print(widget.data["provider_id"]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<String>? ratingList =
//     reviewList?.map((element) => element.rating.toString()).toList();
//     print('RATING LIST==================>');
//     print(ratingList);
//     print(reviewList?.length);
//     print(mybookingdata?.length);
//     return Scaffold(
//         backgroundColor: AppColors.gradient3,
//         appBar: APPBar(
//           title: " Profile",
//         ),
//         body: SingleChildScrollView(
//             child: GetX<ServiceProductProfile>(builder: (profile) {
//               print('GET PROFILE _______');
//               print(profile.profileList);
//               print('WIDGET DATA');
//               print(widget.data);
//               return profile.isLoading.value == true
//                   ? const Center(child: CircularProgressIndicator())
//                   : Column(children: [
//                 vertical(20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // widget.data[widget.isSupplier == true
//                     //             ? "supplier_service_image"
//                     //             : "service image"] ==
//                     //         null
//                     //     ? const CircleAvatar(
//                     //         radius: 60,
//                     //         child: Icon(Icons.person),
//                     //       )
//                     //     :
//                     const CircleAvatar(
//                       radius: 60,
//                       child: Icon(Icons.person),
//                     ),
//                     // CircleAvatar(
//                     //         backgroundColor: AppColors.white,
//                     //         radius: 60,
//                     //         backgroundImage: NetworkImage(
//                     //             widget.isSupplier == true
//                     //                 ? widget.data["supplier_service_image"][0]
//                     //                 : profile.profileList["provider_service"]
//                     //                     [0]["service_image"][0]),
//                     //       ),
//                     horizental(20),
//                     SizedBox(
//                       width: 250,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           boldtext(
//                               AppColors.black,
//                               20,
//                               widget.isSupplier == true
//                                   ? widget.data["name"]
//                                   : widget.productView == true
//                                   ? widget.data["name"]
//                                   : widget.data["service_name"] ?? ""
//                             // : profile.profileList["display_name"] ??
//                             //     ""
//                           ),
//                           StarsView(
//                             total: 5,
//                             // total: int.parse(widget.data["rating"] as String),
//                             // colored: widget.isSupplier == true
//                             //     ? widget.data["total_rating"]
//                             //     : widget.data["rating"].toInt(),
//                             colored: double.parse(
//                               widget.isSupplier == true
//                                   ? widget.data["rating"].toString()
//                                   : widget.data["rating"].toString(),
//                             ).toInt(),
//                             ontap: () {
//                               Get.to(
//                                     () => RatingandReviewByUserScreens(
//                                   isProduct: widget.productView,
//                                   isSupplier: widget.isSupplier,
//                                   serviceOrProductId:
//                                   widget.data["id"].toString(),
//                                   user_id: widget.productView == true
//                                       ? widget.data["provider_id"].toString()
//                                       : widget.data["service_id"].toString(),
//                                 ),
//                               );
//                             },
//                           ),
//                           // widget.isSupplier == true
//                           //     ? const SizedBox()
//                           //     :
//                           widget.data != null
//                           // &&
//                           // widget.data["provider_id"] != null
//                               ? Padding(
//                             padding: const EdgeInsets.only(right: 30),
//                             child: ButtonMain(
//                               ontap: () {
//                                 var id;
//                                 if (widget.productView == true) {
//                                   // for (var i = 0;
//                                   //     i <
//                                   //         profile
//                                   //             .profileList[
//                                   //                 "provider_product"]
//                                   //             .length;
//                                   //     i++) {
//                                   //   if (profile.profileList[
//                                   //               "provider_product"][i]
//                                   //           ["name"] ==
//                                   //       widget.data["name"]) {
//                                   //     id = profile.profileList[
//                                   //         "provider_product"][i]["id"];
//
//                                   addcallloges(
//                                     widget.data["id"].toString(),
//                                     widget.data["provider_id"]
//                                         .toString(),
//                                   ).then((value) {
//                                     if (value == true) {
//                                       _launchPhoneURL(
//                                         profile.profileList[
//                                         "contact_number"],
//                                       );
//                                     }
//                                   });
//                                   //   }
//                                   // }
//                                 } else {
//                                   addcallloges(
//                                     widget.data["id"].toString(),
//                                     widget.data["provider_id"]
//                                         .toString(),
//                                   ).then(
//                                         (value) => _launchPhoneURL(
//                                       profile.profileList[
//                                       "contact_number"],
//                                     ),
//                                   );
//                                 }
//                               },
//                               text: "Call  ",
//                               height: 35,
//                               fsize: 12,
//                               fcolor: AppColors.LightWhite,
//                               bgcolor: AppColors.blue,
//                               width: 0.25,
//                               loader: false,
//                             ),
//                           )
//                               : const SizedBox.shrink()
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 vertical(25),
//                 vertical(50),
//                 rowView(
//                   // widget.isSupplier == true
//                   //     ? "Name"
//                   //     :
//                   widget.productView == true
//                       ? "${widget.data["provider_name"]}"
//                       : profile.profileList["display_name"] ?? "",
//                   AppImages.P_OCCUPATION,
//                 ),
//                 rowView(
//                   // widget.isSupplier == true
//                   //     ? "Mobile Number"
//                   //     :
//                     profile.profileList["contact_number"] == null
//                         ? "Mobile Number"
//                         : profile.profileList["contact_number"],
//                     AppImages.P_CALL),
//                 rowView(
//                   // widget.isSupplier == true
//                   //     ? "Email"
//                   //     :
//                     profile.profileList["email"] == null
//                         ? "Email"
//                         : profile.profileList["email"],
//                     AppImages.P_MAIL),
//                 // widget.isSupplier == true
//                 //     ? const SizedBox.shrink()
//                 //     :
//                 if (profile.profileList.isNotEmpty)
//                   AllProductServices(
//                     data: profile.profileList,
//                   ),
//                 vertical(150),
//               ]);
//             })));
//   }
//
//   Widget rowView(String title, String imgurl, {Widget? child}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 imgurl,
//                 width: 25,
//               ),
//               horizental(20),
//               child != null && title == "DropdownButton"
//                   ? child
//                   : SizedBox(
//                   width: Get.width * 0.8,
//                   child: boldtext(AppColors.black, 14, title))
//             ],
//           ),
//           const Divider(
//             thickness: 2,
//             color: Colors.grey,
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class AllProductServices extends StatelessWidget {
//   dynamic data;
//   AllProductServices({super.key, this.data});
// //  final controller = Get.find<ProviderServiceController>();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           margin: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.black),
//               borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             children: [
//               Align(
//                   alignment: Alignment.centerRight,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => MyServices(
//
//                           ),
//                         ),
//                       );
//                     },
//                     child: Image.asset(
//                       AppImages.P_MENU,
//                       height: 40,
//                     ),
//                   )),
//               vertical(20),
//               SizedBox(
//                 height: 150,
//                 child: data["provider_service"].isEmpty &&
//                     data["provider_product"].isEmpty
//                     ? boldtext(AppColors.red, 13, 'No Products Available')
//                     : SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   controller: ScrollController(),
//                   child: Row(
//                     children: [
//                       ListView.builder(
//                           controller: ScrollController(),
//                           shrinkWrap: true,
//                           itemCount: data["provider_service"].length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SizedBox(
//                                 width: 100,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 70,
//                                       child: CustomClipPolygon(
//                                         sides: 8,
//                                         rotate: 22,
//                                         borderRadius: 5.0,
//                                         boxShadows: [
//                                           PolygonBoxShadow(
//                                               color: Colors.black,
//                                               elevation: 1.0),
//                                           PolygonBoxShadow(
//                                               color: Colors.grey,
//                                               elevation: 5.0)
//                                         ],
//                                         child: Image.network(
//                                           data["provider_service"][index]
//                                           ["service_image"][0],
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       child: regulartext(
//                                         AppColors.black,
//                                         12,
//                                         data["provider_service"][index]
//                                         ["name"],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                       ListView.builder(
//                           controller: ScrollController(),
//                           shrinkWrap: true,
//                           itemCount: data["provider_product"].length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SizedBox(
//                                 width: 100,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 70,
//                                       child: CustomClipPolygon(
//                                         sides: 8,
//                                         rotate: 22,
//                                         borderRadius: 5.0,
//                                         boxShadows: [
//                                           PolygonBoxShadow(
//                                               color: Colors.black,
//                                               elevation: 1.0),
//                                           PolygonBoxShadow(
//                                               color: Colors.grey,
//                                               elevation: 5.0)
//                                         ],
//                                         child: Image.network(
//                                           data["provider_product"][index]
//                                           ["product_image"][0],
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       child: regulartext(
//                                         AppColors.black,
//                                         12,
//                                         data["provider_product"][index]
//                                         ["name"],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           })
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           color: AppColors.gradient3,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           margin: const EdgeInsets.symmetric(
//             horizontal: 25,
//           ),
//           child: boldtext(AppColors.black, 14, "My Product and Services"),
//         )
//       ],
//     );
//   }
// }
//
//
//
//
//
// class CustomClipPolygon extends StatelessWidget {
//   final Widget child;
//   final int sides;
//   final double rotate;
//   final double borderRadius;
//   final List<PolygonBoxShadow> boxShadows;
//
//   CustomClipPolygon(
//       {required this.child,
//         required this.sides,
//         this.rotate: 0.0,
//         this.borderRadius: 0.0,
//         this.boxShadows: const []});
//
//   @override
//   Widget build(BuildContext context) {
//     PolygonPathSpecs specs = PolygonPathSpecs(
//       sides: sides < 3 ? 3 : sides,
//       rotate: rotate,
//       borderRadiusAngle: borderRadius,
//     );
//
//     return AspectRatio(
//         aspectRatio: 1.0,
//         child: CustomPaint(
//             painter: BoxShadowPainter(specs, boxShadows),
//             child: ClipPath(
//               clipper: Polygon(specs),
//               child: child,
//             )));
//   }
// }
//
// class Polygon extends CustomClipper<Path> {
//   final PolygonPathSpecs specs;
//
//   Polygon(this.specs);
//
//   @override
//   Path getClip(Size size) {
//     return PolygonPathDrawer(size: size, specs: specs).draw();
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
//
// class BoxShadowPainter extends CustomPainter {
//   final PolygonPathSpecs specs;
//   final List<PolygonBoxShadow> boxShadows;
//
//   BoxShadowPainter(this.specs, this.boxShadows);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = PolygonPathDrawer(size: size, specs: specs).draw();
//
//     boxShadows.forEach((PolygonBoxShadow shadow) {
//       canvas.drawShadow(path, shadow.color, shadow.elevation, false);
//     });
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class PolygonBoxShadow {
//   final Color color;
//   final double elevation;
//
//   PolygonBoxShadow({
//     required this.color,
//     required this.elevation,
//   });
// }
//
// class PolygonPathDrawer {
//   final Path path;
//   final Size size;
//   final PolygonPathSpecs specs;
//
//   PolygonPathDrawer({
//     required this.size,
//     required this.specs,
//   }) : path = Path();
//
//   Path draw() {
//     final anglePerSide = 360 / specs.sides;
//
//     final radius = (size.width - specs.borderRadiusAngle) / 2;
//     final arcLength =
//         (radius * _angleToRadian(specs.borderRadiusAngle)) + (specs.sides * 2);
//
//     Path path = Path();
//
//     for (var i = 0; i <= specs.sides; i++) {
//       double currentAngle = anglePerSide * i;
//       bool isFirst = i == 0;
//
//       if (specs.borderRadiusAngle > 0) {
//         _drawLineAndArc(path, currentAngle, radius, arcLength, isFirst);
//       } else {
//         _drawLine(path, currentAngle, radius, isFirst);
//       }
//     }
//
//     return path;
//   }
//
//   _drawLine(Path path, double currentAngle, double radius, bool move) {
//     Offset current = _getOffset(currentAngle, radius);
//
//     if (move)
//       path.moveTo(current.dx, current.dy);
//     else
//       path.lineTo(current.dx, current.dy);
//   }
//
//   _drawLineAndArc(Path path, double currentAngle, double radius,
//       double arcLength, bool isFirst) {
//     double prevAngle = currentAngle - specs.halfBorderRadiusAngle;
//     double nextAngle = currentAngle + specs.halfBorderRadiusAngle;
//
//     Offset previous = _getOffset(prevAngle, radius);
//     Offset next = _getOffset(nextAngle, radius);
//
//     if (isFirst) {
//       path.moveTo(next.dx, next.dy);
//     } else {
//       path.lineTo(previous.dx, previous.dy);
//       path.arcToPoint(next, radius: Radius.circular(arcLength));
//     }
//   }
//
//   double _angleToRadian(double angle) {
//     return angle * (pi / 180);
//   }
//
//   Offset _getOffset(double angle, double radius) {
//     final rotationAwareAngle = angle - 90 + specs.rotate;
//
//     final radian = _angleToRadian(rotationAwareAngle);
//     final x = cos(radian) * radius + radius + specs.halfBorderRadiusAngle;
//     final y = sin(radian) * radius + radius + specs.halfBorderRadiusAngle;
//
//     return Offset(x, y);
//   }
// }
//
// class PolygonPathSpecs {
//   final int sides;
//   final double rotate;
//   final double borderRadiusAngle;
//   final double halfBorderRadiusAngle;
//
//   PolygonPathSpecs({
//     required this.sides,
//     required this.rotate,
//     required this.borderRadiusAngle,
//   }) : halfBorderRadiusAngle = borderRadiusAngle / 2;
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TranslateDemo(),
    );
  }
}

class TranslateDemo extends StatefulWidget {
  @override
  _TranslateDemoState createState() => _TranslateDemoState();
}

class _TranslateDemoState extends State<TranslateDemo> {
  final String apiKey = 'AIzaSyC-YuBjaE5a6htqora99l1P2bk4JmnpH6E'; // Replace with your API key
  final String apiUrl = 'https://translation.googleapis.com/language/translate/v2';

  String sourceText = 'Hello';
  String translatedText = '';
  String sourceLanguage = 'en';
  String targetLanguage = 'es';

  Future<void> translate() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': sourceText,
        'target': targetLanguage,
        'source': sourceLanguage,
        'key': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        translatedText = data['data']['translations'][0]['translatedText'];
      });
    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Translate Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Source Text:'),
            TextField(
              onChanged: (text) {
                setState(() {
                  sourceText = text;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: translate,
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            Text('Translated Text:'),
            Text(translatedText),
          ],
        ),
      ),
    );
  }
}





