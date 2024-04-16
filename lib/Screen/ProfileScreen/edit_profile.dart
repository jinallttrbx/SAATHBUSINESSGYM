// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/model/WorkProfileList.dart';
import 'package:dio/dio.dart' as d;
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/SharedPreferences.dart';
import '../../model/ViewoccuaptionsModel.dart';
import 'profile.dart';
import '../../values/Colors.dart';
import '../../values/assets.dart';
import '../../values/const_text.dart';

import 'package:http/http.dart' as http;

class EditUserProfileScreen extends StatefulWidget {
  String fname;
  String mobile;
  String gender;
  String email;
  String image;
   EditUserProfileScreen({super.key, required this.fname,required this.mobile,required this.gender,required this.image,required this.email});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final profile = Get.find<UserProfileController>();
  final nameController = TextEditingController();
  final emailController=TextEditingController();
  final phoneController = TextEditingController();
  WorkProfileModeldata? occupation;
  File? _image;
  String? imageUrl;
  String gender = '';
  SharedPreference sharedPreference = SharedPreference();

  @override
  void initState() {

    imageUrl = widget.image;
    nameController.text = widget.fname;
    emailController.text=widget.email;
    phoneController.text = widget.mobile;
    gender=widget.gender;
    print(widget.fname);
    print(widget.gender);
    setState(() {});
    super.initState();
  }

  updateProfile() async {
    final userId = await sharedPreference.isUsetId();
    final userToken = await sharedPreference.isToken();
    var uri = Uri.parse(ApiUrl.updateProfile);
    final request = http.MultipartRequest("POST", uri);
    request.headers
        .addAll({"Authorization": userToken, "Accept": "application/json"});
    request.fields['username'] = nameController.text;
    request.fields['email']=emailController.text;
    request.fields['uid'] = userId;
    request.fields['gender'] = gender;
    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', _image!.path),
      );
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      print("UPDATE PROFILE RESPONSE OF API ${response.request}");
      await Methods1.orderSuccessAlert(context, " Profile Updated Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fail to update'),
        ),
      );
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker picker = ImagePicker();

  _imgFromCamera() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

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
        title: boldtext(AppColors.DarkBlue, 18, "Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: _image != null
                  ? CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 60,
                      backgroundImage: FileImage(
                        _image!,
                      ))
                  : CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 60,
                      backgroundImage: NetworkImage(
                        profile.productprofilelist?.profileImage ?? '',
                      ),
                    ),
            ),
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                height: 32,
                width: 140,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(17))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.upload,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    regulartext(
                      AppColors.black,
                      14,
                      "Upload Image",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldtext(AppColors.primary, 16, "Personal Details"),
                  const Divider(color: Colors.grey, thickness: 1),
                  vertical(5),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                    ],
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.25),
                      ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: AppColors.textfieldcolor,
                      hintText: "Enter Your Name",
                    ),
                  ),
                  vertical(10),
                  TextFormField(
                    controller: phoneController,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.25),
                      ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: AppColors.textfieldcolor,
                      hintText: "Enter Mobile NUmber",
                    ),
                  ),
                  vertical(10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                        const BorderSide(color: Colors.white, width: 0.25),
                      ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: AppColors.textfieldcolor,
                      hintText: "Enter Your email",
                    ),
                  ),
                  vertical(10),
                  const SizedBox(height: 15),
                  boldtext(
                    AppColors.black,
                    14,
                    "Gender",
                  ),
                  Row(
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
                                        color:  gender == "male"
                                            ? AppColors.primary
                                            : Colors.white),
                                    color:  gender == "male"
                                        ? const Color(0xffF1FAFF)
                                        : Colors.grey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                                child: SvgPicture.asset(
                                  AppImages.male,
                                  height: 14,
                                ),
                              ),
                              regulartext(
                                gender == "male"
                                    ? AppColors.primary
                                    : Colors.grey,
                                12,
                                "Male",
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
                                      color:  gender == "female"
                                          ? AppColors.primary
                                          : Colors.white),
                                  color:  gender == "female"
                                      ? const Color(0xffF1FAFF)
                                      : Colors.grey.shade100,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                              child: SvgPicture.asset(
                                AppImages.female,
                                height: 14,
                              ),
                            ),
                            regulartext(
                              gender == "female"
                                  ? AppColors.primary
                                  : Colors.grey,
                              12,
                              "Female",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 15),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child:ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                backgroundColor: AppColors.primary),
            onPressed: () {
              bool emailaddress = RegExp( r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(emailController.text);

              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter your name'),
                  ),
                );
              } else if (emailController.text.isNotEmpty && emailaddress == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Enter Valid Email!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                updateProfile();
              }
            },
            child: regulartext(
              Colors.white,
              18,
              "Save",
            ),
          ),
        ),
      )

    );
  }
}
