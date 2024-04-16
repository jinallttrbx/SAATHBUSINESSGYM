// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_final_fields, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';


import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/olddocument/personal.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/ApiUrl.dart';
import '../../../Utils/common_route.dart';
import '../../../model/AllDocumentList.dart';

import '../../../values/Colors.dart';


class MyEntitlementsScreen extends StatefulWidget {
  @override
  MyEntitlementsScreenState createState() => MyEntitlementsScreenState();
}

class MyEntitlementsScreenState extends State<MyEntitlementsScreen> {
  Future<List<AllDocumentListdata?>?>? AllDocument;
  List<AllDocumentListdata>? Documentlist = [];
  File? _image;
  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();
  String _status = '';

  @override
  void initState() {
    usetId();
    super.initState();
  }

  _displayDialog(BuildContext context, Document subMenu) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: EdgeInsets.only(left: 10,right: 10),
            iconPadding:EdgeInsets.zero,
            content:Container(
              height: 245,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:   Icon(Icons.close_rounded),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child:  Image.network(subMenu.documentImage,fit: BoxFit.fill,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      boldtext(AppColors.black,18,subMenu.name),
                    ],
                  ),
                  SizedBox(height: 40,),
                  regulartext(Color(0xffA6A6A6),14,"Need Help?",),
                  SizedBox(height: 15,),
                  Container(

                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child:    GestureDetector(
                              onTap: (){
                                final data = Uri(
                                    scheme: 'tel', path: '${subMenu.supportNumber!}');
                                launchUrl(data);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.all(Radius.circular(17))
                                ),
                                height: 40,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.userhelp),
                                    SizedBox(width: 10,),
                                    regulartext(Color(0xff656565),12,"Call Assistant",
                                    )
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(width: 10,),
                        Expanded(flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                openUrl(subMenu.usefullLink);
                                print(subMenu.usefullLink);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.all(Radius.circular(17))
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.nav),
                                    SizedBox(width: 10,),
                                    regulartext(Color(0xff656565),12,"Visit Website",
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),

                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () async {
                            _showPicker(context,subMenu.id.toString());

                          },
                          icon: SvgPicture.asset(AppImages.upload,color:Colors.white),
                          label:   regulartext(Colors.white,12,"Upload Photo",
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _viewdialog(BuildContext context, Document subMenu) async {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: EdgeInsets.only(left: 10,right: 10),
            iconPadding:EdgeInsets.zero,
            content: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child:  Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(subMenu.image),
                        SizedBox(width: 10,),
                        boldtext(Colors.black,14,subMenu.name),
                      ],
                    ),
                    SizedBox(height: 40,),

                    Container(
                      child: Row(
                        children: [
                          Expanded(flex: 1,
                            child:    GestureDetector(
                              onTap: (){
                                Get.to(() => ViewImage(
                                  url:subMenu.providerDocument,
                                ));

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 40,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.view),
                                    SizedBox(width: 5,),
                                    regulartext(AppColors.black,12,"view",)
                                  ],
                                ),
                              ),
                            )),
                          SizedBox(width: 5,),
                          Expanded(flex: 1,
                              child: GestureDetector(
                                onTap:
                                    () async {
                                      showLoader(context);
                                      FileDownloader.downloadFile(
                                          url: subMenu.providerDocument,
                                          onDownloadCompleted: (String path) async {

                                            Navigator.of(context).pop();
                                            await Methods1.orderSuccessAlert(context, "${subMenu.name} download successfully");
                                            hideLoader();
                                          },
                                          onDownloadError: (String error) async{
                                            Navigator.of(context).pop();
                                            await Methods1.orderSuccessAlert(context, "Fail ${subMenu.name} Download ");
                                            hideLoader();
                                          });
                                },

                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.download,color: AppColors.primary,),
                                      SizedBox(width: 5,),
                                      regulartext(AppColors.black,12,"Download",)
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(width: 5,),
                          Expanded(flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  final response = await get(Uri.parse(subMenu.providerDocument));
                                  final directory = await getTemporaryDirectory();
                                  File file = await File('${directory.path}/Image.png')
                                      .writeAsBytes(response.bodyBytes);

                                  await Share.shareXFiles([XFile(file.path)], text: "${subMenu.name}");
                                  },

                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.share),
                                      SizedBox(width: 5,),
                                      regulartext(AppColors.black,12,"Share",)
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),

                              ),
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () async {
                              _showPicker(context,subMenu.id.toString());
                            },
                            child:   regulartext(AppColors.white,12,"Update",)
                        ),
                      ),
                    ),
                  ],
                ),
            ),

          );
        });
  }
  Future<void> usetId() async {
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    AllDocument = getdocument();
  }

  Future<List<AllDocumentListdata?>?> getdocument() async {
    print(ApiUrl.getDocumentCategories);
    try {
      showLoader(context);

      final response = await http.post(
        Uri.parse(ApiUrl.getDocumentCategories),
        headers: {"Authorization": "$USERTOKKEN"},
      );

      print("response data my booking =================" + response.body);
      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();


        AllDocumentList catrgortModel1 =
        AllDocumentList.fromJson(jsonDecode(response.body));
        for (int i = 0; i < catrgortModel1.data!.length; i++) {
          AllDocumentListdata categoryModelData = AllDocumentListdata(
            id: catrgortModel1.data![i].id, catName: catrgortModel1.data![i].catName,
            documents: catrgortModel1.data![i].documents,
            image: catrgortModel1.data![i].image,
            );
          Documentlist!.add(categoryModelData);
        }
        setState(() {});

        print("Success");

        return Documentlist;
      } else {
        print("Something went wronge");
      }
    } catch (e) {
      print("data==1=$e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Documents"),
      body: ListView.builder(
          itemCount: Documentlist!.length,
          itemBuilder: (BuildContext context, int index) =>
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 02),
                  decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child:  GestureDetector(
                    child: _buildListservice(Documentlist![index]),
                  )
              )
      ),
    );
  }

  Widget _buildListservice(AllDocumentListdata list) {
    if (list.documents.isNotEmpty)
      return ExpansionTile(


        // leading: Icon(list.icon),
        title: Row(
          children: [
            boldtext(Colors.black,16,
              list.catName,
            ),

          ],
        ),
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.documents.length,
              itemBuilder: (context,position){
                return GestureDetector(
                  onTap: (){
                    list.documents[position].ifUpload!="yes"?  _displayDialog(context,list.documents[position]):
                    _viewdialog(context,list.documents[position]);

                  },

                  child: Container(

                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.BGColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            height: 50,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height:30,
                                  width: 50,
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    child:  Image.network(list.documents[position].documentImage,fit: BoxFit.fill,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(flex: 1,
                                  child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    regulartext(AppColors.hint,12,list.documents[position].name),
                                    //list.subCategory[position].subCategoriesName!=null? boldtext(AppColors.black,14,list.subCategory[position].subCategoriesName!):boldtext(AppColors.black,14,list.subCategory[position].supplierSubCategoriesName!),
                                  ],
                                ),),
                                list.documents[position].ifUpload=="yes"?GestureDetector(
                                  onTap: (){
                                  },
                                  child: SvgPicture.asset(AppImages.verify),
                                ):SizedBox.shrink(),
                                SizedBox(width: 10,),


                              ],
                            ),
                          )


                        ],
                      )
                  ),
                );
              })
        ],
      );
    return SizedBox.shrink();
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) { // <--
      throw Exception('Could not launch $_url');

    }
    Navigator.pop(context);
  }

  void _showPicker(context,String id ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery(id);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera(id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  final ImagePicker picker = ImagePicker();
  _imgFromCamera(String id) async {
    final pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
    uploaddocument(id);
    Navigator.of(context).pop();


  }

  _imgFromGallery(String id) async {
    final pickedImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
    print(_image);
    uploaddocument(id);
    Navigator.of(context).pop();
  }





  uploaddocument(String id) async {
    showLoader(context);
    print(id);
    final userId = await _sharedPreference.isUsetId();
    final userToken = await _sharedPreference.isToken();
    var uri = Uri.parse(ApiUrl.provider_document_save);
    final request = http.MultipartRequest("POST", uri);
    request.headers
        .addAll({"Authorization": userToken, "Accept": "application/json"});
    request.fields["id"]=id;
    request.fields['is_verified'] = "1";
    request.fields['user_id'] = userId;
    request.fields['document_id'] = id;
    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('provider_document', _image!.path),
      );
    }
    final response = await request.send();

    if (response.statusCode == 200) {
      hideLoader();
      print(response.statusCode);
      print("UPDATE PROFILE RESPONSE OF API ${request.fields}");
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update Successfully'),
        ),
      );
      Navigator.of(context).pop();
    } else {
      hideLoader();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fail to update'),
        ),
      );
      Navigator.of(context).pop();
    }
  }


}


class ViewImage extends StatefulWidget {
  String url;
  ViewImage({super.key, required this.url});

  @override
  State<ViewImage> createState() => _ViewImageState();
}


class _ViewImageState extends State<ViewImage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APPBar(title: 'View Image'),
      backgroundColor: AppColors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.network(
            widget.url,
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}











