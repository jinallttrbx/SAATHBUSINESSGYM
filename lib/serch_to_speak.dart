//
// import 'dart:convert';
//
// import 'package:businessgym/Utils/ApiUrl.dart';
// import 'package:businessgym/Utils/SharedPreferences.dart';
// import 'package:businessgym/Utils/common_route.dart';
// import 'package:businessgym/conts/global_values.dart';
// import 'package:businessgym/values/Colors.dart';
// import 'package:businessgym/values/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'model/ProviderModel.dart';
//
// class teacherscreen extends StatefulWidget {
//   int? id;
//   String? name;
//   String? categoryImage;
//   bool? isSupplier;
//   teacherscreen(this.id, this.name, this.categoryImage, this.isSupplier);
//
//   @override
//   State<teacherscreen> createState() => Teacher();
// }
//
// class Teacher extends State<teacherscreen> {
//   List<ProviderData> list =  [];
//   List<ProviderData> searchlist=[];
//   List<ProviderData?>? data;
//   List<ProviderModel?>? allserviceCategory =[];
//   bool isLoading = true;
//   String? UserId;
//   SharedPreference _sharedPreference = new SharedPreference();
//   String imagepath =
//       "http://colegioatenea.embedinfosoft.com/wp-content/plugins/scl-rest-api/img/default_avtar.jpg";
//   TextEditingController search = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     userid();
//     callAPI();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//             titleSpacing: 0,
//             elevation: 0,
//             backgroundColor: AppColors.primary,
//             title: Text(
//               "teachers".tr,
//             ),
//             ),
//         body: Stack(
//           children: [
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                         height: 90,
//                         decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 bottomRight: Radius.circular(20)),
//                             color: AppColors.primary),
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 15, right: 15),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: TextField(
//                                     controller: search,
//                                     autofocus: false,
//                                     decoration: InputDecoration(
//                                         prefixIcon: IconButton(
//                                           icon: Icon(
//                                             Icons.search,
//                                             color: AppColors.secondaryColor,
//                                           ),
//                                           onPressed: () {},
//                                         ),
//                                         hintText: 'search',
//
//                                         contentPadding:
//                                         const EdgeInsets.all(10),
//                                         border: InputBorder.none),
//
//                                     keyboardType: TextInputType.text,
//                                     textInputAction: TextInputAction.next,
//                                     onChanged: onSearchTextChanged,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                     Expanded(
//                       child: searchlist.length != 0 || search.text.isNotEmpty?
//                       ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           itemCount: searchlist.isEmpty?5:searchlist.length,
//                           itemBuilder: (context, position) {
//                             return GestureDetector(
//                               onTap: () {
//                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>teacherdetail(list[position].id,list[position].subjectName!.join("\n"),list[position].incharge!.join(" "))));
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 10),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 5),
//                                   child: Container(
//                                     // height: 120,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.primary
//                                             .withOpacity(0.05),
//                                         borderRadius:
//                                         const BorderRadius.all(
//                                             Radius.circular(15))),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                               BorderRadius.circular(10),
//                                             ),
//                                             child: Container(
//                                                 margin: EdgeInsets.all(10),
//                                                 height: 80,
//                                                 width: 80,
//                                                 decoration: const BoxDecoration(
//                                                     color: Colors.purple,
//                                                     borderRadius:
//                                                     BorderRadius.all(
//                                                         Radius.circular(
//                                                             80))),
//                                                 child: ClipRRect(
//                                                     borderRadius:
//                                                     const BorderRadius
//                                                         .all(
//                                                         Radius.circular(
//                                                             80)),
//                                                     child: Image.network(
//                                                       searchlist.isEmpty?imagepath:searchlist[position].socialImage!,
//                                                       fit: BoxFit.fitHeight,
//                                                     )))),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 10),
//                                                 child: Text(
//                                                   searchlist.isEmpty?"Teacher Name":searchlist[position].displayName!,
//
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 5,bottom: 10),
//                                                 child: Text( searchlist.isEmpty?"subjects":searchlist[position].serviceName!,
//
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }):
//                       ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           itemCount: list.isEmpty?5:list.length,
//                           itemBuilder: (context, position) {
//                             return GestureDetector(
//                               onTap: () {
//                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>teacherdetail(list[position].id,list[position].subjectName!.join("\n"),list[position].incharge!.join(" "))));
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 10),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 5),
//                                   child: Container(
//                                     // height: 120,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.primary
//                                             .withOpacity(0.05),
//                                         borderRadius:
//                                         const BorderRadius.all(
//                                             Radius.circular(15))),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                               BorderRadius.circular(10),
//                                             ),
//                                             child: Container(
//                                                 margin: EdgeInsets.all(10),
//                                                 height: 80,
//                                                 width: 80,
//                                                 decoration: const BoxDecoration(
//                                                     color: Colors.purple,
//                                                     borderRadius:
//                                                     BorderRadius.all(
//                                                         Radius.circular(
//                                                             80))),
//                                                 child: ClipRRect(
//                                                     borderRadius:
//                                                     const BorderRadius
//                                                         .all(
//                                                         Radius.circular(
//                                                             80)),
//                                                     child: Image.network(
//                                                       list.isEmpty?imagepath:list[position].socialImage!,
//                                                       fit: BoxFit.fitHeight,
//                                                     )))),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 10),
//                                                 child: Text(
//                                                   list.isEmpty?"Teacher Name":list[position].displayName!,
//
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 5,bottom: 10),
//                                                 child: Text( list.isEmpty?"subjects":list[position].serviceName!,
//
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                   ],
//                 )),
//
//           ],
//         ));
//   }
//
//   Future<List<ProviderData?>?> callAPI() async {
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
//         return data;
//       } else {
//         hideLoader();
//         print("Something went wronge");
//       }
//     } catch (e) {
//       print("data===$e");
//     }
//
//
//
//   }
//   onSearchTextChanged(String text) async {
//     searchlist.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//
//     list.forEach((userDetail) {
//       if (userDetail.displayName!.isCaseInsensitiveContains(text) || userDetail.serviceName!.isCaseInsensitiveContains(text))
//         searchlist.add(userDetail);
//     });
//
//     setState(() {});
//   }
//
//   Future<void> userid() async {
//     UserId = await _sharedPreference.isUsetId();
//     // print("Ashish" + UserId!);
//     //cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
//     //allserviceCategory = getAllserviceCategory(UserId!);
//     setState(() {});
//   }
// }
