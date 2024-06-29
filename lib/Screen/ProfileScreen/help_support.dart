// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_final_fields, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/SubjectListModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../../Utils/ApiUrl.dart';
import '../../../Utils/common_route.dart';
import '../../../values/Colors.dart';

class Help_supportScreen extends StatefulWidget {
  @override
  Help_supportScreenState createState() => Help_supportScreenState();
}

class Help_supportScreenState extends State<Help_supportScreen> {
  TextEditingController description = TextEditingController();
  Future<SubjectModel?>? alldocumentlistl;
  int? number;
  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();
  Future<List<SubjectModeldata>?>? listData1;
  List<SubjectModeldata>? categorydata = [];
  String? subjectId ;
  SubjectModeldata? subjectvalue;
  File? _image;
  PickedFile? pickedImage;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    usetId();
    super.initState();
  }

  Future<void> usetId() async {
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    listData1 = getcategotyData(UserId!);
  }

  Future<List<SubjectModeldata>?> getcategotyData(String userid) async {
    print("GET DATA OF SUBJECT LIST ");
    try {
      var headers = {'Authorization': USERTOKKEN!};
      showLoader(context);
      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.getSupportSubject),
        headers: headers,
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);
      print("AshishBody:==========" + response.body);
      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        SubjectModel catrgortModel =
            SubjectModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < catrgortModel.data!.length; i++) {
          SubjectModeldata categoryModelData = SubjectModeldata(
              id: catrgortModel.data![i].id,
              subjectTital: catrgortModel.data![i].subjectTital,
              userType: catrgortModel.data![i].userType,
              deletedAt: catrgortModel.data![i].deletedAt,
              createdAt: catrgortModel.data![i].createdAt,
              updatedAt: catrgortModel.data![i].updatedAt);
          categorydata!.add(categoryModelData);
        }
        setState(() {});

        // mycategory = categorydata[0].subjectTital
        // categorydata = catrgortModel.data;

        return categorydata;
        print("AshishBody:==========" + response.body);
      }
      print(response.statusCode);
    } catch (e) {
      print("sdfok" + e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Help & support"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: boldtext(
                    AppColors.black,
                    16,
                    "How can we help?",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 17, right: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: FutureBuilder<List<SubjectModeldata>?>(
                        future: listData1,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            return DropdownButtonFormField<SubjectModeldata?>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              isExpanded: true,
                              hint: boldtext(AppColors.hint,14,"Select Subject"),
                              items: snapshot.data!.map((countries) {
                                return DropdownMenuItem<SubjectModeldata?>(
                                  value: countries,
                                  child: Row(
                                    children: [
                                      Text(countries.subjectTital!),
                                      const Spacer(),
                                      /*Text("" + countries.balance!)*/
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  subjectId = val!.id.toString();
                                });
                                print("AshishValue===========$subjectId");

                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const Center(
                              child: CircularProgressIndicator(
                            semanticsLabel: "Please Wait",
                          ));
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: textAreamo(
                    description,
                    'Description',
                  ),
                ),
                GestureDetector(
                  child: Container(
                      margin:
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: AppColors.white, width: 1)),
                            child: _image != null
                                ? ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12)),
                              child: Image.file(
                                _image!,
                                height: 70,
                                fit: BoxFit.fill,
                              ),
                            )
                                : SvgPicture.asset(
                              AppImages.gellary,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(17),
                                  ),
                                  border: Border.all(color: AppColors.primary)),
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.upload),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  regulartext(
                                      AppColors.black, 12, "Upload picture")
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
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
                        if(subjectId==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please Enter Subject!"),
                          ));
                        }else if(description.text.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Please Enter Description!"),
    ));
    }else if(_image==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please Upload Picture!"),
                          ));
                        }else{
                          sendhelpsupport(
                              subjectId??"", description.text, UserId.toString());
                        }

                      },
                      child: regulartext(AppColors.white, 14, "Submit"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // line53Z5 (247:17887)
                        margin: EdgeInsets.fromLTRB(0, 3, 9, 0),
                        width: 75,
                        height: 1,
                        decoration: BoxDecoration(
                          color: Color(0xffa6a6a6),
                        ),
                      ),
                      regulartext(Colors.black, 14, "OR"),
                      Container(
                        // line53Z5 (247:17887)
                        margin: EdgeInsets.fromLTRB(5, 3, 9, 0),
                        width: 75,
                        height: 1,
                        decoration: BoxDecoration(
                          color: Color(0xffa6a6a6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color(0xffF1FAFF),
                      ),
                      onPressed: () async {
                        final data = Uri(
                            scheme:
                            'tel',
                            path:
                            '+91${"+9107947813177".substring(3, 13)}');
                        launchUrl(
                            data);
                      },
                      icon: SvgPicture.asset(AppImages.call),
                      label: regulartext(
                        AppColors.primary,
                        14,
                        "Call Us",
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  sendhelpsupport(String subjectid, String description, String userid) async {
    String url = "https://clone.businessgym.in/api/add-support-request";
    showLoader(context);
    print(url);
    print(userid);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = USERTOKKEN!;
      request.fields["user_id"] = userid;
      request.fields["booking_id"] = subjectid;
      request.fields["description"] = description;
      request.fields["subject"] = subjectid.toString();
      request.files.add(await http.MultipartFile.fromPath(
         'image',
          (_image!.path)));
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        hideLoader();
        await Methods1.orderSuccessAlert(context, 'Help Support Message Send Successfully');
        hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      hideLoader();

      // hideLoader();
    }
  }

  void _showPicker(context) {
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
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    pickedImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }
}

Widget textAreamo(TextEditingController controller, String hint,
    {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: TextField(
          minLines: hint.contains("Description") ? 5 : 1,
          maxLines: hint.contains("Description") ? 5 : 1,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.white, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: AppColors.textfieldcolor,
              hintText: hint),
        ),
      ),
    ],
  );
}
