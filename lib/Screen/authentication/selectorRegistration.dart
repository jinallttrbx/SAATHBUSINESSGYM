import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/organizationmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_translator/google_translator.dart';
import 'package:http/http.dart' as http;

import '../../values/Colors.dart';
import '../../values/assets.dart';
import '../../values/const_text.dart';
import '../../values/spacer.dart';
import 'RegisterNewAccountEmail.dart';

class SelectorRegister extends StatefulWidget {
  const SelectorRegister({super.key});

  @override
  State<SelectorRegister> createState() => _SelectorRegisterState();
}

class _SelectorRegisterState extends State<SelectorRegister> {
  String? Suppiler;
  bool btnclick = false;
  Future<List<Organizationmodeldata?>?>? bookingmodel;
  List<Organizationmodeldata>? mybookingdata = [];
  SharedPreference _sharedPreference = SharedPreference();
  String? UserId;
  Future<List<Organizationmodeldata?>?>? listData1;
  List<Organizationmodeldata>? categorydata = [];
  int? organizationId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid();
  }

  Future<void> userid() async {
    UserId = await _sharedPreference.isUsetId();
    listData1 = getpaymenttype();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        color: const Color(0xffF6F6F6),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              vertical(50),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      AppImages.backarrow,
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.APP_LOGO,
                          height: 30,
                        ),
                        Image.asset(
                          AppImages.namelogo,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              vertical(45),
               Text(
                "Select Who Are You To Get Started",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ).translate(),
              vertical(20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Expanded(child:  GestureDetector(
                     onTap: () {
                       setState(() {
                         Suppiler = "user";
                       });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         color: AppColors.white,
                         borderRadius: const BorderRadius.all(
                           Radius.circular(16),
                         ),
                         border: Suppiler == "user"
                             ? Border.all(
                           color: AppColors.lightBlue,
                           width: 3,
                         )
                             : null,
                       ),
                       padding: const EdgeInsets.all(5),
                       height: 100,
                       width: 100,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SvgPicture.asset(
                             AppImages.customer,
                             height: 35,
                             width: 35,
                           ),
                           vertical(10),
                           const Text(
                             "Customer",
                             style: TextStyle(
                                 fontSize: 12.5,
                                 fontWeight: FontWeight.w600,
                                 fontFamily: "OpenSans"),
                           ).translate(),
                         ],
                       ),
                     ),
                   ),),
        SizedBox(width: 10,),
        Expanded(child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Suppiler = "provider";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Suppiler == "provider"
                                ? Border.all(
                                    color: AppColors.lightBlue,
                                    width: 3,
                                  )
                                : null,
                            color: AppColors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        padding: const EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.microenterprinute,
                              height: 35,
                              width: 35,
                            ),
                            vertical(5),
                            const Text(
                              "Micro\nEntrepreneur",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans"),
                            ).translate(),
                          ],
                        ),
                      ),
                    ),),
                    SizedBox(width: 10,),
        Expanded(child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Suppiler = "supplier";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Suppiler == "supplier"
                                ? Border.all(
                                    color: AppColors.lightBlue,
                                    width: 3,
                                  )
                                : null,
                            color: AppColors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        padding: const EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.suppier,
                              height: 35,
                              width: 35,
                            ),
                            vertical(10),
                            const Text(
                              "Supplier",
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans"),
                            ).translate(),
                          ],
                        ),
                      ),
                    ),)
                  ],
                ),
              ),
              vertical(10),
              Suppiler == "user" ||
                      Suppiler == "provider" ||
                      Suppiler == "supplier"
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldtext(
                                Colors.black, 20, "Choose your Organization"),
                            ListView.builder(
                                itemCount: categorydata!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        organizationId = categorydata![index].id;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: organizationId ==
                                            categorydata![index].id
                                            ? AppColors.LightBlue
                                            : null,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          boldtext(Colors.black, 14,
                                              categorydata![index].name),
                                          regulartext(Colors.black, 12,
                                              categorydata![index].stateName)
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ))
                  : const SizedBox.shrink()

            ],
          ),
        ),
      ),
      bottomNavigationBar: organizationId != null
          ? Padding(
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RegisterAccountEmailScreen(Suppiler,organizationId.toString()),
                          ));
                    },
                    child: const Text(
                      'Continue',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ).translate()),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
  Future<List<Organizationmodeldata?>?> getpaymenttype() async {
    try {
      showLoader(context);
      final response = await http.get(
        Uri.parse(ApiUrl.organizationlist),
      );
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {
        hideLoader();
        OrganizationModel catrgortModel1 =
            OrganizationModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < catrgortModel1.data!.length; i++) {
          Organizationmodeldata categoryModelData = Organizationmodeldata(
            id: catrgortModel1.data![i].id,
            stateName: catrgortModel1.data![i].stateName,
            description: catrgortModel1.data![i].description,
            createdAt: catrgortModel1.data![i].createdAt,
            updatedAt: catrgortModel1.data![i].updatedAt,
            deletedAt: catrgortModel1.data![i].deletedAt,
            name: catrgortModel1.data![i].name,
            stateId: catrgortModel1.data![i].stateId,
            image: catrgortModel1.data![i].image,
          );
          categorydata!.add(categoryModelData);
        }
        setState(() {});
        return categorydata;
      } else {

      }
    } catch (e) {

    }
  }
}


