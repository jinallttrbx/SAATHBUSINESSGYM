import 'dart:convert';

import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/ViewNewsModel.dart';
import '../../values/Colors.dart';
import 'NewsDetailsScreen.dart';

class NewsScreen extends StatefulWidget{
  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen>{

  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();
  String? usertoken = "";
  String? usertype = "";
 // Future<List<ViewNewsModelData?>?>? viewnewsmodel;
  List<ViewNewsModelData?>? viewnewsmodelData =[];

  @override
  void initState() {
    getuserType();
    super.initState();


  }
  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId!);
    print("Ashish tiken$usertoken");
    //listData1=getcategotyData();
    News();
  }


  Future<List<ViewNewsModelData?>?>? News() async {
    try {
print(ApiUrl.viewNews);
      showLoader(context);



      final response = await http.post(
        Uri.parse(ApiUrl.viewNews),

      );

      print("response data my news ================="+response.body);
      //  Map<String, dynamic> map = json.decode(response.body);



      if (response.statusCode == 200) {

        hideLoader();


        ViewNewsModel? viewNewsModel = ViewNewsModel.fromJson(jsonDecode(response.body));
        viewnewsmodelData = viewNewsModel.data!;
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



  @override
  Widget build(BuildContext context) {
  return Column(
     children: [
    ListView.builder(
    shrinkWrap: true,
    controller: ScrollController(),
    itemCount: viewnewsmodelData!.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: ()
        {
          Get.to(NewsDetailsScreen(videos: viewnewsmodelData![index],));
        },
        child: Container(
            padding: EdgeInsets.only(
                left: 16, right: 16, bottom: 10, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                                Radius.circular(12))),
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            viewnewsmodelData![index]!.image!,
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
//length>15?'${ list_circular[index].title.substring(0,14)}...' :list_circular[index].title,
                            Text(
                              viewnewsmodelData![index]!.title!,
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              viewnewsmodelData![index]!.createTime!,
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffA6A6A6)),
                            ),
                            Text(viewnewsmodelData![index]!
                                .urlLink!
                                .length >
                                100
                                ? viewnewsmodelData![index]!
                                .urlLink!
                                .substring(0, 99)
                                : viewnewsmodelData![index]!
                                .urlLink!),
                          ],
                        ))
                  ],
                ),
                Divider(thickness: 1,color: AppColors.hint.withOpacity(0.5),)
              ],
            )),
      );
    },
  )
     ],
   );
  }

}