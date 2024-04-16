// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:businessgym/Screen/authentication/signin.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

import '../../Utils/ApiUrl.dart';
import '../../Utils/common_route.dart';
import '../../values/Colors.dart';
import '../../values/assets.dart';
import '../../values/const_text.dart';
import '../../values/spacer.dart';
import 'RegisterAccountConformScreen.dart';

class RegisterAccountEmailScreen extends StatefulWidget {
  String? type;
  String? organizationId;

  RegisterAccountEmailScreen(this.type, this.organizationId, {super.key});

  @override
  RegisterAccountEmailState createState() => RegisterAccountEmailState();
}

class RegisterAccountEmailState extends State<RegisterAccountEmailScreen> {
  final mynumberController = TextEditingController();
  final referral_codeController = TextEditingController();
  final _firstcontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();
  final _emailcontroller2 = TextEditingController();
  String mobile = "";
  String gender = "male";
  var countryCode = '+91';
  bool visible = false;
  var smscode;
  bool isLoading = false;
  String status = "Select";
  String? _selectedItem;
  final List<Map<String, dynamic>> _dropdownItems = [
    {
      'id': '1',
      'type': 'Supplier',
      'text': 'supplier',
      'image': AppImages.suppier,
    },
    {
      'id': '2',
      'type': 'Micro Entrepreneur',
      'text': 'provider',
      'image': AppImages.microenterprinute,
    },
    {
      'id': '3',
      'type': 'Customer',
      'text': 'user',
      'image': AppImages.customer,
    },
  ];


  @override
  void initState() {
    super.initState();
    if (MOBILE_NUM != null) {
      mynumberController.text = MOBILE_NUM!;
    }
    if (widget.type != null) {
      _selectedItem = widget.type;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              color: AppColors.BGColor,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vertical(40),
                    //Image.asset(AppImages.APP_LOGO),
                    const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontFamily: "OpenSans"),
                    ),
                    const Text(
                      "Provide Details To Create A New Account.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans"),
                    ),

                    vertical(20),
                    DropdownButton<String>(
                      hint: const Text('Select a type'),
                      value: _selectedItem,
                      onChanged: (String? newValue) {
                        print(newValue);
                        setState(() {
                          _selectedItem = newValue!;
                        });
                      },
                      items:
                          _dropdownItems.map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          onTap: () {},
                          value: item['text'],
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  item['image'],
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Text(item['type']),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          vertical(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: textArea1(_firstcontroller, "Full Name"),
                          ),
                          vertical(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: textArea1(_emailcontroller2, "Email Id"),
                          ),
                          vertical(10),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(left: 17, right: 17),
                            decoration: const BoxDecoration(
                                color: AppColors.textfieldcolor,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: TextFormField(
                              controller: _phonenumbercontroller,
                              keyboardType: TextInputType.number, maxLength: 10,
                              // textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                fillColor: AppColors.green,
                                hintText: 'Phone no.',
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

                          vertical(10),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Select gender",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        gender = "male";
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: gender == "male"
                                                      ? AppColors.primary
                                                      : Colors.white),
                                              color: gender == "male"
                                                  ? const Color(0xffF1FAFF)
                                                  : Colors.grey.shade100,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16))),
                                          child: SvgPicture.asset(
                                            AppImages.male,
                                            height: 14,
                                          ),
                                        ),
                                        Text(
                                          "Male",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "OpenSans",
                                              color: gender == "male"
                                                  ? AppColors.primary
                                                  : Colors.grey),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        gender = "female";
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: gender == "female"
                                                      ? AppColors.primary
                                                      : Colors.white),
                                              color: gender == "female"
                                                  ? const Color(0xffF1FAFF)
                                                  : Colors.grey.shade100,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16))),
                                          child: SvgPicture.asset(
                                            AppImages.female,
                                            height: 14,
                                          ),
                                        ),
                                        Text(
                                          "Female",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "OpenSans",
                                              color: gender == "female"
                                                  ? AppColors.primary
                                                  : Colors.grey),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          vertical(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: textArea1(referral_codeController,
                                "Referral Code (optional)"),
                          ),
                          vertical(20),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 80),
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
                              bool emailaddress = RegExp( r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(_emailcontroller2.text);
                              String patttern1 = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                              RegExp regExp1 = new RegExp(patttern1);
                              String patttern = r'^[a-z A-Z,.\-]+$';
                              RegExp regExp = new RegExp(patttern);
                              final signature =
                              await SmsAutoFill().getAppSignature;

                              if (_firstcontroller.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Enter Full Name!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                             } else if (!regExp.hasMatch(_firstcontroller.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please Enter valid Name!"),
                                      duration: const Duration(seconds: 2),
                                    ));


                              } else if (_emailcontroller2.text.isNotEmpty && emailaddress == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Enter Valid Email!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                              } else if(_phonenumbercontroller.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Enter Mobile Number!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }else if(_phonenumbercontroller.text.length != 10){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Enter Valid Mobile Number!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }else if(_phonenumbercontroller.text.length < 10){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Enter Valid Mobile Number!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              else if (gender == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please Select Gender "),
                                      duration: const Duration(seconds: 2),
                                    ));
                              }

                              else {
                                getData(
                                    _emailcontroller2.text,
                                    _phonenumbercontroller.text.toString(),
                                    _firstcontroller.text.toString(),
                                    gender,
                                    referral_codeController.text.toString(),
                                    _selectedItem.toString(),
                                    widget.organizationId!.toString());
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white),
                            )),
                      ),
                    ),


                  ],
                ),
              )),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.lightblue,
              border: Border.all(color: AppColors.primary),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: boldtext(AppColors.primary, 14, 'Back to Login'))
              ],
            ),
          )),
    );
  }



  Future<bool?> getData(
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
        "contact_number": countryCode + number,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterAccountConformScreen(
                firstname,
                email,
                "+91$number".toString(),
                type,
                referalcode,
                gender,
                organizationid),
          ),
        );

      } else if (response.statusCode == 400) {
        if (map['status'] == true) {
          //showInSnackBar("Already Register", color: Colors.red);
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
