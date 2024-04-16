// // // ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, file_names, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, duplicate_ignore, deprecated_member_use
// //
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:typed_data';
// //
// //
// // import 'package:businessgym/components/button.dart';
// // import 'package:businessgym/components/snackbar.dart';
// // import 'package:businessgym/conts/appbar_global.dart';
// // import 'package:businessgym/conts/global_values.dart';
// // import 'package:businessgym/model/AllDocumentList.dart';
// // import 'package:businessgym/values/const_text.dart';
// // import 'package:businessgym/values/spacer.dart';
// // import 'package:dio/dio.dart';
// // import 'package:dio/dio.dart' as d;
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_gallery_saver/image_gallery_saver.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:share_plus/share_plus.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // import '../../../Utils/ApiUrl.dart';
// // import '../../../Utils/SharedPreferences.dart';
// // import '../../../Utils/common_route.dart';
// // import '../../../model/DocumentUploadModel.dart';
// //
// // import '../../../values/Colors.dart';
// // import '../../../values/assets.dart';
// //
// // class PersonalEntitlementsScreen extends StatefulWidget {
// //   String? title;
// //   String? catId;
// //   PersonalEntitlementsScreen(this.title, this.catId);
// //
// //   @override
// //   PersonalEntitlementsScreenState createState() =>
// //       PersonalEntitlementsScreenState();
// // }
// //
// // class PersonalEntitlementsScreenState
// //     extends State<PersonalEntitlementsScreen> {
// //   SharedPreference sharedPreference = SharedPreference();
// //   bool isLoading = false;
// //   List images = ['', '', ''];
// //   bool isChecked1 = false;
// //   bool isChecked2 = false;
// //   bool isChecked3 = false;
// //   File? _image;
// //   PickedFile? pickedImage;
// //   final ImagePicker picker = ImagePicker();
// //   Future<List<AllDocumentListdata?>?>? AllDocument;
// //   List<AllDocumentListdata>? Documentlist = [];
// //  // Future<List<AllDocumentListdata>?>? alldocumentlistl;
// //  // List<DocumentUploadModel>? documentUploadModelList = [];
// //  // List<DocumentUploadModel>? documentUploadModelList1 = [];
// //   String? usertoken = "";
// //   String user_id = "";
// //
// //   @override
// //   void initState() {
// //     getuserType();
// //     // TODO: implement initState
// //     super.initState();
// //   }
// //
// //   void getuserType() async {
// //     user_id = await sharedPreference.isUsetId();
// //     String? usertype = await sharedPreference.isUserType();
// //
// //     usertoken = await sharedPreference.isToken();
// //     // ignore: prefer_interpolation_to_compose_strings
// //     // print("dixit" + usertype);
// //     // print("dixit id=====" + user_id);
// //     // print("dixit usertoken" + usertoken!);
// //     AllDocument = getdocument();
// //   }
// //
// //   Future<List<AllDocumentListdata?>?> getdocument() async {
// //     print(ApiUrl.getDocumentCategories);
// //     try {
// //       showLoader(context);
// //
// //       final response = await http.post(
// //         Uri.parse(ApiUrl.getDocumentCategories),
// //       );
// //
// //       print("response data my booking =================" + response.body);
// //       Map<String, dynamic> map = json.decode(response.body);
// //
// //       if (response.statusCode == 200) {
// //         hideLoader();
// //
// //         /*  MyBookingModel? myBookingModel = MyBookingModel.fromJson(jsonDecode(response.body));
// //          mybookingdata = myBookingModel.data! ;
// // */
// //         AllDocumentList catrgortModel1 =
// //         AllDocumentList.fromJson(jsonDecode(response.body));
// //         for (int i = 0; i < catrgortModel1.data!.length; i++) {
// //           AllDocumentListdata categoryModelData = AllDocumentListdata(
// //             id: catrgortModel1.data![i].id, catName: catrgortModel1.data![i].catName,
// //             documents: catrgortModel1.data![i].documents,
// //             image: catrgortModel1.data![i].image,
// //           );
// //           Documentlist!.add(categoryModelData);
// //         }
// //         setState(() {});
// //
// //         print("Success");
// //
// //         return Documentlist;
// //       } else {
// //         print("Something went wronge");
// //       }
// //     } catch (e) {
// //       print("data==1=$e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.white,
// //       appBar: APPBar(title: widget.title ?? ""),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           margin: const EdgeInsets.all(10),
// //           child: Column(
// //             children: [
// //           ListView.builder(
// //           itemCount: Documentlist!.length,
// //               scrollDirection: Axis.vertical,
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemBuilder: (BuildContext context, int index) {
// //                 return Container(
// //                   decoration: BoxDecoration(
// //                     border:
// //                     Border.all(width: 1, color: Colors.grey),
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                   margin: const EdgeInsets.symmetric(vertical: 10),
// //                   child: Column(
// //                     children: [
// //                       images[index] == ''
// //                           ? const SizedBox.shrink()
// //                           : images.length > index
// //                           ? Image.file(
// //                         File(images[index]),
// //                         width: 150,
// //                       )
// //                           : const SizedBox.shrink(),
// //                       ListTile(
// //                           leading: // Image.asset(AppImages.DOCUMENTS),
// //                           Image.network(
// //                               Documentlist![index].image,
// //                             fit: BoxFit.cover,
// //                             width: 70,
// //                           ),
// //                           title: boldtext(AppColors.DarkBlue, 14,
// //                               Documentlist![index].catName ?? ""),
// //                           onTap: () {
// //                             print(index);
// //                             alert( Documentlist![index], index);
// //                           },
// //                           subtitle: boldtext(AppColors.redShade4,
// //                               10, "How to make it?"),
// //                           trailing:
// //                           Documentlist![index].id ==
// //                               "0"
// //                               ? const Icon(Icons.more_vert)
// //                               : const Icon(
// //                             Icons.check_circle,
// //                             color: Colors.green,
// //                           )),
// //                     ],
// //                   ),
// //                 );
// //               }),
// //               const SizedBox(
// //                 height: 150,
// //               ),
// //               const SizedBox(
// //                 height: 150,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       bottomSheet: Container(
// //         color: AppColors.white,
// //         width: Get.width,
// //         height: 70,
// //         child: Center(
// //           child: ButtonMain(
// //               ontap: () async {
// //                 if ( Documentlist!.isNotEmpty) {
// //                   await callAddProduct( Documentlist!);
// //                 } else {
// //                   showInSnackBar("Please Select Upload Deocument",
// //                       color: Colors.red);
// //                 }
// //               },
// //               text: 'Submit',
// //               width: 0.7,
// //               loader: isLoading),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   alert(dynamic data, int index) {
// //     showAnimatedDialog(
// //       context: context,
// //       barrierDismissible: true,
// //       builder: (BuildContext context) {
// //         print("index-inside alert--------------------------$index");
// //         return ClassicGeneralDialogWidget(
// //           // titleText: 'Title',
// //           actions: [
// //             SizedBox(
// //               width: MediaQuery.of(context).size.width,
// //               child: Column(
// //                 children: [
// //                   Center(
// //                     child: CircleAvatar(
// //                       radius: 35,
// //                       backgroundColor: Colors.white,
// //                       backgroundImage: AssetImage(AppImages.APP_LOGO),
// //                     ),
// //                   ),
// //                   boldtext(AppColors.black, 14, "${data.name}"),
// //                   vertical(20),
// //                   data.isSubmitted == "0"
// //                       ? ButtonMain(
// //                       ontap: () {
// //                         Navigator.pop(context);
// //                         _showPicker(
// //                             context, index.toString(), data.id.toString(),
// //                             update: false);
// //                       },
// //                       text: 'Upload Photo',
// //                       width: 0.5,
// //                       loader: false)
// //                       : Column(
// //                     children: [
// //                       ButtonMain(
// //                         ontap: () async {
// //                           Navigator.pop(context);
// //                           Map<Permission, PermissionStatus> statuses =
// //                           await [Permission.storage].request();
// //                           if (statuses[Permission.storage]!.isGranted) {
// //                             showLoader(context);
// //                             var dir = await DownloadsPathProvider
// //                                 .downloadsDirectory;
// //                             if (dir != null) {
// //                               String fileNm = data.uploaded_document!
// //                                   .substring(
// //                                   data.uploaded_document!
// //                                       .lastIndexOf("/") +
// //                                       1,
// //                                   data.uploaded_document!.length);
// //                               String savename = fileNm;
// //                               String savePath = dir.path + "/$savename";
// //                               print(savePath);
// //                               var response = await Dio().get(
// //                                   "" + data.uploaded_document!,
// //                                   options: Options(
// //                                       responseType: ResponseType.bytes));
// //                               final result =
// //                               await ImageGallerySaver.saveImage(
// //                                   Uint8List.fromList(response.data),
// //                                   quality: 60,
// //                                   name: "" + fileNm);
// //                               print(result);
// //                               //output:  /storage/emulated/0/Download/banner.png
// //                               try {
// //                                 await Dio().download(
// //                                     data.uploaded_document!, savePath,
// //                                     onReceiveProgress: (received, total) {
// //                                       if (total != -1) {
// //                                         print((received / total * 100)
// //                                             .toStringAsFixed(0) +
// //                                             "%");
// //                                         //you can build progressbar feature too
// //                                       }
// //                                     });
// //                                 hideLoader();
// //                                 showInSnackBar(
// //                                     "File is saved to download folder.");
// //                               } on DioError catch (e) {
// //                                 print(e.message);
// //                                 hideLoader();
// //                               }
// //                             }
// //                           } else {
// //                             print("No permission to read and write.");
// //                             hideLoader();
// //                           }
// //                         },
// //                         text: "text",
// //                         width: 0.7,
// //                         loader: false,
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             boldtext(AppColors.DarkBlue, 12,
// //                                 'Download ${data.name}'),
// //                             horizental(15),
// //                             Image.asset(AppImages.ICON_DOWNLOAD)
// //                           ],
// //                         ),
// //                       ),
// //                       vertical(20),
// //                       ButtonMain(
// //                         ontap: () {
// //                           Navigator.pop(context);
// //                           _showPicker(context, index.toString(),
// //                               data.id.toString(),
// //                               update: true);
// //                           // print(data.id.toString());
// //                         },
// //                         text: "Update Image ",
// //                         width: 0.7,
// //                         loader: false,
// //                       ),
// //                       vertical(20),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           ButtonMain(
// //                             ontap: () {
// //                               Get.back();
// //                               Get.to(() => ViewImage(
// //                                 url: data.uploaded_document,
// //                               ));
// //                             },
// //                             text: "View",
// //                             width: 0.3,
// //                             loader: false,
// //                           ),
// //                           horizental(25),
// //                           ButtonMain(
// //                             ontap: () async {
// //                               Get.back();
// //                               await Share.share(
// //                                   "${data.uploaded_document}");
// //                             },
// //                             text: "Share",
// //                             width: 0.3,
// //                             loader: false,
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                   vertical(25),
// //                   boldtext(AppColors.DarkBlue, 14, "For Assistance"),
// //                   vertical(15),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       IconButton(
// //                           onPressed: () async {
// //                             if (await canLaunch(data.usefullLink)) {
// //                               await launch(data.usefullLink);
// //                             } else {
// //                               throw 'Could not launch ';
// //                             }
// //                           },
// //                           icon: Image.asset(
// //                             AppImages.INTERNET,
// //                             height: 25,
// //                           )),
// //                       IconButton(
// //                           onPressed: () async {
// //                             String phonenumber = "tel:" + data.supportNumber!;
// //                             //url = phonenumber;
// //
// //                             Uri phoneno = Uri.parse('tel:+$phonenumber');
// //                             if (await launchUrl(phoneno)) {
// //                               //dialer opened
// //                             } else {
// //                               //dailer is not opened
// //                             }
// //                           },
// //                           icon: const Icon(
// //                             Icons.call,
// //                             color: Colors.green,
// //                           )),
// //                     ],
// //                   ),
// //                   vertical(20),
// //                   Align(
// //                       alignment: Alignment.centerRight,
// //                       child: ButtonMain(
// //                         ontap: () {
// //                           Get.back();
// //                         },
// //                         text: 'Back',
// //                         width: 0.2,
// //                         loader: false,
// //                         fsize: 12,
// //                         height: 40,
// //                       )),
// //                   vertical(20),
// //                 ],
// //               ),
// //             )
// //           ],
// //         );
// //       },
// //       animationType: DialogTransitionType.slideFromRightFade,
// //       curve: Curves.fastOutSlowIn,
// //       duration: const Duration(milliseconds: 1000),
// //     );
// //   }
// //
// //   void _showPicker(context, String id, String documentId, {bool? update}) {
// //     showModalBottomSheet(
// //         context: context,
// //         builder: (BuildContext bc) {
// //           print("index-----------------------------------  $id");
// //           return SafeArea(
// //             child: Container(
// //               child: Wrap(
// //                 children: <Widget>[
// //                   ListTile(
// //                       leading: const Icon(Icons.photo_library),
// //                       title: const Text('Gallery'),
// //                       onTap: () {
// //                         _imgFromGallery(id, documentId, update: update);
// //                       }),
// //                   ListTile(
// //                     leading: const Icon(Icons.photo_camera),
// //                     title: const Text('Camera'),
// //                     onTap: () {
// //                       _imgFromCamera(id, documentId, update: update);
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         });
// //   }
// //
// //   _imgFromCamera(String id, String documentId, {bool? update}) async {
// //     try {
// //       pickedImage =
// //       await picker.getImage(source: ImageSource.camera, imageQuality: 50);
// //       File image = File(pickedImage!.path);
// //       if (update == true) {
// //         updateimg(image, id);
// //       } else {
// //         setState(() {
// //           _image = image;
// //           id == '0'
// //               ? images[0] = pickedImage!.path
// //               : id == '1'
// //               ? images[1] = pickedImage!.path
// //               : images[2] = pickedImage!.path;
// //           DocumentUploadModel documentUploadModel = DocumentUploadModel(
// //               document_id: documentId,
// //               provider_document: _image,
// //               is_verified: "0");
// //         //  documentUploadModelList!.add(documentUploadModel);
// //         });
// //       }
// //     } catch (e) {
// //       showInSnackBar('No Image Selected', color: Colors.red);
// //     }
// //     Navigator.pop(context);
// //   }
// //
// //   _imgFromGallery(String id, String documentId, {bool? update}) async {
// //     print(id);
// //     try {
// //       print(id);
// //       pickedImage =
// //       await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
// //       File image = File(pickedImage!.path);
// //       print("update status =========" + update.toString());
// //       if (update == true) {
// //         print("update state =======");
// //         await updateimg(image, id);
// //       } else {
// //         setState(() {
// //           _image = image;
// //           id == '0'
// //               ? images[0] = pickedImage!.path
// //               : id == '1'
// //               ? images[1] = pickedImage!.path
// //               : images[2] = pickedImage!.path;
// //           DocumentUploadModel documentUploadModel = DocumentUploadModel(
// //               document_id: documentId,
// //               provider_document: _image,
// //               is_verified: "0");
// //          // documentUploadModelList!.add(documentUploadModel);
// //         });
// //       }
// //     } catch (e) {
// //       showInSnackBar('No Image Selected', color: Colors.red);
// //     }
// //     Navigator.pop(context);
// //   }
// //
// //   updateimg(File image, String id) async {
// //     String url = "http://admin.businessgym.in/api/provider-document-update-new";
// //     try {
// //       showLoader(context);
// //       var request = http.MultipartRequest(
// //         "POST",
// //         Uri.parse(url),
// //       );
// //       request.headers
// //         ..addAll({"Authorization": USERTOKKEN.toString(), "accept": ""});
// //       request.fields["id"] = id;
// //       request.fields["provider_id"] = user_id;
// //       request.files.add(
// //           await http.MultipartFile.fromPath("provider_document", image.path));
// //       final response = await request.send();
// //       final data = await http.Response.fromStream(response);
// //       print("update image check ========" +
// //           data.statusCode.toString() +
// //           data.body);
// //
// //       // .then((value)
// //       //  async {
// //       //   String result = await value.stream.bytesToString();
// //       // print("result  $result");
// //       // showInSnackBar("Updated Successfully");
// //
// //       hideLoader();
// //       Navigator.of(context).pop();
// //       // });
// //     } catch (e) {
// //       print(e.toString());
// //     }
// //   }
// //
// //   Future<d.Response> callAddProduct(
// //       List< AllDocumentListdata>? documentUploadModelListi) async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     print(documentUploadModelListi![0].image!);
// //     print("document id" + documentUploadModelListi[0].id.toString());
// //     String url = ApiUrl.provider_document_save;
// //     try {
// //       d.FormData formData = d.FormData();
// //
// //       if (documentUploadModelListi.length != 0) {
// //         for (int i = 0; i < documentUploadModelListi.length; i++) {
// //           formData.fields.add(MapEntry("document_id[]",
// //               documentUploadModelListi[i].id.toString()));
// //
// //          // String fileNm = documentUploadModelListi[i]
// //              // .provider_document!
// //              // .path
// //             //  .substring(
// //             //  documentUploadModelListi[i]
// //                  // .provider_document!
// //                 //  .path
// //                 //  .lastIndexOf("/") +
// //                 //  1,
// //              // documentUploadModelListi[i].provider_document!.path.length);
// //
// //           //formData.files.add(
// //           //  MapEntry(
// //            //   "provider_document[]",
// //             //  await d.MultipartFile.fromFileSync(
// //               //    documentUploadModelListi[i].provider_document!.path,
// //                //   filename: fileNm),
// //           //  ),
// //        //   );
// //         }
// //       }
// //       formData.fields.add(MapEntry("provider_id", user_id.toString()));
// //       formData.fields.add(MapEntry("is_verified", "1"));
// //       // formData.fields.add(MapEntry('documents', documentUploadModelListi.map((v) => v.toJson()).toList().toString()));
// //       // if(_image != null){
// //       //   String fileNm = _image!.path.substring(
// //       //       _image!.path.lastIndexOf("/") + 1,
// //       //       _image!.path.length);
// //       //   formData.files.add(
// //       //     MapEntry(
// //       //       "gst_copy",
// //       //       d.MultipartFile.fromFileSync(_image!.path, filename: fileNm),
// //       //     ),
// //       //   );
// //       // }
// //       // if(_image1 != null){
// //       //   String fileNm = _image1!.path.substring(
// //       //       _image1!.path.lastIndexOf("/") + 1,
// //       //       _image1!.path.length);
// //       //   formData.files.add(
// //       //     MapEntry(
// //       //       "pan_copy",
// //       //       d.MultipartFile.fromFileSync(_image1!.path, filename: fileNm),
// //       //     ),
// //       //   );
// //       // }
// //
// //       /*request.fields['name'] = mynameController.text.toString();
// //       request.fields['category_id'] = valueChoose!.toString();
// //       request.fields['address'] = myaddressController.text.toString();
// //       request.fields['shop_type'] = valueChooseshoptype.toString();
// //       request.fields['description'] = description;
// //       request.fields['amenities'] = amenities;*/
// //
// //       /* request.fields['gst_no'] = mygatnoController.text.toString();
// //       request.fields['pan_number'] = mypannoController.text.toString();
// //       request.fields['business_name'] = mybusinessnameController.text.toString();*/
// //
// //       /*formData.fields.add(MapEntry('gst_no', mygatnoController.text.toString()));
// //       formData.fields.add(MapEntry('pan_number',  mypannoController.text.toString()));
// //       formData.fields.add(MapEntry('business_name', mybusinessnameController.text.toString()));*/
// //
// //       d.Response response;
// //       print(url);
// //       d.Dio dio = d.Dio();
// //       print(formData);
// //       print(USERTOKKEN);
// //       dio.options.headers
// //           .addAll({"Authorization": USERTOKKEN.toString(), "accept": ""});
// //       response = await dio.post(url, data: formData);
// //       // await http.post(Uri.parse(url),
// //       //     headers: {"Authorization": USERTOKKEN.toString(), "accept": ""},
// //       //     body: formData);
// //       //hideLoader();
// //
// //       print('Response request: ${response.requestOptions}');
// //       print('Response status: ${response.statusCode}');
// //       print('Response body: ${response.data}');
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         if (response.statusCode == 200) {
// //          // documentUploadModelList!.clear();
// //         //  documentUploadModelList1!.clear();
// //           Navigator.of(context).pop();
// //           showInSnackBar('Images Uploaded');
// //
// //           /*}
// //           else{
// //             sharedPreference.setuploadgstIn("true");
// //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BankDetailScreen(widget.s.toString(),false)));
// //           }*/
// //
// //           //   _showToastSuccessfully("Success Fully Added!",Colors.green);
// //           // pd.close();
// //           setState(() {
// //             // Navigator.of(context).pop();
// //             isLoading = false;
// //           });
// //         } else {}
// //       } else if (response.statusCode == 401) {
// //       } else if (response.statusCode == 403) {
// //       } else if (response.statusCode == 422) {
// //       } else {}
// //       return response;
// //     } catch (e) {
// //       print("exception" + e.toString());
// //       // hideLoader();
// //       // pd.close();
// //       return d.Response(requestOptions: RequestOptions(path: url));
// //     }
// //   }
// // }
// // // ignore_for_file: file_names, non_constant_identifier_names
// //
// // class DocumentlistnewModel {
// //   bool? status;
// //   List<DocumentlistnewModelList>? documentlistnewModelList;
// //
// //   DocumentlistnewModel({this.status, this.documentlistnewModelList});
// //
// //   DocumentlistnewModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     if (json['data'] != null) {
// //       documentlistnewModelList = <DocumentlistnewModelList>[];
// //       json['data'].forEach((v) {
// //         documentlistnewModelList!.add(DocumentlistnewModelList.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['status'] = status;
// //     if (documentlistnewModelList != null) {
// //       data['data'] = documentlistnewModelList!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
// //
// // class DocumentlistnewModelList {
// //   int? id;
// //   int? categoryId;
// //   String? name;
// //   String? supportNumber;
// //   String? usefullLink;
// //   int? status;
// //   String? isRequired;
// //   String? deletedAt;
// //   String? createdAt;
// //   String? updatedAt;
// //   String? isSubmitted;
// //   String? isVerified;
// //   String? provider_document;
// //   String? uploaded_document;
// //
// //   DocumentlistnewModelList({
// //     this.id,
// //     this.categoryId,
// //     this.name,
// //     this.supportNumber,
// //     this.usefullLink,
// //     this.status,
// //     this.isRequired,
// //     this.deletedAt,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.isSubmitted,
// //     this.isVerified,
// //     this.provider_document,
// //     this.uploaded_document,
// //   });
// //
// //   DocumentlistnewModelList.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     categoryId = json['category_id'];
// //     name = json['name'];
// //     supportNumber = json['support_number'];
// //     usefullLink = json['usefull_link'];
// //     status = json['status'];
// //     isRequired = json['is_required'];
// //     deletedAt = json['deleted_at'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     isSubmitted = json['is_submitted'];
// //     isVerified = json['is_verified'];
// //     provider_document = json['provider_document'];
// //     uploaded_document = json['uploaded_document'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['id'] = id;
// //     data['category_id'] = categoryId;
// //     data['name'] = name;
// //     data['support_number'] = supportNumber;
// //     data['usefull_link'] = usefullLink;
// //     data['status'] = status;
// //     data['is_required'] = isRequired;
// //     data['deleted_at'] = deletedAt;
// //     data['created_at'] = createdAt;
// //     data['updated_at'] = updatedAt;
// //     data['is_submitted'] = isSubmitted;
// //     data['is_verified'] = isVerified;
// //     data['provider_document'] = provider_document;
// //     data['uploaded_document'] = uploaded_document;
// //     return data;
// //   }
// // }
// //
// //
// //
// //
// // class DownloadsPathProvider {
// //   static const MethodChannel _channel =
// //   const MethodChannel('downloads_path_provider_28');
// //
// //   static Future<Directory?> get downloadsDirectory async {
// //     final String? path = await _channel.invokeMethod('getDownloadsDirectory');
// //     if (path == null) {
// //       return null;
// //     }
// //     return Directory(path);
// //   }
// // }
// //
// //
// //
// //
//
//
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:businessgym/Controller/productController.dart';
// import 'package:businessgym/Controller/profileController.dart';
// import 'package:businessgym/Controller/serviceController.dart';
// import 'package:businessgym/components/decor.dart';
// import 'package:businessgym/components/snackbar.dart';
// import 'package:businessgym/conts/appbar_global.dart';
// import 'package:businessgym/conts/global_values.dart';
// import 'package:businessgym/Controller/workprofileController.dart';
// import 'package:businessgym/model/GetProductSubcategory.dart';
// import 'package:businessgym/model/getSupplierProductCategory.dart';
// import 'package:businessgym/values/assets.dart';
// import 'package:businessgym/values/const_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import '../../../Utils/ApiUrl.dart';
// import '../../../Utils/SharedPreferences.dart';
// import '../../../Utils/common_route.dart';
// import '../../../model/AllServiceModel.dart';
// import '../../../model/CategoryProviderModel.dart';
// import '../../../model/SubCategoryProviderNewModel.dart';
// import '../../../model/viewWork_profileModel.dart';
// import '../../../values/Colors.dart';
//
//
// class FilterScreen extends StatefulWidget {
//   String title;
//   FilterScreen( {super.key, required this.title,});
//   @override
//   FilterScreenState createState() =>
//       FilterScreenState();
// }
//
// class FilterScreenState extends State<FilterScreen> {
//   String Categotyid="0";
//   SharedPreference _sharedPreference = new SharedPreference();
//   Future<List<GetServiceCategorydata>?>? servicecategorylist;
//   Future<List<GetProductCategorydata>?>? productcategorylist;
//   List<GetServiceCategorydata>? servicecategorydata = [];
//   List<GetProductCategorydata>? productcategorydata = [];
//   String UserId = "";
//   String? usertoken = "";
//   String usertype="";
//
//   bool isSelected = false;
//
//   List<String> selectedServices = [];
//
//
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getuserType();
//     setState(() {});
//   }
//
//   void getuserType() async {
//     usertype = await _sharedPreference.isUserType();
//     UserId = await _sharedPreference.isUsetId();
//     usertoken = await _sharedPreference.isToken();
//     servicecategorylist = getservicecategory();
//     productcategorylist = getproductcategory();
//
//     setState(() {});
//   }
//   Future<List<GetProductCategorydata>?>? getproductcategory() async {
//     print(ApiUrl.getsupplierproductlist);
//     try {
//       showLoader(context);
//       final response =await http.get(Uri.parse(ApiUrl.getsupplierproductlist),
//           headers: {"Authorization": USERTOKKEN.toString()} );
//       print(response.body);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         hideLoader();
//         GetProductCategory? allServiceModel =
//         GetProductCategory.fromJson(jsonDecode(response.body));
//         for (int i = 0; i < allServiceModel.data!.length; i++) {
//           GetProductCategorydata categoryModelData =
//           GetProductCategorydata(
//             id: allServiceModel.data![i].id,
//             name: allServiceModel.data![i].name,
//             description: allServiceModel.data![i].description,
//             status: allServiceModel.data![i].status,
//             isProduct: allServiceModel.data![i].isProduct,
//             isService: allServiceModel.data![i].isService,
//             isFeatured: allServiceModel.data![i].isFeatured,
//             deletedAt: allServiceModel.data![i].deletedAt,
//             createdAt: allServiceModel.data![i].createdAt,
//             updatedAt: allServiceModel.data![i].updatedAt,
//             type: allServiceModel.data![i].type,
//             color: allServiceModel.data![i].color,);
//           productcategorydata!.add(categoryModelData);
//         }
//         setState(() {});
//
//         return allServiceModel.data;
//       } else {
//         hideLoader();
//         print("Something went worange");
//       }
//     } catch (e) {
//       print("data===1 error  $e");
//     }
//     return null;
//   }
//   Future<List<GetServiceCategorydata>?> getservicecategory() async {
//     try {
//       showLoader(context);
//       final response = widget.title != "service"
//           ? await http.get(Uri.parse(ApiUrl.getsupplierservicelist),
//           headers: {"Authorization": USERTOKKEN.toString()})
//           : await http.post(Uri.parse(ApiUrl.getsupplierproductlist));
//       if (response.statusCode == 200) {
//         hideLoader();
//         GetServiceCategory? allServiceModel =
//         GetServiceCategory.fromJson(jsonDecode(response.body));
//         for (int i = 0; i < allServiceModel.data!.length; i++) {
//           GetServiceCategorydata categoryModelData =
//           GetServiceCategorydata(
//               id: allServiceModel.data![i].id,
//               name: allServiceModel.data![i].name,
//               description: allServiceModel.data![i].description,
//               color: allServiceModel.data![i].color,
//               status: allServiceModel.data![i].status,
//               isProduct: allServiceModel.data![i].isProduct,
//               isService: allServiceModel.data![i].isService,
//               isFeatured: allServiceModel.data![i].isFeatured,
//               deletedAt: allServiceModel.data![i].deletedAt,
//               createdAt: allServiceModel.data![i].createdAt,
//               updatedAt: allServiceModel.data![i].updatedAt,
//               type: allServiceModel.data![i].type);
//           servicecategorydata!.add(categoryModelData);
//         }
//         setState(() {});
//
//         return allServiceModel.data;
//       } else {
//         hideLoader();
//
//       }
//     } catch (e) {
//
//     }
//     return null;
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.BGColor,
//         appBar: AppBar(
//
//           elevation:  0,
//           automaticallyImplyLeading: false,
//           leading:
//           IconButton(
//             icon: const Icon(
//               Icons.close_rounded,
//               color: Colors.black,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Colors.white,
//           // flexibleSpace: Container(
//           //   decoration: BoxDecoration(gradient: bgGradient),
//           // ),
//           title: boldtext(AppColors.DarkBlue, 16, "Filter"),
//           centerTitle: true,
//           actions: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 regulartext(AppColors.primary, 14, "Reset"),
//                 SizedBox(width: 10,)
//               ],
//             )
//           ],
//         ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 widget.title!="Product"? Container(
//                   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                   child: FutureBuilder<List<GetServiceCategorydata>?>(
//                       future: servicecategorylist,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return Column(
//                             children: [
//                               ListView.builder(
//                                 itemCount:snapshot.data!.length,
//                                   shrinkWrap: true,
//                                   itemBuilder: (context,index){
//                                 return Row(
//                                   children: [
//                                     Checkbox(value: isSelected,   onChanged: (_) {
//                                   if (selectedServices.contains(index)) {
//                                     selectedServices.remove(index);   // unselect
//                                   } else {
//                                     selectedServices.add(snapshot.data![index].toString());  // select
//                                   }
//                                 },),
//                                     Text(
//                                       snapshot.data![index].name ?? '',
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             ],
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text('${snapshot.error}');
//                         }
//                         // By default, show a loading spinner.
//                         return const Center(
//                             child: CircularProgressIndicator(
//                               semanticsLabel: "Please Wait",
//                             ));
//                       }),
//                 ):Container(
//                   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                   child: FutureBuilder<List<GetProductCategorydata>?>(
//                       future: productcategorylist,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return Column(
//                             children: [
//                               ListView.builder(
//                                   itemCount:snapshot.data!.length,
//                                   shrinkWrap: true,
//                                   itemBuilder: (context,index){
//                                     return Row(
//                                       children: [
//                                         Checkbox(value: isSelected,   onChanged: (_) {
//                                           if (selectedServices.contains(index)) {
//                                             selectedServices.remove(index);   // unselect
//                                           } else {
//                                             selectedServices.add(snapshot.data![index].toString());  // select
//                                           }
//                                         },),
//                                         Text(
//                                           snapshot.data![index].name ?? '',
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//                                       ],
//                                     );
//                                   }),
//                             ],
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text('${snapshot.error}');
//                         }
//                         // By default, show a loading spinner.
//                         return const Center(
//                             child: CircularProgressIndicator(
//                               semanticsLabel: "Please Wait",
//                             ));
//                       }),
//                 ),
//
//
//
//
//                 const SizedBox(
//                   height: 100,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar:
//       GestureDetector(
//
//
//         onTap: () {
//
//         },
//         child: Container(
//          // margin: const EdgeInsets.all(20),
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(12)),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                   child: boldtext(AppColors.primary,20,
//                     "Apply",
//
//                   )),
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
// }
//
//
//
//
//
//
//
//
