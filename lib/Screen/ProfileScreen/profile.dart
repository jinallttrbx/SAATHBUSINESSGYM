

import 'dart:convert';

import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/Screen/CRM%20Screens/customer_Crm.dart';
import 'package:businessgym/Screen/ProfileScreen/AboutUsScreen.dart';
import 'package:businessgym/Screen/ProfileScreen/EditProfilescreen.dart';
import 'package:businessgym/Screen/ProfileScreen/feedbackScreen.dart';
import 'package:businessgym/Screen/ProfileScreen/help_support.dart';

import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
import 'package:businessgym/Screen/authentication/signin.dart';

import 'package:businessgym/Screen/ProfileScreen/MyEntitlementsScreen.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Screen/ProfileScreen/languages.dart';

import 'package:businessgym/Controller/workprofileController.dart';
import 'package:businessgym/Screen/ProfileScreen/edit_profile.dart';
import 'package:businessgym/Screen/ProfileScreen/myservices.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/olddocument/document.dart';


import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'add_edit_business_details.dart';

class ProfileScreen extends StatefulWidget {
  bool? back;
  ProfileScreen({super.key, this.back});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  SharedPreference sharedPreference = SharedPreference();
  final workcontroller = Get.find<WorkProfileController>();

  final userprofile = Get.find<UserProfileController>();
  String profileimage = "";
  String UserType="";
  String UserId="";

  @override
  void initState() {
    getuserType();
workcontroller.viewWorkprofilelist();
    userprofile.viewprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              vertical(30),
              Container(
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                          NetworkImage(userprofile.productprofilelist?.profileImage??""),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 12,
                                      child: boldtext(
                                        AppColors.black,
                                        16,
                                        "${userprofile.productprofilelist?.username??""} ",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("GO TO EDIT PROFILE SCREEN ");
                                        Get.to(
                                              () => EditUserProfileScreen(image: userprofile.productprofilelist!.profileImage!,
                                            fname: userprofile.productprofilelist!.username!,mobile:userprofile.productprofilelist!.contactNumber!,gender:userprofile.productprofilelist!.gender??"" ,email:userprofile.productprofilelist!.email!   ),
                                        );
                                      },
                                      child: SvgPicture.asset(AppImages.edit),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                        direction: Axis.horizontal,
                                        rating: userprofile.productprofilelist?.rating_star==null?0:userprofile.productprofilelist?.rating_star??0,
                                        itemCount: 5,
                                        itemSize: 14,
                                        itemPadding:  EdgeInsets.all(2),
                                        unratedColor: Colors.grey,
                                        itemBuilder: (context, _) =>
                                            SvgPicture.asset(AppImages.rating),
                                      ),
                                      boldtext(Colors.black, 12,
                                          userprofile.productprofilelist?.rating_star==null?"0":userprofile.productprofilelist?.rating_star)
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [
                                    regulartext(
                                      AppColors.black,
                                      12,
                                      "Refferal Code : ${ userprofile.productprofilelist?.referral_code}",
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                            ClipboardData(text: userprofile.productprofilelist?.referral_code.toString()??""));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Copy Refferal code "),
                                        ));
                                      },
                                      child: SvgPicture.asset(AppImages.copy),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              UserType=="user"?SizedBox.shrink(): Container(
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(context,MaterialPageRoute(builder: (context)=>
                            const AddEditBusinessProfileScreen(isEdit: false),
                          ))?.then((value) => workcontroller.viewworkProfile());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.09),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          width: 50,
                          height: 180,
                          child: const Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Expanded(child: GetBuilder<WorkProfileController>(
                          builder: (controller) {
                            return controller.isLoading
                                ? Center(child: const CircularProgressIndicator())
                                :  workcontroller.viewWorkprofilelist.length==0?Center(
                              child: boldtext(AppColors.black,16,"First add work profile "),
                            ):
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              controller: ScrollController(),
                              itemCount:
                              workcontroller.viewWorkprofilelist.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                           AddEditBusinessProfileScreen(isEdit: true, workProfile: workcontroller.viewWorkprofilelist[index]),
                                          ));
                                        },
                                        child: Container(
                                          height: 180,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          margin:
                                          const EdgeInsets.only(left: 15),
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 10),
                                          width: 200,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration:
                                                  const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      topRight:
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    AppImages.elips,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  boldtext(
                                                      AppColors.primary,
                                                      14,
                                                      workcontroller
                                                          .viewWorkprofilelist[
                                                      index]
                                                          .title
                                                          .toString()),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  boldtext(
                                                      AppColors.black,
                                                      12,
                                                      workcontroller
                                                          .viewWorkprofilelist[
                                                      index]
                                                          .subTitle
                                                          .toString()),
                                                  regulartext(
                                                      AppColors.hint,
                                                      12,
                                                      "${"${workcontroller.viewWorkprofilelist[index].productCount} Product"}"
                                                          "|"
                                                          "${"${workcontroller.viewWorkprofilelist[index].serviceCount} Service"}"),
                                                  const SizedBox(height: 16),
                                                  regulartext(
                                                      AppColors.hint,
                                                      12,
                                                      "${workcontroller.viewWorkprofilelist[index].openAt ?? ''} To ${workcontroller.viewWorkprofilelist[index].closeAt ?? ''}"),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  regulartext(
                                                      AppColors.hint,
                                                      12,
                                                      workcontroller
                                                          .viewWorkprofilelist[
                                                      index]
                                                          .businessAddress ??
                                                          ""),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                );
                              },
                              // ),
                            );
                          }))
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      UserType=="user"?GestureDetector(
                        onTap: () {
                          Get.to(
                             CustomerCRMScreen(),
                          );
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.product),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "History",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ):
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const MyServices(),
                          );
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.product),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Services/Products",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      UserType=="user"?SizedBox(height: 20,):   const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => MyEntitlementsScreen());
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.document),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Documents",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      UserType=="user"?SizedBox.shrink():   const SizedBox(
                        height: 20,
                      ),
                      UserType=="user"?SizedBox.shrink():   GestureDetector(
                        onTap: () {
                          print("Services");

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.wallt),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "My wallets",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                                () => RatingandReviewByUserScreens(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.hand),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: boldtext(
                                    AppColors.black,
                                    14,
                                    "Review and Ratings",
                                  )),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const Languages());
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.language),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Language",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Help_supportScreen()));
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.help),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Help & Support",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackScreen()));
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.feedback),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Feedback",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to( AboutUsScreen());
                          print("Services");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.about),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "About us",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Services");
                          _logout(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImages.logout),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: boldtext(
                                  AppColors.black,
                                  14,
                                  "Logout",
                                ),
                              ),
                              SvgPicture.asset(AppImages.altarroe)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              vertical(20),
              // ProfileWindowWidget(),
              vertical(120)
            ],
          ),
        )
        // ),
        );
  }

  _logout(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: SizedBox(
                height: 245,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(subMenu.image),
                        const SizedBox(
                          width: 10,
                        ),
                        boldtext(AppColors.black, 18, "Logout"),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  Center(
                    child:   regulartext(
                      const Color(0xffA6A6A6),
                      14,
                      "Are you sure you want to log out?",
                    ),
                  ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: AppColors.logout,
                          ),
                          onPressed: () async {
                            sharedPreference.getAllPrefsClear();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child:
                              boldtext(AppColors.white, 14, "Confirm logout"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: regulartext(AppColors.black, 14, "Cancel"),
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }

  void getuserType() async {
    print("GET PROFILE DATA UPDATED");
    var usertype = await sharedPreference.isUserType();
    var userid= await sharedPreference.isUserid();
    setState(() {
      UserType=usertype;
      UserId=userid;
    });

    print("USERTYPE__$UserType");
    print("USERTYPE__$UserId");
  }


}



