import 'dart:convert';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/model/notification_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../Utils/common_route.dart';
import '../../model/NotificationModel.dart';
import '../../values/Colors.dart';
import '../../values/const_text.dart';
import '../../conts/global_values.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationResponseModel? notificationResponseModel;
  const NotificationScreen(
      {super.key, required this.notificationResponseModel});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  Future<List<NotificationModelData?>?>? alltransactionmodel;
  List<NotificationModelData?>? transactionData = [];
  List<NotificationView> notificationdata = [];
  String? UserId;
  SharedPreference _sharedPreference = new SharedPreference();

  Future<bool> readNotification(String notificationId) async {
    try {
      Map<String, String> requestBody = <String, String>{
        'notification_id': notificationId,
      };
      Map<String, String> headers = {'Authorization': USERTOKKEN.toString()};
      var url = Uri.parse(ApiUrl.readNotification);
      final response =
          await http.post(url, headers: headers, body: requestBody);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid();
    NotificationList.forEach((element) {
      notificationdata.add(NotificationView.fromJson(element));
    });
  }

  Future<void> userid() async {
    UserId = await _sharedPreference.isUsetId();
    String? usertype = await _sharedPreference.isUserType();
    alltransactionmodel = notifications(usertype);
  }

  Future<List<NotificationModelData?>?>? notifications(String type) async {
    try {
      showLoader(context);
      Map<String, String> requestBody = <String, String>{};

      final response = await http.post(
        Uri.parse(ApiUrl.notificationList),
        body: {'user_type': type},
      );
      if (response.statusCode == 200) {
        hideLoader();
        NotificationModel? myBookingModel = NotificationModel.fromJson(
          jsonDecode(response.body),
        );
        transactionData = myBookingModel.data!;
        setState(() {});
        return myBookingModel.data;
      } else {
        hideLoader();
      }
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: APPBar(title: "Notification"),
        backgroundColor: AppColors.BGColor,
        body: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(16)),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:notificationdata.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        await readNotification(widget
                            .notificationResponseModel?.data?[index].id
                            .toString()??'')
                            .then((value) {

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldtext(AppColors.black,14,notificationdata[index].name??""),
                            regulartext(AppColors.hint,12,notificationdata[index].hours??""),
                            SizedBox(height: 10,),
                            regulartext(AppColors.black,12,notificationdata[index].description??""),
                            SizedBox(height: 10,),
                         Divider(height: 1,thickness: 1,)
                          ],
                        )
                      ),
                    );
                    ;
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
List NotificationList = [
  {
    "name": "Service booking placed",
    "hours":"3 Hrs ago",
    "description":"Your Gas leak detection and fixing service request was placed successfully. It will be serviced on December 12th at 8:30 pm."

  },
  {
    "name": "Product booking placed",
    "hours":"5 Hrs ago",
    "description":"your product Book (Qty 6) Was booked successfully"

  },
  {
    "name": "Service booking placed",
    "hours":"3 Hrs ago",
    "description":"Your Gas leak detection and fixing service request was placed successfully. It will be serviced on December 12th at 8:30 pm."

  },
  {
    "name": "Service booking placed",
    "hours":"3 Hrs ago",
    "description":"Your Gas leak detection and fixing service request was placed successfully. It will be serviced on December 12th at 8:30 pm."

  },
];
class NotificationView {
  var name;
  var hours;
  var description;

  List<NotificationView> subMenu = [];

  NotificationView({this.hours,this.name, required this.subMenu, this.description});

  NotificationView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hours = json['hours'];
    description=json['description'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu?.add(new NotificationView.fromJson(v));
      });
    }
  }

}
