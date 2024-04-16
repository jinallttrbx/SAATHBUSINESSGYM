import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/workprofileController.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/conts/selectloaction.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../Utils/ApiUrl.dart';
import '../../../../Utils/SharedPreferences.dart';
import '../../../../Utils/common_route.dart';
import '../../../../model/ViewoccuaptionsModel.dart';
import '../../../../model/viewWork_profileModel.dart';
import '../../../../values/Colors.dart';
import '../../../../values/const_text.dart';
import '../../../../values/spacer.dart';

class AddEditBusinessProfileScreen extends StatefulWidget {
  final bool isEdit;
  final ViewWorkProfileModelClass? workProfile;

  const AddEditBusinessProfileScreen(
      {super.key, required this.isEdit, this.workProfile});

  @override
  AddEditBusinessProfileScreenState createState() =>
      AddEditBusinessProfileScreenState();
}
class AddEditBusinessProfileScreenState
    extends State<AddEditBusinessProfileScreen> {
  final profile = Get.find<ProfileController>();
  final workController = Get.find<WorkProfileController>();
  var controller = Get.put(addressController());
  String dropdownvalue1 = '10:00 AM';
  String dropdownvalue2 = '9:00 PM';
  var items1 = [
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '1:00 AM',
    '2:00 AM',
    '3:00 AM',
    '4:00 AM',
    '5:00 AM',
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM'
  ];
  var items2 = [
    '9:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM'
  ];

  SharedPreference sharedPreference = SharedPreference();

  final workcontroller = Get.find<WorkProfileController>();

  addBusinnessdata() async {
    final userId = await sharedPreference.isUsetId();
    final usertoken = await sharedPreference.isToken();
    var mobile = await sharedPreference.isMobile();
    String url = ApiUrl.addbusinessWorkURL;
    var header = {"Authorization": USERTOKKEN.toString()};

    var request = http.MultipartRequest("POST", Uri.parse(url));
    showLoader(context);
    try {
      if (widget.isEdit) {
        request.fields["id"] = widget.workProfile!.workProfileId.toString();
      }
      request.fields["occupation_id"] = occupation!.id.toString();
      request.fields["name"] = nameOfBusineesController.text;
      request.fields["email"] = '';
      request.fields["mode_of_business"] = modelOfBusiness ?? '';
      request.fields["business_address"] = businessAddressController.text;
      request.fields["mobile"] = mobile;
      request.fields["travel_charge"] = '50';
      request.fields["gst_number"] = gstNumberController.text;
      request.fields["fssai_number"] = licenseController.text;
      request.fields["latitude"] = latlng?.latitude.toString() ?? '0.0';
      request.fields["longitude"] = latlng?.longitude.toString() ?? '0.0';
      request.fields["location"] = locationController.text;
      request.fields["open_at"] = openTime ?? '';
      request.fields["close_at"] = closeTime ?? '';
      request.headers.addAll(header);
      print(request.fields);
      final response = await request
          .send()
          .then((value) async {
        await workcontroller.viewworkProfile();
        widget.isEdit==false ? await Methods1.orderSuccessAlert(context, "Work Profile Added Successfully"):await Methods1.orderSuccessAlert(context, "Work Profile Updated Successfully");
      });
      hideLoader();
      Navigator.of(context).pop();
    } catch (e) {
      hideLoader();
      print(e.toString());
      return d.Response(requestOptions: RequestOptions(path: url));
    }
  }

  ViewoccuaptionsModelData? occupation;
  String? modelOfBusiness;

  String? openTime = '10:00 AM';
  String? closeTime = '9:00 PM';
  LatLng latlng = const LatLng(0.0, 0.0);
  String gstnumber = "";
  String fassinumber = "";
  final nameOfBusineesController = TextEditingController();
  final businessAddressController = TextEditingController();
  final locationController = TextEditingController();
  final gstNumberController = TextEditingController();
  final licenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.onInit();
    if (widget.isEdit) {
      occupation = profile.listData1
          .firstWhere((element) => element.id == widget.workProfile?.typeId);
      nameOfBusineesController.text = widget.workProfile?.workProfileName ?? "";
      modelOfBusiness = widget.workProfile?.modeOfBusiness ?? "";
      openTime = widget.workProfile?.openAt ?? "";
      closeTime = widget.workProfile?.closeAt ?? "";
      businessAddressController.text =
          widget.workProfile?.businessAddress ?? '';
      locationController.text = widget.workProfile?.location ?? "";
      gstNumberController.text = widget.workProfile?.gstNumber ?? "";
      licenseController.text = widget.workProfile?.fssaiNumber ?? '';
      setState(() {});
    }
  }

  final profilecontroller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),

        backgroundColor: Colors.white,

        title: boldtext(Colors.black, 20,
            widget.isEdit ? "Edit Work Profile" : "Add Work Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      regulartext(AppColors.primary, 16, "Business Details"),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          children: [
                            DropdownButtonFormField<ViewoccuaptionsModelData>(
                              hint: regulartext(
                                  AppColors.hint, 14, "Select occupation"),
                              value: occupation,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.hint, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.hint, width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              isExpanded: true,
                              isDense: false,
                              items: profile.listData1.map((countries) {
                                return DropdownMenuItem<
                                    ViewoccuaptionsModelData>(
                                  value: countries,
                                  child: boldtext(
                                      AppColors.black, 14, countries.title),
                                );
                              }).toList(),
                              onChanged: (val) {
                                occupation = val;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        controller: nameOfBusineesController,
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
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
                          filled: true,
                          border: InputBorder.none,
                          fillColor: AppColors.textfieldcolor,
                          hintText: "Name of Business",
                          hintStyle: const TextStyle(
                            color: AppColors.hint,
                            fontSize: 14,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 0, right: 0),
                        child: DropdownButtonFormField(
                          value: modelOfBusiness,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xffA6A6A6), width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.hint, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              // vertical: 10,
                              horizontal: 10,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          dropdownColor: Colors.white,
                          hint: regulartext(
                              AppColors.hint, 14, "Model of Business"),
                          onChanged: (String? newValue) {
                            modelOfBusiness = newValue;
                            setState(() {});
                          },
                          items: <String>[
                            'Mobile',
                            'Fixed',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      boldtext(
                        AppColors.black,
                        14,
                        "Working hour",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regulartext(
                                  AppColors.black,
                                  14,
                                  "Open at",
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.80),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      elevation: 0,
                                      value: openTime,
                                      icon:
                                      const Icon(Icons.keyboard_arrow_down),
                                      items: items1.map((String items) {
                                        return DropdownMenuItem(
                                            value: items, child: Text(items));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          openTime = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizental(10),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  regulartext(
                                    AppColors.black,
                                    14,
                                    "Close at",
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                    const EdgeInsets.only(left: 17, right: 17),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        elevation: 0,
                                        value: closeTime,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: items2.map((String items) {
                                          return DropdownMenuItem(
                                              value: items, child: Text(items));
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            closeTime = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        controller: businessAddressController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                          filled: true,
                          border: InputBorder.none,
                          fillColor: AppColors.textfieldcolor,
                          hintText: "Address",
                          hintStyle: const TextStyle(
                            color: AppColors.hint,
                            fontSize: 14,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomSelectMapfrom(
                        controller: locationController,
                        onLocationChange: (value) {
                          latlng = value;
                          setState(() {});
                          print("rs   ${latlng.latitude}");

                        },
                      ),
                      vertical(5),
                      // ShowAddress(),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        // margin: const EdgeInsets.only(left: 17, right: 17),
                        decoration: const BoxDecoration(
                            color: AppColors.textfieldcolor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        child: TextFormField(
                          controller: gstNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9]")),
                          ],
                          keyboardType: TextInputType.text, maxLength: 15,
                          textCapitalization: TextCapitalization.characters,
                          // textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            fillColor: AppColors.green,
                            hintText: 'GST no.',
                            hintStyle: const TextStyle(
                              color: AppColors.hint,
                              fontSize: 14,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                            ),
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
                              gstnumber = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        // margin: const EdgeInsets.only(left: 17, right: 17),
                        decoration: const BoxDecoration(
                            color: AppColors.textfieldcolor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        child: TextFormField(
                          controller: licenseController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9]")),
                          ],
                          keyboardType: TextInputType.text, maxLength: 14,
                          textCapitalization: TextCapitalization.characters,
                          // textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            fillColor: AppColors.green,
                            hintText: 'Vendors License No.',
                            hintStyle: const TextStyle(
                              color: AppColors.hint,
                              fontSize: 14,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                            ),
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
                              fassinumber = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              backgroundColor: AppColors.primary),
                          onPressed: () {
                            String patttern =
                                r"^\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}$";
                            RegExp regExp = new RegExp(patttern);
                            if (occupation == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                      Text('Please Select Occupation')));
                            } else if (nameOfBusineesController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                      Text('Please Enter Business Name')));
                            } else if (modelOfBusiness == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please Select Model Of Business')));
                            } else if (businessAddressController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please Enter Your Business Address'),
                                ),
                              );
                            } else if (locationController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please Enter Location'),
                                ),
                              );
                            } else if (gstNumberController.text.isNotEmpty &&
                                gstNumberController.text.length != 15) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Please Enter Valid GST Number!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (gstNumberController.text.isNotEmpty &&
                                gstNumberController.text.length < 15) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Please Enter Valid GST Number!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (gstNumberController.text.isNotEmpty &&
                                !regExp.hasMatch(gstNumberController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Please Enter Valid  GST Number!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (licenseController.text.isNotEmpty &&
                                licenseController.text.length != 14) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please Enter Valid Vendors License Number!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (licenseController.text.isNotEmpty &&
                                licenseController.text.length < 14) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please Enter Valid Vendors License Number!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              addBusinnessdata();
                            }
                          },
                          child: boldtext(
                            Colors.white,
                            16,
                            "Save",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
