// import 'package:businessgym/Controller/occupationController.dart';
// import 'package:businessgym/Controller/profileController.dart';
// import 'package:businessgym/Controller/userprofilecontroller.dart';
// import 'package:businessgym/components/snackbar.dart';
// import 'package:businessgym/conts/addressWidget.dart';
//
// import 'package:businessgym/Controller/workprofileController.dart';
// import 'package:businessgym/conts/selectloaction.dart';
// import 'package:dio/dio.dart';
// import 'package:dio/dio.dart' as d;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/instance_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
//
// import '../../Utils/ApiUrl.dart';
// import '../../Utils/SharedPreferences.dart';
// import '../../Utils/common_route.dart';
// import '../../model/ViewoccuaptionsModel.dart';
// import '../../model/viewWork_profileModel.dart';
// import '../../values/Colors.dart';
// import '../../values/const_text.dart';
// import '../../values/spacer.dart';
// import '../../conts/global_values.dart';
//
// class AddEditBusinessProfileScreen extends StatefulWidget {
//   final bool isEdit;
//   final ViewWorkProfileModelClass? workProfile;
//   const AddEditBusinessProfileScreen(
//       {super.key, required this.isEdit, this.workProfile});
//
//   @override
//   AddEditBusinessProfileScreenState createState() => AddEditBusinessProfileScreenState();
// }
//
// class AddEditBusinessProfileScreenState extends State<AddEditBusinessProfileScreen> {
//   final profile = Get.find<UserProfileController>();
//   final workController = Get.find<WorkProfileController>();
//   final profileuser = Get.find<ProfileController>();
//   final occupationcontroller = Get.find<OccupationController>();
//   String dropdownvalue1 = '10:00 AM';
//   String dropdownvalue2 = '9:00 PM';
//   var items1 = [
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 AM',
//     '1:00 AM',
//     '2:00 AM',
//     '3:00 AM',
//     '4:00 AM',
//     '5:00 AM',
//     '6:00 AM',
//     '7:00 AM',
//     '8:00 AM',
//     '9:00 AM'
//   ];
//   var items2 = [
//     '9:00 PM',
//     '10:00 PM',
//     '11:00 PM',
//     '12:00 PM',
//     '1:00 PM',
//     '2:00 PM',
//     '3:00 PM',
//     '4:00 PM',
//     '5:00 PM',
//     '6:00 PM',
//     '7:00 PM',
//     '8:00 PM'
//   ];
//
//   SharedPreference sharedPreference = SharedPreference();
//
//   final workcontroller = Get.find<WorkProfileController>();
//
//   addBusinnessdata() async {
//     final userId = await sharedPreference.isUsetId();
//     final usertoken = await sharedPreference.isToken();
//     var mobile = await sharedPreference.isMobile();
//     String url = ApiUrl.addbusinessWorkURL;
//     var header = {"Authorization": USERTOKKEN.toString()};
//     var request = http.MultipartRequest("POST", Uri.parse(url));
//     showLoader(context);
//     try {
//       if (widget.isEdit) {
//         request.fields["id"] = widget.workProfile!.workProfileId.toString();
//       }
//       request.fields["user_id"]=userId.toString();
//       request.fields["occupation_id"] = occupationid;
//       request.fields["name"] = nameOfBusineesController.text;
//       request.fields["email"] = '';
//       request.fields["mode_of_business"] = modelOfBusiness ?? '';
//       request.fields["business_address"] = businessAddressController.text;
//       request.fields["mobile"] = mobile;
//       request.fields["travel_charge"] = '50';
//       request.fields["gst_number"] = gstNumberController.text;
//       request.fields["licence_number"] = licenseController.text;
//       request.fields["latitude"] = latlng?.latitude.toString() ?? '0.0';
//       request.fields["longitude"] = latlng?.longitude.toString() ?? '0.0';
//       request.fields["location"] = locationController.text;
//       request.fields["open_at"] = openTime ?? '';
//       request.fields["close_at"] = closeTime ?? '';
//       request.headers.addAll(header);
//       print(request.fields);
//       final response = await request.send()
//       // final data = await http.Response.fromStream(response);
//       // print(data.body);
//       // print(response.statusCode);
//           .then((value) async {
//         await workcontroller.viewworkProfile();
//         showInSnackBar("Add Successfully");
//       });
//       hideLoader();
//       Navigator.of(context).pop();
//     } catch (e) {
//       hideLoader();
//       print(e.toString());
//       return d.Response(requestOptions: RequestOptions(path: url));
//     }
//   }
//
//   ViewoccuaptionsModelData? occupation;
//   String occupationid="";
//   String occupationname="";
//
//   String? modelOfBusiness ;
//   String? openTime = '10:00 AM';
//   String? closeTime = '9:00 PM';
//   LatLng? latlng;
//   final nameOfBusineesController = TextEditingController();
//   final businessAddressController = TextEditingController();
//   final locationController = TextEditingController();
//   final gstNumberController = TextEditingController();
//   final licenseController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit) {
//       // occupationid = profileuser.listData1
//       // .firstWhere((element) => element.id == widget.workProfile?.typeId);
//       nameOfBusineesController.text = widget.workProfile?.workProfileName ?? "";
//       modelOfBusiness = widget.workProfile?.modeOfBusiness??"";
//       openTime = widget.workProfile?.openAt??"";
//       closeTime = widget.workProfile?.closeAt??"";
//       businessAddressController.text = widget.workProfile?.businessAddress ?? '';
//       gstNumberController.text = widget.workProfile?.gstNumber ?? "";
//       licenseController.text = widget.workProfile?.licenceNumber ?? '';
//       locationController.text=widget.workProfile?.location ??"";
//       occupationcontroller.viewoccupation();
//       setState(() {});
//
//     }
//   }
//
//   final profilecontroller = Get.find<UserProfileController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.BGColor,
//       appBar: AppBar(
//         elevation: 1,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//
//         backgroundColor: Colors.white,
//         // flexibleSpace: Container(
//         //   decoration: BoxDecoration(gradient: bgGradient),
//         // ),
//         title: boldtext(Colors.black, 20,
//             widget.isEdit ? "Edit Work Profile" : "Add Work Profile"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(16))),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       regulartext(AppColors.primary, 16, "Business Details"),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Divider(
//                         height: 1,
//                         thickness: 1,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                           margin:
//                           const EdgeInsets.only(top: 20, left: 20, right: 20),
//                           child: Column(
//                             children: [
//
//                             ],
//                           )
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 0, right: 0),
//                         child: Column(
//                           children: [
//                             DropdownButtonFormField<ViewoccuaptionsModelData?>(
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: AppColors.white,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                       color: Colors.grey, width: 1.0),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                       color: Colors.grey, width: 1.0),
//                                 ),
//                                 contentPadding:
//                                 const EdgeInsets.symmetric(
//                                     vertical: 0, horizontal: 10),
//                                 border: const OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: Colors.grey)),
//                               ),
//                               hint: boldtext(AppColors.black, 14,
//                                   "Select occupation"),
//                               isExpanded: true,
//                               // value: snapshot.data![0],
//                               items: occupationcontroller.productprofilelist!.map((name) {
//                                 return DropdownMenuItem<
//                                     ViewoccuaptionsModelData?>(
//                                   value: name,
//                                   child: Row(
//                                     children: [
//                                       boldtext(AppColors.black, 13,
//                                           "${name.title}"),
//                                       const Spacer(),
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (val) {
//                                 occupationid = val!.id.toString();
//                                 print(occupationid);
//                               },
//
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         textCapitalization: TextCapitalization.words,
//                         controller: nameOfBusineesController,
//                         decoration: InputDecoration(
//                           contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 10),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.grey, width: 0.25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.white, width: 0.25),
//                           ),
//                           filled: true,
//                           border: InputBorder.none,
//                           fillColor: AppColors.textfieldcolor,
//                           hintText: "Name of Business",
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         margin: const EdgeInsets.only(left: 0, right: 0),
//                         child: DropdownButtonFormField(
//                           value: modelOfBusiness,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: AppColors.white,
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                   color: Color(0xffA6A6A6), width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                   color: AppColors.hint, width: 1.0),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               // vertical: 10,
//                               horizontal: 10,
//                             ),
//                             border: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)),
//                           ),
//                           dropdownColor: Colors.white,
//                           hint:
//                           boldtext(AppColors.grey, 14, "Model of Business"),
//                           onChanged: (String? newValue) {
//                             modelOfBusiness = newValue;
//                             setState(() {});
//                           },
//                           items: <String>['Mobile', 'Fixed',]
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       // DropdownButtonFormField<String>(
//                       //   hint: const Text('Select your favourite fruit'),
//                       //   value: dropdownValue,
//                       //   onChanged: (String? newValue) {
//                       //     setState(() {
//                       //       dropdownValue = newValue!;
//                       //     });
//                       //   },
//                       //   items: <String>['Apple', 'Mango', 'Banana', 'Peach']
//                       //       .map<DropdownMenuItem<String>>((String value) {
//                       //     return DropdownMenuItem<String>(
//                       //       value: value,
//                       //       child: Text(value),
//                       //     );
//                       //   }).toList(),
//                       // ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       boldtext(
//                         AppColors.black,
//                         14,
//                         "Working hour",
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 regulartext(
//                                   AppColors.black,
//                                   14,
//                                   "Open at",
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: const EdgeInsets.only(
//                                       left: 17, right: 17),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12.0),
//                                     border: Border.all(
//                                         color: Colors.black,
//                                         style: BorderStyle.solid,
//                                         width: 0.80),
//                                   ),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton(
//                                       elevation: 0,
//                                       value: openTime,
//                                       icon:
//                                       const Icon(Icons.keyboard_arrow_down),
//                                       items: items1.map((String items) {
//                                         return DropdownMenuItem(
//                                             value: items, child: Text(items));
//                                       }).toList(),
//                                       onChanged: (String? newValue) {
//                                         setState(() {
//                                           openTime = newValue;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           horizental(10),
//                           Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   regulartext(
//                                     AppColors.black,
//                                     14,
//                                     "Close at",
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Container(
//                                     height: 45,
//                                     width: MediaQuery.of(context).size.width,
//                                     padding:
//                                     const EdgeInsets.only(left: 17, right: 17),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       border: Border.all(
//                                           color: Colors.black,
//                                           style: BorderStyle.solid,
//                                           width: 0.80),
//                                     ),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         elevation: 0,
//                                         value: closeTime,
//                                         icon: const Icon(Icons.keyboard_arrow_down),
//                                         items: items2.map((String items) {
//                                           return DropdownMenuItem(
//                                               value: items, child: Text(items));
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             closeTime = newValue;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         textCapitalization: TextCapitalization.words,
//                         controller: businessAddressController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.grey, width: 0.25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.white, width: 0.25),
//                           ),
//                           filled: true,
//                           border: InputBorder.none,
//                           fillColor: AppColors.textfieldcolor,
//                           hintText: "Address",
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       CustomSelectMapfrom(
//                           controller: locationController, latlng: latlng),
//                       vertical(5),
//                       // locationController.text.isEmpty? ShowAddress():
//                       //  Text(locationController.text),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         textCapitalization: TextCapitalization.characters,
//                         controller: gstNumberController,
//                         decoration: InputDecoration(
//                           contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 10),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.grey, width: 0.25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.white, width: 0.25),
//                           ),
//                           filled: true,
//                           border: InputBorder.none,
//                           fillColor: AppColors.textfieldcolor,
//                           hintText: "GST No.",
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         textCapitalization: TextCapitalization.characters,
//                         controller: licenseController,
//                         decoration: InputDecoration(
//                           contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 10),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.grey, width: 0.25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(
//                                 color: Colors.white, width: 0.25),
//                           ),
//                           filled: true,
//                           border: InputBorder.none,
//                           fillColor: AppColors.textfieldcolor,
//                           hintText: "Vendors License No.",
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(12))),
//                               backgroundColor: AppColors.primary),
//                           onPressed: () {
//                             // String _gstRegExp = r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[0-9A-Z]{1}$';
//                             // RegExp regExp1 = new RegExp(_gstRegExp);
//                             String patttern = r'^[a-z A-Z,.\-]+$';
//                             RegExp regExp = new RegExp(patttern);
//                             if (occupationid == "") {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                       Text('Please Select Occupation')));
//                             } else if (modelOfBusiness == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text(
//                                           'Please select model of business')));
//                             } else if (nameOfBusineesController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                       Text('Please enter business name')));
//                             } else if (!regExp.hasMatch(nameOfBusineesController.text)){
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text("Please Enter valid Name "),
//                                     duration: const Duration(seconds: 2),
//                                   ));
//                             } else if(businessAddressController.text.isEmpty){
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Please enter Address'),
//                                 ),
//                               );
//                             }
//                             else if (locationController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Please enter location'),
//                                 ),
//                               );
//                               //  } else if(!regExp1.hasMatch(gstNumberController.text)){
//                               //  ScaffoldMessenger.of(context).showSnackBar(
//                               //  const SnackBar(
//                               //  content: Text('Please Valid Gst Number'),
//                               //  ),
//                               //  );
//                             }
//                             else {
//                               addBusinnessdata();
//                             }
//                           },
//                           child: boldtext(
//                             Colors.white,
//                             16,
//                             "Save",
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
