import 'dart:convert';


import 'package:businessgym/Screen/HomeScreen/MyGroupScreen.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/GetGroupsModel.dart';
import '../../values/Colors.dart';


class MyGroupNewScreen extends StatefulWidget {
  @override
  MyGroupNewScreenState createState() => MyGroupNewScreenState();
}

class MyGroupNewScreenState extends State<MyGroupNewScreen> {
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  int? pendingvideo = 0;
  SharedPreference _sharedPreference = new SharedPreference();
  List<GetGroupsModelData>? getGroupsModeldata = [];

  @override
  void initState() {
    super.initState();
    getuserType();
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId);
    print("Ashish tiken${usertoken}");
    getAllservice("" + UserId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Padding(padding: EdgeInsets.only(left: 18),child:  Text("${getGroupsModeldata!.length} groups",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "OpenSans",color: Color(0xff656565)),),
            ),
           Container(
             margin: EdgeInsets.only(left: 10,right: 10,top: 20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(16)),color: AppColors.white
             ),
             child:  ListView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: getGroupsModeldata!.length,
                 itemBuilder: (BuildContext context, int index) {
                   return InkWell(
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => MyGroupScreen(
                                   getGroupsModeldata![index].Groupid.toString(),
                                   getGroupsModeldata![index].groupTitle,getGroupsModeldata!.length)));
                     },
                     child: Container(
                       padding: EdgeInsets.only(left: 16,top: 20,right: 16,bottom: 20),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Text(getGroupsModeldata![index].groupTitle!),
                              Expanded(child: SizedBox()),
                               SvgPicture.asset(AppImages.altarroe),

                             ],
                           ),
                           SizedBox(height: 10,),
                           Divider(height: 1,thickness: 1,)
                         ],
                       ),
                     )
                   );
                 }),
           )
          ],
        ),
      ),

    ));
  }

  Future<GetGroupsModel?> getAllservice(String user_id) async {
    try {
      showLoader(context);
      final response = await http
          .post(Uri.parse(ApiUrl.getMyGroups), body: {"user_id": user_id});
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        print("Success");

        print("Success" + response.body.toString());
        GetGroupsModel? allServiceModel =
            GetGroupsModel.fromJson(jsonDecode(response.body));

        getGroupsModeldata = allServiceModel.data;
        hideLoader();
        setState(() {

        });
        return allServiceModel;
      } else {
        hideLoader();
        print("Something went worange");
      }
    } catch (e) {
      hideLoader();
      print("data===$e");
    }
  }
}
