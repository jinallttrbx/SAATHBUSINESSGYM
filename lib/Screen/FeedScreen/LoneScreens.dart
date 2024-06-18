// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, file_names, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import '../../../Utils/ApiUrl.dart';

import '../../../Utils/SharedPreferences.dart';
import '../../../Utils/common_route.dart';
import '../../../model/LoanModel.dart';
import '../../../model/LoantypesModel.dart';
import '../../../values/Colors.dart';
import 'package:http/http.dart' as http;




class LoneScreens extends StatefulWidget {
  String Mfid;
   LoneScreens(this.Mfid,{super.key});

  @override
  LoneScreensState createState() => LoneScreensState();
}

class LoneScreensState extends State<LoneScreens> {
  String? UserId;
  bool visible = false;
  String? subjectId = "0";
  Future<List<LoantypesModelData>?>? listData1;
  List<LoantypesModelData>? categorydata = [];
  final SharedPreference _sharedPreference = SharedPreference();

  final myloanamountController = TextEditingController();
  final mypurposeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid();
  }

  Future<void> userid() async {
    UserId = await _sharedPreference.isUsetId();
    print("Ashish" + UserId!);
    listData1 = getcategotyData(UserId!);
  }

  Future<bool?> addLoanModeloges(String userId, String loanamount,
      String purpose, String loan_type_id) async {
    print("userId   " + userId);
    print("loanamount   " + loanamount);
    print("purpose   " + purpose);
    print("loan_type_id   " + loan_type_id);
    print("mfi_id" + widget.Mfid);


    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'provider_id': userId,
        'loan_amount': loanamount,
        'purpose': purpose,
        'loan_type_id': loan_type_id,
       // 'mfi_id':widget.Mfid.toString()
      };

      print("USerId1 == supplier_id" + userId);

      final response = await http.post(
        Uri.parse(ApiUrl.add_loan_request),
        body: requestBody,
      );
      print("LOAN RESPONCE===========> z${requestBody}");
      print("STATUS CODE===========> z${response.body}");

      Map<String, dynamic> map = json.decode(response.body);

      myloanamountController.text = "";
      mypurposeController.text = "";
      print("AshishResponce new datatat ===== ---- " +
          response.statusCode.toString());

      if (response.statusCode == 200) {
        // loadProgress();
        hideLoader();
        LoanModel? addCallModel = LoanModel.fromJson(jsonDecode(response.body));
        if(addCallModel.message=="You Have Already Applied"){
          await Methods1.orderunSuccessAlert(context, "${addCallModel.message}");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }else{
          await Methods1.orderSuccessAlert(context, "${addCallModel.message}");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }


        return true;
      } else {
        // loadProgress();
        hideLoader();

        print("Something went wronge");
        return false;
      }
    } catch (e) {
      // loadProgress();
      hideLoader();

      print("data==1=$e");
    }
  }

  Future<List<LoantypesModelData>?> getcategotyData(String userid) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        //'user_id':userid,
      };

      final response = await http.post(
        Uri.parse(ApiUrl.loantypes),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      print("AshishBody:==========" + response.body);
      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        LoantypesModel catrgortModel =
            LoantypesModel.fromJson(jsonDecode(response.body));

        for (int i = 0; i < catrgortModel.data!.length; i++) {
          LoantypesModelData categoryModelData = LoantypesModelData(
              id: catrgortModel.data![i].id,
              title: catrgortModel.data![i].title,
              status: catrgortModel.data![i].status);
          categorydata!.add(categoryModelData);
        }
        setState(() {});

        // mycategory = categorydata[0].subjectTital
        // categorydata = catrgortModel.data;

        return categorydata;
      }
      print(response.statusCode);
    } catch (e) {
      print("sdfok" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Apply For Loan"),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(left: 16),child:   regulartext(AppColors.black, 14, "Select type "),),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: FutureBuilder<List<LoantypesModelData>?>(
                    future: listData1,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: DropdownButtonFormField<LoantypesModelData?>(
                            decoration: InputDecoration(
                              filled: false,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            isExpanded: true,
                            hint: regulartext(AppColors.hint, 16, "Select Type"),
                            items: snapshot.data!.map((countries) {
                              return DropdownMenuItem<LoantypesModelData?>(
                                value: countries,
                                child: Row(
                                  children: [
                                    boldtext(
                                        AppColors.black, 14, countries.title!),
                                    const Spacer(),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              subjectId = val!.id.toString();
                              print("AshishValue===========$subjectId");

                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return const Center(
                          child: CircularProgressIndicator(
                        semanticsLabel: "Please Wait",
                      ));
                    }),
              ),
              // const SizedBox(
              //   height: 20,
              // ),

              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: myloanamountController,
                  // maxLength: 4,

                  style: const TextStyle(
                      color: Colors.black, fontFamily: "caviarbold"),

                  decoration: InputDecoration(
                    hintText: "Loan amount",
                    counterText: "",
                    hintStyle: const TextStyle(color: Color(0xff808080)),
                    fillColor: AppColors.BGColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(10),
                    focusColor: AppColors.BGColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.white, width: 1.0),
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextField(
                  //   maxLength: 4,
                  controller: mypurposeController,

                  style: const TextStyle(
                      color: Colors.black, fontFamily: "caviarbold"),

                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Purpose of loan",
                    counterText: "",
                    hintStyle: const TextStyle(color: Color(0xff808080)),
                    fillColor: AppColors.BGColor,
                    filled: true,
                    focusColor: AppColors.BGColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.white, width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)



            ],
          ),
        ),
      ),
      bottomNavigationBar:  GestureDetector(
        onTap: () {
          // loadProgress();
          if(subjectId=="0"){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please Select Loan Type!"),
            ));
          }
          if (myloanamountController.text.toString() == "") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please Enter Loan Amount!"),
            ));
            //loadProgress();
            // showInSnackBar("Please Enter Loan Amount",
            //     color: Colors.red);
          } else if (mypurposeController.text.toString() == "") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please Enter Purpose!"),
            ));
            //  loadProgress();
            //sowInSnackBar("Please Enter Purpose ", color: Colors.red);
          }
          else {
         ApplyLoan(context);

          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 0),
          // padding: const EdgeInsets.only(
          //     left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(0)),
          child:
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [

          boldtext(AppColors.primary,20,
            "Submit",

          ),

        ),
      ),
    );
  }

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  ApplyLoan(BuildContext context) async {
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
                        boldtext(AppColors.black, 18, "Apply Loan"),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child:   regulartext(
                        const Color(0xffA6A6A6),
                        14,
                        "Are you sure you want to apply loan?",
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
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () async {
                            addLoanModeloges(
                                UserId!,
                                myloanamountController.text.toString(),
                                mypurposeController.text.toString(),
                                subjectId!);
                          },
                          child:
                          boldtext(AppColors.white, 14, "Confirm apply loan"),
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
}
