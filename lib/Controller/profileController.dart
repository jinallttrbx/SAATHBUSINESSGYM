import 'dart:convert';
import 'dart:math';


import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/ApiUrl.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../model/MyservicesrequestModel.dart';
import '../../../model/ProfileModel.dart';
import 'package:http/http.dart' as http;

import '../../../model/ViewoccuaptionsModel.dart';

class ProfileController extends GetxController {
  SharedPreference sharedPreference = SharedPreference();

  RxInt windowIndex = 1.obs;
  updateWindowIndex(int value) {
    windowIndex.value = value;
  }

  var isLoading = false.obs;
  var UserId;
  var usertoken;
  var userProfile = {}.obs;
  Future<ProfileModelData?>? providerdatalist;
  // List<BusinessPhoto>? businessPhotos = [];
  ProfileModel? profileModel;
  var username = "".obs;
  var profilename = "".obs;
  var images = "".obs;
  var email = "".obs;
  var gender = "".obs;
  var number = "".obs;
  var city = "".obs;
  var address = "".obs;
  var firstname = "".obs;
  var lastname = "".obs;
  var referral_code = "".obs;
  var occupation_id = "".obs;
  var bgId = "".obs;
  var reviews = "".obs;
  var ratingStar = "".obs;
  var cutomerCount = "".obs;
  var designation = "".obs;
  var last_online_time = "".obs;
  var mode_of_business = "".obs;
  var business_timing = "".obs;
  var gst_number = "".obs;
  var license_number = "".obs;
  var fassai_number = "".obs;
  var company_name = "".obs;

  List<ViewoccuaptionsModelData>? viewoccuaptionsModelData = [];
  RxList<ViewoccuaptionsModelData> listData1 =
  RxList<ViewoccuaptionsModelData>([]);
  var currentOccupation = ''.obs;
  var usertype;
  Future<void> userid() async {
    isLoading.value = true;
    usertype = await sharedPreference.isUserType();
    USER_TYPE = usertype;
    isUSER_TYPE = usertype;
    UserId = await sharedPreference.isUsetId();
    usertoken = await sharedPreference.isToken();
    USERTOKKEN = usertoken;
    providerdatalist = addLoanModeloges(UserId!);

    getcategotyData();

    // listData1 = getcategotyData();
  }

  getoccupation() {
    if (occupation_id != "null" &&
        occupation_id != "" &&
        occupation_id != null) {
      for (var i = 0; i < viewoccuaptionsModelData!.length; i++) {
        if (viewoccuaptionsModelData![i].id ==
            int.parse(occupation_id.toString())) {
          currentOccupation.value =
              viewoccuaptionsModelData![i].title.toString();
        } else {}
      }
    }
  }

  removePorfilePicture(String userId) async {
    try {
      var requestBody = {'id': userId};
      final response = await http.post(
        Uri.parse(ApiUrl.removeProfile),
        headers: {"Authorization": usertoken!, "Accept": "application/json"},
        body: requestBody,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        images.value = "";
      } else {

      }
    } catch (e) {

    }
  }

  Future<ProfileModelData?> addLoanModeloges(String userId) async {


    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse(ApiUrl.view_profile),
        headers: {"Authorization": usertoken!, "Accept": "application/json"},
        body: requestBody,
      );

      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        occupation_id.value = map["data"]["occupation_id"].toString();
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));


        userProfile.value = map["data"];

        username.value = profileModel!.data!.displayName!;
        profilename.value = profileModel!.data!.username!;
        images.value = profileModel!.data!.profileImage!;
        email.value = profileModel!.data!.email!;
        number.value = profileModel!.data!.contactNumber!;
        city.value = "";
        address.value = profileModel!.data!.address!;
        firstname.value = profileModel!.data!.username!;
        lastname.value = profileModel!.data!.lastName!;
        // referral_code.value = profileModel!.data!.referral_code!;
        designation.value = profileModel!.data!.designation!;
        last_online_time.value = profileModel!.data!.lastOnlineTime!;
        mode_of_business.value = profileModel!.data!.modeOfBusiness!;
        business_timing.value = profileModel!.data!.businessTiming!;
        gst_number.value = profileModel!.data!.gstNumber!;
        license_number.value = profileModel!.data!.licenseNumber!;
        fassai_number.value = profileModel!.data!.fassaiNumber!;
        company_name.value = profileModel!.data!.companyName!;

        //  bgId.value = profileModel!.data!.bg_id!.toString();
        // reviews.value = profileModel!.data!.reviews!.toString();
        //  ratingStar.value = profileModel!.data!.rating_star!.toString();
        // occupation_id.value=profileModel.data.;
        // business_photos.value = profileModel!.businessPhotos!;
        isLoading.value = false;
        return profileModel!.data;
      } else {
        isLoading.value = false;
        return profileModel!.data;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<List<ViewoccuaptionsModelData>?> getcategotyData() async {
    try {
      Map<String, String> requestBody = <String, String>{};

      final response = await http.post(
        Uri.parse(ApiUrl.viewoccuaptions),
      );
      Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        viewoccuaptionsModelData = [];
        ViewoccuaptionsModel catrgortModel =
        ViewoccuaptionsModel.fromJson(jsonDecode(response.body));
        listData1.value = catrgortModel.data;
        ViewoccuaptionsModelData categoryModelData = ViewoccuaptionsModelData(
            id: 0, title: "Select Occupation", status: 0);
        viewoccuaptionsModelData!.add(categoryModelData);
        for (int i = 0; i < catrgortModel.data!.length; i++) {
          ViewoccuaptionsModelData categoryModelData = ViewoccuaptionsModelData(
              id: catrgortModel.data![i].id,
              title: catrgortModel.data![i].title,
              status: catrgortModel.data![i].status);
          viewoccuaptionsModelData!.add(categoryModelData);
        }

        // mycategory = categorydata[0].subjectTital
        // categorydata = catrgortModel.data;
        getoccupation();
        return viewoccuaptionsModelData;
      }

    } catch (e) {

    }
  }
  // Future<List<ViewoccuaptionsModelData>?> getcategotyData() async {
  //   viewoccuaptionsModelData = [];
  //   try {
  //     Map<String, String> requestBody = <String, String>{};

  //     final response = await http.post(
  //       Uri.parse(ApiUrl.viewoccuaptions),
  //     );
  //     Map<String, dynamic> map = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       ViewoccuaptionsModel catrgortModel =
  //           ViewoccuaptionsModel.fromJson(jsonDecode(response.body));

  //       ViewoccuaptionsModelData categoryModelData = ViewoccuaptionsModelData(
  //           id: 0, title: "Select Occupation", status: 0);
  //       viewoccuaptionsModelData!.add(categoryModelData);
  //       for (int i = 0; i < catrgortModel.data!.length; i++) {
  //         ViewoccuaptionsModelData categoryModelData = ViewoccuaptionsModelData(
  //             id: catrgortModel.data![i].id,
  //             title: catrgortModel.data![i].title,
  //             status: catrgortModel.data![i].status);
  //         viewoccuaptionsModelData!.add(categoryModelData);
  //       }

  //       // mycategory = categorydata[0].subjectTital
  //       // categorydata = catrgortModel.data;

  //
  //       return viewoccuaptionsModelData;
  //     }
  //
  //   } catch (e) {
  //
  //   }
  // }

  //==========================================================================================================
  getserviceList() async {
    try {
      // showLoader(context);
      final response = await http.post(
        Uri.parse(ApiUrl.providerbookings),
        headers: {"Authorization": USERTOKKEN.toString()},
        // ignore: prefer_interpolation_to_compose_strings
        body: {"provider_id": "" + UserId},
      );


      if (response.statusCode == 200) {
        List<LeadDataModel>? uniqueList = [];
        LeadDataModel? myBookingModel =
        LeadDataModel.fromJson(jsonDecode(response.body));

        for (var i = 0; i < myBookingModel.data!.length; i++) {
          if (uniqueList!.any((element) =>
          element.data![i].name == myBookingModel.data![i].myBooking)) {
          } else {
            uniqueList!.add(myBookingModel);
          }
        }

        // hideLoader();
        cutomerCount.value =
        uniqueList.isEmpty ? "0" : uniqueList.length.toString();

      } else {

      }
    } catch (e) {

    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userid();
  }
}

class ProfileController1 extends GetxController {
  var isLoading = true.obs;
  ProfileModelData? profileData;
  var statusCode = 200.obs;

  var name = "".obs;
  var userName = "".obs;
  var avtar = "".obs;

  getdata() async {
    isLoading.value = true;
    try {
      var response = await http.post(
          Uri.parse(
              "https://saath.lttrbxtech.com/api/getProductAndServiceByProvider"),
          headers: {"Authorization": USERTOKKEN.toString()},
          body: {"id": "368"});
      Map<String, dynamic> jsondata = jsonDecode(response.body);

      statusCode.value = response.statusCode;

      if (response.statusCode == 200) {
        if (jsondata["status"] == true) {
          ProfileModelData getproject =
          ProfileModelData.fromJson(jsonDecode(response.body));
          profileData = getproject;

        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        //showInSnackBar(jsondata["message"], color: Colors.red);
      }

      isLoading.value = false;
    } catch (e) {

      print(e.toString());
      isLoading.value = false;
    }
  }
}
