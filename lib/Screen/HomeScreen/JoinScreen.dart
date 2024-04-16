// ignore_for_file: file_names, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';

import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import '../../../../Utils/ApiUrl.dart';
import '../../../../Utils/SharedPreferences.dart';
import '../../../../Utils/common_route.dart';
import '../../../../model/GetGroupsModel.dart';
import '../../../../values/Colors.dart';
import '../../../../values/const_text.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  JoinScreenState createState() => JoinScreenState();
}

class JoinScreenState extends State<JoinScreen> {
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
  int? pendingvideo = 0;
  int? selectedIndex;
  final SharedPreference _sharedPreference = SharedPreference();
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
    getAllservice(UserId);
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
            Padding(padding: EdgeInsets.only(left: 18),child:  Text("${getGroupsModeldata!.length} Explore groups",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "OpenSans",color: Color(0xff656565)),),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),color: AppColors.white
              ),
              child:ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getGroupsModeldata!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          margin: const EdgeInsets.all(10),

                          child: Material(

                            color: const Color(0xFFffffff),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      selectedIndex = index;
                                      setState(() {});
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 150,
                                            margin:
                                            const EdgeInsets.only(left: 15),
                                            child: regulartext(
                                              AppColors.black,
                                              13,
                                              getGroupsModeldata![index]
                                                  .groupTitle!,
                                            )),
                                        selectedIndex == index
                                            ? Container(
                                            width: 150,
                                            margin: const EdgeInsets.only(
                                                left: 15, top: 7),

                                            child: regulartext(
                                              AppColors.grey,
                                              11,
                                              getGroupsModeldata![index]
                                                  .groupDescription ==
                                                  ""
                                                  ? "Description : N/A"
                                                  : getGroupsModeldata![index]
                                                  .groupDescription!,
                                            ))
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (getGroupsModeldata![index].status ==
                                          "") {
                                        getaddGroupRequest(
                                            UserId,
                                            getGroupsModeldata![index]
                                                .id
                                                .toString());
                                      }
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: getGroupsModeldata![index].status!="Pending"?Color(0xffF1FAFF):Colors.white,
                                          borderRadius: BorderRadius.circular(6)),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          getGroupsModeldata![index]
                                              .status=="Pending"? SvgPicture.asset(AppImages.right):SizedBox.shrink(),
                                          SizedBox(width: 5,),
                                          regulartext(
                                              AppColors.primary,
                                            12,
                                            getGroupsModeldata![index].status==""?"Request":getGroupsModeldata![index]
                                                 .status=="Pending"?"Requested":getGroupsModeldata![index].status!

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
          .post(Uri.parse(ApiUrl.getGroups), body: {"user_id": user_id});

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (response.statusCode == 200) {
        hideLoader();
        GetGroupsModel? allServiceModel =
            GetGroupsModel.fromJson(jsonDecode(response.body));
        getGroupsModeldata = allServiceModel.data;
        setState(() {});

        return allServiceModel;
      } else {
        hideLoader();
      }
    } catch (e) {
      hideLoader();
    }
  }

  Future<GetGroupsModel?> getaddGroupRequest(
      String user_id, String group_id) async {
    try {
      showLoader(context);
      final response = await http.post(Uri.parse(ApiUrl.addGroupRequest),
          body: {"user_id": user_id, "group_id": group_id});

      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        GetGroupsModel? allServiceModel =
            GetGroupsModel.fromJson(jsonDecode(response.body));
        getGroupsModeldata = allServiceModel.data;
        getAllservice(UserId);
        setState(() {});

        return allServiceModel;
      } else {
        hideLoader();
      }
    } catch (e) {
      hideLoader();
    }
  }
}
