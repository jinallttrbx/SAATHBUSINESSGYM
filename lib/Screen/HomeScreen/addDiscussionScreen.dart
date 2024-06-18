// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:textfield_tags/textfield_tags.dart';



class AddDiscussionScreen extends StatefulWidget {
  String? group_id;
  String? group_name;


  AddDiscussionScreen({Key? key, this.group_id, this.group_name})
      : super(key: key);

  @override
  State<AddDiscussionScreen> createState() => _AddDiscussionScreenState();
}

class _AddDiscussionScreenState extends State<AddDiscussionScreen> {
  String UserId = "";
  String categotyid = "";
  String? usertoken = "";
  String? usertype = "";

  SharedPreference _sharedPreference = new SharedPreference();
  final titleController = TextEditingController();
  final typecontroller = TextEditingController();
  final descriptionController = TextEditingController();
  // final tagsController = TextEditingController();
  late double _distanceToField;
  late TextfieldTagsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    getuserType();
    _controller = TextfieldTagsController();
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    //listData1=getcategotyData();
    //getcategotyData(UserId);
  }

  Future<bool?> getcategotyData(
      String userid, String group_id, String title, String description) async {
    try {
      showLoader(context);

      // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);

      Map<String, String> requestBody = <String, String>{
        'user_id': userid,
        'group_id': group_id,
        'title': title,
        'description': description,
        'tags': _controller.getTags!.join(','),
      };

      final response = await http.post(
        Uri.parse(ApiUrl.addDiscussion),
        body: requestBody,
      );
      Map<String, dynamic> map = json.decode(response.body);

      // Map<String, dynamic> map = json.decode(response.body);

      if (response.statusCode == 200) {
        hideLoader();
        Navigator.pop(context);
        /*lon = map['lon'];
        document = map['document'];
        raiting = map['raiting'];*/

        setState(() {});

        return true;
      }
    } catch (e) {
      hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Post a Question"),

      body: SingleChildScrollView(
          child:Container(
            height: MediaQuery.of(context).size.height/1.5,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.all(20),

            child:  Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: titleController,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "reguler"),
                    //  keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      hintText: "Questions ",
                      counterText: "",
                      hintStyle: const TextStyle(color: Color(0xff808080)),
                      fillColor: AppColors.BGColor,
                      filled: true,
                      focusColor: AppColors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.white, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: descriptionController,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "reguler"),
                    //  keyboardType: TextInputType.number,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Descriptions ",
                      counterText: "",
                      hintStyle: const TextStyle(color: Color(0xff808080)),
                      fillColor: AppColors.BGColor,
                      filled: true,
                      focusColor: AppColors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.white, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldTags(
                  textfieldTagsController: _controller,
                  /*initialTags: const [
                      'pick',
                      'your',
                      'favorite',
                      'programming',
                      'language'
                    ],*/
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  /*validator: (String tag) {
                      if (tag == 'php') {
                        return 'No, please just no';
                      } else if (_controller.getTags!.contains(tag)) {
                        return 'you already entered that';
                      }
                      return null;
                    },*/
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, sc, tags, onTagDelete) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: tec,
                          focusNode: fn,
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 3.0,
                              ),
                            ),
                            //  helperText: 'Enter language...',
                            helperStyle: const TextStyle(
                              color: Color.fromARGB(255, 74, 137, 92),
                            ),
                            hintText: _controller.hasTags ? '' : "Enter tag...",
                            errorText: error,
                            prefixIconConstraints:
                            BoxConstraints(maxWidth: _distanceToField * 0.74),
                            prefixIcon: tags.isNotEmpty
                                ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {},
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            )
                                : null,
                          ),
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),


              ],
            ),
          )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if(titleController.text.isEmpty){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
              content: Text(
                  "Please Enter Question"),
            ));
          }else if(descriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
              content: Text(
                  "Please Enter Description"),
            ));
          }else if(_controller.hasTags==false){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
              content: Text(
                  "Please Enter Tag"),
            ));

          }else {
            getcategotyData(
                UserId,
                widget.group_id!,
                titleController.text.toString(),
                descriptionController.text.toString());
            // _sharedPreference.getAllPrefsClear();
            /*  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));*/
          }
        },
        child: Container(
            height: 55,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "Post",
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontFamily: "reguler"),
              ),
            )
        ),
      ),


    );

  }
}
