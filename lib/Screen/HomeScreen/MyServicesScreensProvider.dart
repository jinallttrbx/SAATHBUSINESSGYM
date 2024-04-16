

import 'package:businessgym/Utils/extra.dart';
import 'package:businessgym/conts/appbar_global.dart';

import 'package:flutter/material.dart';


import '../../../Utils/SharedPreferences.dart';

import '../../../values/Colors.dart';

import '../../../conts/search_service.dart';

class MyServicesScreensProvider extends StatefulWidget {
  final String? BecomeSuplier;
  const MyServicesScreensProvider(this.BecomeSuplier);

  @override
  MyServicesScreensProviderState createState() =>
      MyServicesScreensProviderState();
}

class MyServicesScreensProviderState extends State<MyServicesScreensProvider> {



  int selected = 1;

  bool abc = false;
  String? UserId;
  String? BecomeSuplier;
  SharedPreference _sharedPreference = new SharedPreference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usetId();
  }

  Future<void> usetId() async {
    UserId = await _sharedPreference.isUsetId();

    BecomeSuplier = await _sharedPreference.isBecomeSuplier();


    setState(() {});

  }

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: APPBar(title: ''),

      body: SearchWidget()
    );
  }






}
