// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_final_fields, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';


import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/SubjectListModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../Utils/ApiUrl.dart';
import '../../../Utils/common_route.dart';
import '../../../model/AllDocumentList.dart';

import '../../../values/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController description=TextEditingController();
  Future<SubjectModel?>? alldocumentlistl;
  int? number;
  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();
  Future<List<SubjectModeldata>?>? listData1;
  List<SubjectModeldata>? categorydata = [];




  @override
  void initState() {
    usetId();
    super.initState();
  }


  Future<void> usetId() async {
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Feedback"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.only(left: 16,right: 16,bottom: 10),child:  boldtext(AppColors.black,16,"Write your thought here",),),
                Padding(padding: EdgeInsets.all(16),child:   textAreamo(
                  description,
                  'Description',
                ),),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 26),
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
                        if(description.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please Enter Discription!"),
                          ));
                        }else {
                          sendfeedback(
                              description.text);
                        }

                      },

                      child: regulartext(AppColors.white,14,"Submit"),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        // line53Z5 (247:17887)
                        margin:  EdgeInsets.fromLTRB(0, 3, 9, 0),
                        width:  75,
                        height:  1,
                        decoration:  BoxDecoration (
                          color:  Color(0xffa6a6a6),
                        ),
                      ),
                      regulartext(Colors.black,14,"OR"),
                      Container(
                        // line53Z5 (247:17887)
                        margin:  EdgeInsets.fromLTRB(5, 3, 9, 0),
                        width:  75,
                        height:  1,
                        decoration:  BoxDecoration (
                          color:  Color(0xffa6a6a6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 26),
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
                      label: regulartext(AppColors.primary,14,"Call Us",
                      ),
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  sendfeedback( String description,) async {
    String url = ApiUrl.addfeedback;
    showLoader(context);
    print(url);

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = USERTOKKEN!;
      request.fields["description"] = description;
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        hideLoader();
        await Methods1.orderSuccessAlert(context, 'Feedback Send Successfully');
        hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      hideLoader();

      // hideLoader();
    }
  }
}
Widget textAreamo(TextEditingController controller, String hint, {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: TextField(
          minLines: hint.contains("Description")?5:1,
          maxLines: hint.contains("Description")?5:1,
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
                borderSide:
                const BorderSide(color: Colors.white, width: 0.25),
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











