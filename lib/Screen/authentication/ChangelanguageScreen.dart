import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/Screen/HomeScreen/homeview.dart';
import 'package:businessgym/Screen/authentication/walkthrough_one.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';

import 'package:businessgym/model/LanguageModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_translator/google_translator.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguagesState();
}

class _ChangeLanguagesState extends State<ChangeLanguageScreen> {
  List<LanguageModel>? list;
  Locale sharedLocale = const Locale('en', 'gu');
  int? selectedIndex;
  final String apiKey = 'AIzaSyBLlDB37YPbULTRu7ms76TvaqthIlvYj54'; // Replace with your API key
  final String apiUrl = 'https://translation.googleapis.com/language/translate/v2';

  String sourceText = 'Hello';
  String translatedText = '';
  String sourceLanguage = 'en';
  String targetLanguage = 'es';
  String _translatedText = '';
  @override
  void initState() {
    list = LanguageModel.languageList;

    super.initState();
  }

  Future<void> translate(String text) async {
    final String url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': text,
        'target': 'gu',
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final translatedText = jsonResponse['data']['translations'][0]['translatedText'];
      setState(() {
        _translatedText  = translatedText;
        Global.wholehint=translatedText;
      });

      print(_translatedText);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>walkthrough_one()));
    } else {
      throw Exception('Failed to load translation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      // appBar:  AppBar(
      //   elevation:  0,
      //   automaticallyImplyLeading: false,
      //
      //   leading:
      //   IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed:
      //         () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: AppColors.white,
      //   title: boldtext(AppColors.black, 16, "Languages"),
      //   actions: [
      //
      //     Center(
      //
      //         child:   Padding(
      //             padding: EdgeInsets.only(right: 20),
      //             child: GestureDetector(
      //               onTap: (){
      //                 translate();
      //                 // setSelectedLanguage();
      //               },
      //               child: boldtext(AppColors.primary, 12, "Save"),
      //             )
      //         )
      //     )
      //   ],
      //   centerTitle: true,
      //
      // ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Center(child: Image.asset(AppImages.changelanguage,width: MediaQuery.of(context).size.width/2,),),

              SizedBox(height: 20,),
               Center(
                 child: Text("Select preferred language",style: TextStyle(fontFamily: "OpenSans",fontSize: 16,fontWeight: FontWeight.w600),).translate(),
               ),
              SizedBox(height: 10,),
            Center(
              child: Text(" पसंदीदा भाषा चुनें ",style: TextStyle(fontFamily: "OpenSans",fontSize: 16,fontWeight: FontWeight.w600),).translate(),
            ),

              SizedBox(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: LanguageModel.languageList.length,
                      itemBuilder: (context,index){
                        return Container(
                            margin:EdgeInsets.only(left: 16,right: 16,top: 10),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                    Locale locale = await setLocale(
                                        LanguageModel.languageList[index].languageCode);
                                    // ignore: use_build_context_synchronously
                                    MyApp.setLocale(
                                      context,
                                      locale,
                                    );
                                    setState(() {});
                                  },

                                  child: Container(

                                    padding:EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),


                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height:30,
                                            width:30,
                                            decoration:BoxDecoration(
                                                color: Color(0xffF1FAFF),
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Center(
                                              child: Text(LanguageModel.languageList[index].languageletter,style: TextStyle(
                                                  fontSize: 19,color: AppColors.primary,fontFamily: "OpenSans",fontWeight: FontWeight.w600
                                              ),),
                                            )
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(child: changeapp(Colors.black,14,LanguageModel.languageList[index].name,)),
                                        selectedIndex==index?GestureDetector(
                                          // onTap: () => _viewdialog(context,prodcutdata[position].subMenu[index]),
                                          child: SvgPicture.asset(AppImages.verify),
                                        ):SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        );
                      })
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
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
                translate(LanguageModel.languageList[0].name);
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ).translate()),
        ),
      ),
    );
  }
}
