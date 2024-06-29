import 'dart:convert';

import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/ProductListModel.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Utils/ApiUrl.dart';
import '../Utils/SharedPreferences.dart';
import '../values/Colors.dart';
import '../values/const_text.dart';

class ProductController extends GetxController {
  RxList<ProductCategory> productprofilelist =
  RxList<ProductCategory>([]);
  List<ProductCategory> productprofilelist2 = [];
  var viewWorkprofilehint = "Select Work Profile".obs;
  final SharedPreference _sharedPreference = SharedPreference();

  bool isLoading = false;

  viewproductprofile({bool? loader, String? id}) async {
    productprofilelist.value = [];
    isLoading = true;
    USERTOKKEN = await _sharedPreference.isToken();
    print(USERTOKKEN);
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.getproductlist),
        headers: {"Authorization": USERTOKKEN!, "Accept": "application/json"},
      );
      Map<String, dynamic> data = jsonDecode(response.body);

      productprofilelist.value = [];
      productprofilelist2 = [];
      if (data['status'] == true) {
        final data = Getproductlistmodel.fromJson(jsonDecode(response.body));
        productprofilelist2 = data!.data!;
        productprofilelist.value = data.data;
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
