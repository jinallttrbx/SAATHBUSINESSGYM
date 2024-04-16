import 'dart:convert';

import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/ServiceListModel.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Utils/ApiUrl.dart';
import '../Utils/SharedPreferences.dart';
import '../model/viewWork_profileModel.dart';
import '../values/Colors.dart';
import '../values/const_text.dart';

class ServiceController extends GetxController {
  RxList<ServiceCategory> serviceprofilelist =
  RxList<ServiceCategory>([]);
  List<ServiceCategory> serviceprofilelist2 = [];
  var viewWorkprofilehint = "Select Work Profile".obs;
  final SharedPreference _sharedPreference = SharedPreference();

  bool isLoading = false;

  viewsericeprofile({bool? loader, String? id}) async {
    serviceprofilelist.value = [];
    isLoading = true;
    USERTOKKEN = await _sharedPreference.isToken();
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.getservicelist),
        headers: {"Authorization": USERTOKKEN!, "Accept": "application/json"},
      );
      Map<String, dynamic> data = jsonDecode(response.body);

      serviceprofilelist.value = [];
      serviceprofilelist2 = [];
      print(data['status']);
      if (data['status'] == true) {
        final data = Getserviceslistmodel.fromJson(jsonDecode(response.body));
        serviceprofilelist2 = data!.data!;
        serviceprofilelist.value = data.data;
        isLoading = false;
      }
      if (loader == true) {
        hideLoader();
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
    update();
  }


}
