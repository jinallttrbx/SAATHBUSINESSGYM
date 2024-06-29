// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, file_names, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';



import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';

import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';
import '../../../Utils/ApiUrl.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../model/LoginModel.dart';
import '../../../values/Colors.dart';
import '../../../values/assets.dart';


class OTPConformScreen extends StatefulWidget {

  String number;


  OTPConformScreen( this.number,

      {super.key});

  @override
  OTPConformState createState() => OTPConformState();
}

class OTPConformState extends State<OTPConformScreen> {
  String? smscode;
  final myotpdController = TextEditingController();
  late Timer _timer;
  int _start = 30;
  final SharedPreference _sharedPreference = SharedPreference();
  Telephony telephony = Telephony.instance;
  @override
  void initState() {
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
          backgroundColor: AppColors.BGColor,
          title: regulartext(AppColors.black, 18, "OTP Verification"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppColors.BGColor,
          margin: const EdgeInsets.only(top: 00),
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
                 regulartext(AppColors.black,16,
                  'We’ve Sent A Verification Code To',

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boldtext(AppColors.black,18,
                      widget.number,

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
                          regulartext(AppColors.black,16,
                           "Resend OTP In ${ _start == 30
                  ? '00'
                      : _start < 10
                  ? '$_start'
                    : '$_start'}",

                          ),
                        ] else ...[
                TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0)),
      onPressed: () async {
        _start = 30;
        startTimer();
        GetLogin();
      },
      child: regulartext(AppColors.black,16,
        'Resend OTP In',

      ),
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
              child:   boldtext(AppColors.white,18,
                'Verify',

              ),
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
            return  Dialog(
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
                    regulartext(AppColors.black,16,'Loading...')
                  ],
                ),
              ),
            );
          });
      final response = await http.post(Uri.parse(ApiUrl.loginApiUrl),
          body: {
            "mobile_number": widget.number,
            "otp":otp,

          });
      Map<String, dynamic> map = json.decode(response.body);
      print(map['status']);
      if (response.statusCode == 200) {

        Map<String, dynamic> map = json.decode(response.body);

        if (map["status"] == true) {

          _sharedPreference.setLoggedIn("true");
          String ides =map["data"]['id'].toString();
          setState(() {
            USERID =ides;
          });
          String apitoken = map["data"]['api_token'].toString();
          _sharedPreference.setUsetId(ides.toString());
          _sharedPreference.setUserType(map["data"]['user_type']);
          _sharedPreference.setToken("Bearer " + apitoken);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashBoardScreen(),
            ),
          );

        }
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
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

  void GetLogin() async {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return  Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  regulartext(AppColors.black,16,'Loading...')
                ],
              ),
            ),
          );
        },
      );
      try {
        startTimer();
        final response = await http.post(Uri.parse(ApiUrl.loginApiUrl),
            body: {'mobile_number': "${widget.number}"});

        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (data['status'] == true) {
            Navigator.of(context).pop();
          } else if (data['status'] == false &&
              data['message'] ==
                  'Your Account is Blocked Please contact our cutomer care.') {
            Navigator.of(context).pop();
            await showDialog(
              context: context,
              builder: (_) => Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Builder(
                  builder: (context) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image:
                          Image.asset('assets/images/blockUser.PNG').image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: regulartext(AppColors.white,16,'Fail to send OTP on your Mobile number!!'),
                duration: Duration(seconds: 2)));
          }
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: regulartext(AppColors.white,16,'Mobile Number Not Register!!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
      }
    }

}
