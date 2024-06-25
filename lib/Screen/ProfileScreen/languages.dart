import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/Screen/HomeScreen/homeview.dart';
import 'package:businessgym/conts/appbar_global.dart';

import 'package:businessgym/model/LanguageModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  List<LanguageModel>? list;
  Locale sharedLocale = const Locale('en', 'gu');
  int? selectedIndex;
  final String apiKey = 'AIzaSyAFj2efLrrgZ0wB83uV6ZVPPaf_JXpyPcE'; // Replace with your API key
  final String apiUrl = 'https://translation.googleapis.com/language/translate/v2';

  String sourceText = 'Hello';
  String translatedText = '';
  String sourceLanguage = 'en';
  String targetLanguage = 'es';
  @override
  void initState() {
    list = LanguageModel.languageList;

    super.initState();
  }

  Future<void> translate() async {
    print(targetLanguage);
    print(apiUrl);
    print(apiKey);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': sourceText,
        'target': targetLanguage,
        'source': sourceLanguage,
        'key': apiKey,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      setState(() {
        translatedText = data['data']['translations'][0]['translatedText'];
      });
    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar:  AppBar(
        elevation:  0,
        automaticallyImplyLeading: false,

        leading:
             IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed:
            () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.white,
        title: boldtext(AppColors.black, 16, "Languages"),
        actions: [

       Center(

         child:   Padding(
           padding: EdgeInsets.only(right: 20),
           child: GestureDetector(
             onTap: (){
               translate();
              // setSelectedLanguage();
             },
             child: boldtext(AppColors.primary, 12, "Save"),
           )
         )
       )
        ],
        centerTitle: true,

      ),
     
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
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 16,right: 16,bottom: 10),child:  Text("Select preferred language",style: TextStyle(fontFamily: "OpenSans",fontSize: 16,fontWeight: FontWeight.w600),),),

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
                                        Expanded(child: Text(LanguageModel.languageList[index].name,style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "OpenSans"
                                        ),),),
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
    );
  }
}
