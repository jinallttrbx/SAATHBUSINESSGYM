// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, file_names, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';


import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/Screen/authentication/signin.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';
import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../model/LoginModel.dart';
import '../../values/Colors.dart';
import '../../values/assets.dart';


class RegisterAccountConformScreen extends StatefulWidget {
  String firstname;
  String Email;
  String number;
  String type;
  String referalcode;
  String gender;
  String organizationid;
  RegisterAccountConformScreen( this.firstname,this.Email,this.number,this.type,this.referalcode,this.gender,this.organizationid,

      {super.key});

  @override
  RegisterAccountConformScreenState createState() => RegisterAccountConformScreenState();
}

class RegisterAccountConformScreenState extends State<RegisterAccountConformScreen> {

  bool isLoading = false;
  bool isResend = false;
  String? smscode;
  final myotpdController = TextEditingController();
  var controlleradd = Get.put(addressController());
  late Timer _timer;
  int _start = 30;
  final SharedPreference _sharedPreference = SharedPreference();
  Telephony telephony = Telephony.instance;
  @override
  void initState() {
    controlleradd.onInit();
    startTimer();
    autofillsms();
    super.initState();
    setState(() {
    });
  }



  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation:  0,
          automaticallyImplyLeading: false,
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed:
                () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: regulartext(AppColors.black, 18, "OTP Verification"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppColors.BGColor,
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'We’ve Sent A Verification Code To',
                  style: TextStyle(
                    fontFamily: "Opensans",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ).translate(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.number,
                      style: const TextStyle(
                        fontFamily: "Opensans",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                vertical(24),
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: PinCodeTextField(
                      textStyle: const TextStyle(color: AppColors.black),
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveFillColor: AppColors.white,
                        inactiveColor: AppColors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 60,
                        fieldWidth: 60,
                        activeColor: AppColors.white,
                        activeFillColor: AppColors.white,
                      ),
                      // cursorColor: cColor.textwhitecolor,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: myotpdController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 8,
                        )
                      ],

                      onChanged: (value) {
                        setState(() {
                          smscode = value;
                        });
                      },
                    )),
                vertical(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_timer.isActive) ...[
                          Text(
                            "Resend OTP In ${ _start == 30
                                ? '00'
                                : _start < 10
                                ? '$_start'
                                : '$_start'}",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                              color: Color(0xffA6A6A6),
                            ),
                          ).translate(),
                        ] else ...[
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () async {
                              _start = 30;
                              startTimer();
                              resendotp(
                                  widget.firstname,
                                  widget.Email,
                              widget.number,
                              widget.type,
                              widget.referalcode,
                              widget.gender,
                              widget.organizationid,
                              );
                            },
                            child: const Text(
                              'Resend OTP In',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA6A6A6),
                              ),
                            ).translate(),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                verifyotp();
              },
              child: const Text(
                'Verify',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ).translate(),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> getData(String otp) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return const Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Loading...')
                  ],
                ),
              ),
            );
          });
      //  print(ApiUrl.RegisterApiUrl);
      //  print(widget.type);
      // print(widget.username);
      final response = await http.post(Uri.parse(ApiUrl.RegisterApiUrl),
          body: {
            "email":widget.Email,
            "user_type":widget.type,
            "contact_number": widget.number,
            "full_name": widget.firstname,
            "isSupplier": widget.type == 'supplier' ? "1" : "0",
            "otp":otp,
            "gender":widget.gender,
           // "referral_code": widget.referalcode,
            "organizations_id":widget.organizationid
          });
    //
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        print(map["status"]);
        if (map["status"] == true) {
          _sharedPreference.setLoggedIn("true");
          String ides =map["data"]['id'].toString();
          String apitoken = map["data"]['api_token'].toString();
          _sharedPreference.setUsetId(ides.toString());
          _sharedPreference.setUserType(map["data"]['user_type']);
          _sharedPreference.setToken("Bearer " + apitoken);
          // Timer(const Duration(seconds: 5), () => DashBoardScreen());
           Navigator.pushReplacement(
             context,
             MaterialPageRoute(
               builder: (context) => const DashBoardScreen(),
             ),
           );

        }else if(response.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(map["message"] ),
          ));
        }
        else{
          setState(() {
          //  hideLoader();
          });
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(map["message"] ),
          ));

          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));

        }
      } else {
        setState(() {
          hideLoader();
        });
        //Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        hideLoader();
      });
     // Navigator.of(context).pop();
    }
  }

  void verifyotp() {
    getData(myotpdController.text);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            _timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void autofillsms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        setState(() {});
        String sms = message.body.toString();
        String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
        String result = otpcode.substring(0, otpcode.length);
        int modifiedNumber = int.parse(result);
        setState(() {
          myotpdController.text = modifiedNumber.toString();
        });
        verifyotp();
      },
      listenInBackground: false,
    );
  }

  Future<bool?> resendotp(
      String email,
      String number,
      String firstname,
      String gender,
      String referalcode,
      String type,
      String organizationid) async {
    showLoader(context);

    try {
      Map<String, String> requestBody = <String, String>{
        "email": email,
        "contact_number":  number,
        "full_name": firstname,
        "isSupplier": type == 'supplier' ? "1" : "0",
        "gender": gender,
        "referral_code": referalcode,
        "user_type": type,
        "organizations_id": organizationid,
      };
      final response = await http.post(
        Uri.parse(ApiUrl.RegisterApiUrl),
        body: requestBody,
      );
      print(requestBody);
      print(response.statusCode);
      print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
           hideLoader();

      } else if (response.statusCode == 400) {
        if (map['status'] == true) {
         // showInSnackBar("Already Register", color: Colors.red);
          hideLoader();
        } else {
          hideLoader();
        }
      }
    } catch (e) {
      hideLoader();
    }
  }
}
