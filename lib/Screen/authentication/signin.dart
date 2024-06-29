// ignore_for_file: body_might_complete_normally_nullable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'dart:convert';


import 'package:businessgym/Screen/authentication/LoginVerificationScreen.dart';
import 'package:businessgym/Screen/authentication/selectorRegistration.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/ApiUrl.dart';
import '../../Utils/SharedPreferences.dart';
import '../../values/assets.dart';
import '../../values/const_text.dart';


class SignInScreen extends StatefulWidget {
  String? number;
  SignInScreen({super.key, this.number});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final numberController = TextEditingController();
  String mobile = "";
  final mypasswordController = TextEditingController();
  SharedPreference prefs = SharedPreference();
  @override
  void initState() {
    super.initState();
    if (widget.number != null) {
      numberController.text = widget.number.toString();
    }
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: AppColors.BGColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,


                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(

                      width: 476,
                      height: 300,
                      child: Stack(
                        children: [
                          Positioned(

                            left: 26,
                            top: 0,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkthree,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 148,
                            top: 0,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walksecond,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 270,
                            top: 0,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkfirst,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 50,
                            top: 100,
                            child: Align(
                              child: SizedBox(
                                width: 50,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkfirst,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 270,
                            top: 100,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.APP_SPLASH,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 150,
                            top: 100,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkthree,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 50,
                            top: 200,
                            child: Align(
                              child: SizedBox(
                                width: 50,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkthree,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 270,
                            top: 200,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkthree,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 150,
                            top: 200,
                            child: Align(
                              child: SizedBox(
                                width: 110,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppImages.walkthree,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(

                            left: 0.0000135646,
                            top: 100,
                            child: Align(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 600,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(-0, 1),
                                      end: Alignment(0, -1),
                                      colors: <Color>[
                                        Color(0xffffffff),
                                        Color(0xffffffff),
                                        Color(0xb2ffffff),
                                        Color(0x00ffffff)
                                      ],
                                      stops: <double>[0, 0.885, 0.932, 1],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.logo),
                                Image.asset(AppImages.namelogo),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                     Center(
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 1.3625,
                          color: AppColors.primary,
                        ),
                      ).translate(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // const Center(
                    //   child: Text(
                    //     'Enter Phone Number To Login',
                    //     style: TextStyle(
                    //       fontFamily: 'OpenSans',
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       height: 1.3625,
                    //       color: Color(0xff262627),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: AppColors.textfieldcolor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number, maxLength: 10,
                        // textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding:  EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          fillColor: AppColors.green,
                          hintText: 'Enter Phone Number',
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.25),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 30),
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
                              GetLogin();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ).translate(),),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       // line53Z5 (247:17887)
                    //       margin: const EdgeInsets.fromLTRB(0, 3, 9, 0),
                    //       width: 75,
                    //       height: 1,
                    //       decoration: const BoxDecoration(
                    //         color: Color(0xffa6a6a6),
                    //       ),
                    //     ),
                    //     const Text("OR"),
                    //     Container(
                    //       // line53Z5 (247:17887)
                    //       margin: const EdgeInsets.fromLTRB(0, 3, 9, 0),
                    //       width: 75,
                    //       height: 1,
                    //       decoration: const BoxDecoration(
                    //         color: Color(0xffa6a6a6),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 30),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: AppColors.primary, width: 1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: AppColors.registerbutton,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SelectorRegister()));
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ).translate()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void GetLogin() async {
    if (numberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter Mobile Number!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (numberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter Valid Mobile Number!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (numberController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter Valid Mobile nNmber!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
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
                  SizedBox(height: 15),
                  Text('Loading...')
                ],
              ),
            ),
          );
        },
      );
      try {
        final response = await http.post(Uri.parse(ApiUrl.loginApiUrl),
            body: {'mobile_number': "+91${numberController.text}"});

        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (data['status'] == true) {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPConformScreen(
                  "+91${numberController.text}".toString(),
                ),
              ),
            );
          } else if (data['status'] == false &&
              data['message'] ==
                  'Your Account is Blocked Please Contact Our Cutomer Care.') {
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
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Fail To Send OTP On Your Mobile Number!'),
                duration: Duration(seconds: 2)));
          }
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mobile Number Not Register!!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
      }
    }
  }
}

launchURL(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication)) {
    throw Exception('Could not launch $uri');
  }
}

Widget abount(String url, String text) {
  return Container(
    padding: const EdgeInsets.only(bottom: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 23,
          color: Colors.red,
        ),
        TextButton(
          onPressed: () {
            launchURL(url);
          },
          child: boldtext(Colors.red, 15, text),
        )
      ],
    ),
  );
}



Widget textArea1(TextEditingController controller, String hint, {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: TextField(

          textCapitalization: hint=="Full Name"?TextCapitalization.words:TextCapitalization.none,
          controller: controller,
          keyboardType: hint == "Phone Number"
              ? TextInputType.number
              : TextInputType.name,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.white, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: AppColors.textfieldcolor,
              hintText: hint),
        ),
      ),
    ],
  );
}
