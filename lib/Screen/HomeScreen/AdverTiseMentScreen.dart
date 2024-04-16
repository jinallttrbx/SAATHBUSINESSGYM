// ignore_for_file: file_names, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/ViewAdvertismentDetailModel.dart';
import 'package:businessgym/model/ViewAdvertismentModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';



class AdverTiseMentScreen extends StatefulWidget {
  String advertismentid;
  String title;
   AdverTiseMentScreen(this.advertismentid,this.title,{super.key});

  @override
  AdverTiseMentScreenState createState() => AdverTiseMentScreenState();
}

class AdverTiseMentScreenState extends State<AdverTiseMentScreen> {
  Future<List<ViewAdvertismentdetailModeldata?>?>? alltransactionmodel;
  List<ViewAdvertismentdetailModeldata?>? transactionData = [];
  String? UserId;
  final SharedPreference _sharedPreference = SharedPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid();
    setState(() {});
  }

  Future<void> userid() async {
    UserId = await _sharedPreference.isUsetId();
    alltransactionmodel = advertisement();
  }

  Future<List<ViewAdvertismentdetailModeldata?>?>? advertisement() async {
    try {
      showLoader(context);
      Map<String, String> requestBody = <String, String>{};

      final response = await http.post(
        Uri.parse(ApiUrl.viewAdvertismentdetail+widget.advertismentid),
        //body: requestBody,
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();

        ViewAdvertismentdetailModel? myBookingModel =
        ViewAdvertismentdetailModel.fromJson(jsonDecode(response.body));
        transactionData = myBookingModel.data!;
        setState(() {});

        return myBookingModel.data;
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title:  Text(
          widget.title.toString(),
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "reguler",
            fontSize: 21,
          ),
        ),
      ),
      backgroundColor:  AppColors.BGColor,
      body: Container(

        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              transactionData!.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        // Image.asset("assets/images/nodatafound.gif"),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Data Not Found"),
                      ],
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionData!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            String url = "${transactionData![index]!.urlLink}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15))),


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  height: 120,
                                  width: width - 70,
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.black,
                                          width: 1),
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  child: Image.network(
                                    '${transactionData![index]!.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        70,
                                    height: 30,
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: boldtext(AppColors.primary,20,
                                      "${transactionData![index]!.title}",

                                    )),
                                Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        70,
                                    height: 110,
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: regulartext(AppColors.black,16,
                                      "${transactionData![index]!.description}",

                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Text(
                                        "${transactionData![index]!.createTime}",
                                        style: const TextStyle(
                                            fontFamily: "reguler",
                                            fontSize: 15))),
                              GestureDetector(
                                onTap: (){
                                  openUrl(transactionData![index]!.urlLink);
                                  print(transactionData![index]!.urlLink);

                                },
                                child:   Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: boldtext(AppColors.primary,16,
                                        "${transactionData![index]!.urlLink}",
                                       )),
                              ),
                                SizedBox(height: 20,)

                              ],
                            ),
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) { // <--
      throw Exception('Could not launch $_url');

    }
    Navigator.pop(context);
  }
}
