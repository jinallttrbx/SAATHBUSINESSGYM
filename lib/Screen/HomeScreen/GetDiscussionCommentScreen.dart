// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, body_might_complete_normally_nullable

import 'dart:convert';

import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/GetDiscussionsModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/GetDiscussionCommentModel.dart';
import '../../values/Colors.dart';

class GetDiscussionCommentScreen extends StatefulWidget {
  String? discussion_id;
  GetDiscussionsModelData data;

  GetDiscussionCommentScreen({Key? key, this.discussion_id, required this.data})
      : super(key: key);

  @override
  State<GetDiscussionCommentScreen> createState() =>
      _GetDiscussionCommentScreenState();
}

class _GetDiscussionCommentScreenState
    extends State<GetDiscussionCommentScreen> {
  GetDiscussionCommentModelData? data = GetDiscussionCommentModelData();
  List<Comments>? comments = [];
  bool isLoading = false;
  final userprofile = Get.find<UserProfileController>();
  String UserId = "";
  String categotyid = "";
  String? usertoken = "";
  String? usertype = "";
  final typecontroller = TextEditingController();
  final SharedPreference _sharedPreference = SharedPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
  }

  void getuserType() async {
    userprofile.viewprofile();
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    //listData1=getcategotyData();
    getcategotyData(widget.discussion_id!, widget.data.groupId.toString(),
        typecontroller.text, widget.discussion_id.toString());
  }

  Future<List<Comments>?> getcategotyData(String discussion_id, String groupid,
      String type, String discussionid) async {
    print(ApiUrl.getDiscussionComment);
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);
      print("new id ======" + discussion_id);
      Map<String, String> requestBody = <String, String>{
        'discussion_id': discussion_id,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.getDiscussionComment),
        body: requestBody,
      );

      Map<String, dynamic> map = json.decode(response.body);

      // Map<String, dynamic> map = json.decode(response.body);
      print("comment");
      print(map);
      print("comment");
      print(response.statusCode);
      if (response.statusCode == 200) {
        hideLoader();
        GetDiscussionCommentModel catrgortModel =
            GetDiscussionCommentModel.fromJson(jsonDecode(response.body));
        data = catrgortModel.data;
        comments = catrgortModel.comments;
        print(comments);

        setState(() {});



        return comments;
      } else {
        hideLoader();
      }
    } catch (e) {
      hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BGColor,
        appBar: APPBar(title: "Discussion Comment"),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.data.profileImage),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.displayName),
                      regulartext(AppColors.black, 14,
                          "${widget.data.time}"),
                    ],
                  )
                ],
              ),
              Text(widget.data.description),
              Wrap(
                children: [
                  ...widget.data.tags?.map(
                        (e) => Chip(
                          label: new Text(e,
                              style: new TextStyle(
                                  fontSize: 10.0, color: Colors.blueGrey)),
                        ),
                      ) ??
                      []
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: comments!.isEmpty
                    ?  Container(
                  child: Center(child: Text("No Comment Yet ")),
                )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: Image.network(
                                          comments![index].profileImage ?? '',
                                        ).image,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        comments![index].username ?? '',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    comments![index].text ?? '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ));
                        }),
              ),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              controller: typecontroller,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  hintText: "Type here",
                                  hintStyle: TextStyle(
                                    color: AppColors.black.withOpacity(0.5),
                                    fontSize: 14,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (typecontroller.text.isEmpty) {
                                        // showInSnackBar(
                                        //     "Please Add Text In Comment",
                                        //     color: AppColors.red);
                                      } else {
                                        addComment();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: SvgPicture.asset(AppImages.send),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )),

                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  addComment() async {
    showGetLoader();
    try {
      print(USERTOKKEN);
      print("PRINT USERID ${widget.data!.userId.toString()}");
      print("PRINT GROUPID ${widget.data!.groupId.toString()}");
      print("PRINT DISCUSSION ID  ${widget.discussion_id.toString()}");
      final response = await http.post(
        Uri.parse(ApiUrl.addDiscussionComment),
        headers: {
          'Authorization': '$USERTOKKEN',
        },
        body: {
          'user_id': UserId.toString(),
          'group_id': widget.data!.groupId.toString(),
          'discussion_id': widget.discussion_id.toString(),
          'text': typecontroller.text
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // showInSnackBar("Commented successfuly");
      }
      hideLoader();
      setState(() {
        typecontroller.clear();
        //addcomment = false;
      });
      getcategotyData(widget.discussion_id!, widget.data.groupId.toString(),
          typecontroller.text, widget.discussion_id.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
