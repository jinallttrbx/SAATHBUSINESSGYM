import 'dart:convert';

import 'package:businessgym/Screen/HomeScreen/GetDiscussionCommentScreen.dart';
import 'package:businessgym/Screen/HomeScreen/addDiscussionScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/model/GetDiscussionsModel.dart';
import 'package:businessgym/olddocument/document.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';





class MyGroupScreen extends StatefulWidget {

  String? group_id;
  String? group_name;
  int? grupdata;
  MyGroupScreen(this.group_id, this.group_name,this.grupdata);

  @override
  MyGroupScreenState createState() => MyGroupScreenState();
}

class MyGroupScreenState extends State<MyGroupScreen> {
  String UserId = "";
  String? usertoken = "";
  String? usertype = "";
 // List<DiscussionMenu> discussiondata = [];
  SharedPreference _sharedPreference = new SharedPreference();

  List<GetDiscussionsModelData>? getDiscussionsModeldata = [];

  @override
  void initState() {
    super.initState();
   // DiscussionList.forEach((element) {
      //discussiondata.add(DiscussionMenu.fromJson(element));
   // });
    getuserType();
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    print("Ashish" + UserId);
    print("Ashish tiken${usertoken}");
    getAllservice("" + widget.group_id!);
  }

  Future<GetDiscussionsModel?> getAllservice(String group_id) async {
    /*data=[];
    featuredVideos=[];
    resentVideos=[];*/
    try {
      //showLoader(context);
      final response = await http
          .post(Uri.parse(ApiUrl.getDiscussions), body: {"group_id": group_id});

      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        print("Success");
        //  hideLoader();
        print("Success" + response.body.toString());
        GetDiscussionsModel? allServiceModel =
        GetDiscussionsModel.fromJson(jsonDecode(response.body));
        /*GetVideosModel? allServiceModel = GetVideosModel.fromJson(jsonDecode(response.body));
        data=allServiceModel.data;
        featuredVideos=allServiceModel.featuredVideos;
        resentVideos=allServiceModel.resentVideos;
        pendingvideo=allServiceModel.pendingVideo;*/
        getDiscussionsModeldata = allServiceModel.data;
        setState(() {});
        print("discussion =======");
        print(allServiceModel);
        print("discussion =======");
        return allServiceModel;
      } else {
        // hideLoader();
        print("Something went worange");
      }
    } catch (e) {
      //hideLoader();
      print("data===$e");
    }
  }

  List<String> items = ['Showing latest', 'oldest'];

  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation:  0,
            automaticallyImplyLeading: false,

            leading:
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed:
                  () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors.white,
            title: boldtext(AppColors.black, 16, widget.group_name!),
            actions: [

              Center(

                  child:   Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.all(5),
                      color: AppColors.primary.withOpacity(0.05),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        
                          boldtext(AppColors.primary, 12, widget.grupdata.toString()),
                          SvgPicture.asset(AppImages.listmember,height: 20,width: 20,),
                        ],
                      ),
                    )
                  )
              )
            ],
            centerTitle: true,

          ),
          backgroundColor: AppColors.BGColor,
          body:getDiscussionsModeldata!.length==0?Center(child: boldtext(AppColors.black,16,"Ask your questions"),):ListView.builder(
              shrinkWrap: true,
              itemCount:  getDiscussionsModeldata!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(

                  children: [
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        SizedBox(width: 20,),
                        CircleAvatar(
                          backgroundImage: NetworkImage(getDiscussionsModeldata![index].profileImage),
                        ),
                        SizedBox(width: 10,),
                        Text(DateFormat("dd-MMM-yyyy").format(getDiscussionsModeldata![index].createdAt)),
                        SizedBox(width: 10,),
                        Text(DateFormat("h:mm a").format(getDiscussionsModeldata![index].createdAt))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width:MediaQuery.of(context).size.width,

                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8))),

                      margin: EdgeInsets.only(left: 50,right: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          boldtext(AppColors.primary,14,getDiscussionsModeldata![index].displayName),
                          SizedBox(height: 10,),
                          boldtext(AppColors.black,14,getDiscussionsModeldata![index].title),
                          SizedBox(height: 10,),
                          regulartext(AppColors.hint,12,getDiscussionsModeldata![index].description),
                          SizedBox(height: 10,),
                          Wrap(
                            children: [
                              ...getDiscussionsModeldata![index].tags?.map((e) => Container(
                                margin: EdgeInsets.only(left: 10),
                                height:30,
                                decoration: new BoxDecoration(

                                  borderRadius: new BorderRadius.all(Radius.circular(15)),
                                  border: new Border.all(color:AppColors.primary),
                                ),
                                child: new Chip(
                                  backgroundColor:  Colors.white,
                                  label: new Text(e,
                                      style: new TextStyle(fontSize: 10.0, color: Colors.blueGrey)),
                                ),
                              ), )??[]
                            ],
                          ),
                          regulartext(AppColors.hint,12,"${getDiscussionsModeldata![index].commentCount} Comments"),
                          SizedBox(height: 10,),


                          SizedBox(height: 15,),
                          // Text(discussiondata[index].subMenu[position].comments),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                    backgroundColor: AppColors.lightblue
                                ),
                                onPressed: ()async{
                                  Get.to(GetDiscussionCommentScreen(data:getDiscussionsModeldata![index],discussion_id:getDiscussionsModeldata![index].id.toString() ,));



                                },

                                child:boldtext(AppColors.primary,12,"Post a Comment")),
                          )
                        ],
                      ),
                    )
                  ],
                );

              }),

            bottomNavigationBar: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                       Navigator.pushReplacement(
                          context,
                           MaterialPageRoute(
                             builder: (context) => AddDiscussionScreen(group_id: widget.group_id.toString(),),
                           ));

                    },
                    child:  Text(
                      'Post a Question',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    )),
              ),
            )
        ));
  }
}

