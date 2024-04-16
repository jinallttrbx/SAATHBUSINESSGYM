
import 'package:businessgym/Screen/authentication/signin.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/model/LanguageModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';

class walkthrough_one  extends StatefulWidget{
  State<walkthrough_one> createState() => _walkthrough_oneState();
}

class _walkthrough_oneState extends State<walkthrough_one>{




  PageController controller=PageController();
  int? selectedIndex;
  List<LanguageModel>? list;
  List<Widget> _list=<Widget>[
    new Center(child:new Pages(image:AppImages.walkfirst,text: "Page 1",subtext:"47% Of Micro Enterprises And 53% of \n SMEs Have Adopted Digital Sales \nPlatforms In India.")),
    new Center(child:new Pages(image:AppImages.walksecond,text: "Page 2",subtext: "50% Of Micro And Small Enterprises \n Adopted Technologies Like WhatsApp\n And Video Conferencing Tools For\n Business Operations.",)),
    new Center(child:new Pages(image:AppImages.walkthree,text: "Page 3",subtext: "MSMEs Account For Around 30% Of\n GDP And Provide Employment To Over \n 110 Million People In India.",)),
  ];
  int _curr=0;
  @override
  void initState() {
    list = LanguageModel.languageList;
    setSelectedLanguage();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: PageView(
                children:
                _list,
                scrollDirection: Axis.horizontal,
                controller: controller,
                onPageChanged: (num){
                  setState(() {
                    _curr=num;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.only(left: 100),child: SizedBox(
                      width:  100,
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                        },
                        child:   Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: AppColors.lightblue,
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                            alignment: Alignment.topRight,
                            child: Center(
                              child: boldtext(AppColors.primary,14,"Skip",),
                            )
                        ),
                      )
                  ),)
                ],
              ),
            ),
            Container(
              height: 50,

              color: Colors.white,
              child: Row(
                children: [
               Image.asset(AppImages.APP_LOGO),
                  Image.asset(AppImages.namelogo),
                Expanded(child:  SizedBox(),),
                  GestureDetector(
                    onTap: (){
                      languagedialog(context);

                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.language),
                        SizedBox(width: 5,),
                        regulartext(AppColors.black,14,"Language"),
                        SizedBox(width: 5,),
                      ],
                    ),
                  )

                ],
              ),
            ),
         Container(
           alignment: Alignment.bottomCenter,
           child:    SmoothPageIndicator(
             controller: controller,
             count:  3,
             axisDirection: Axis.horizontal,
             effect:  WormEffect(
                 spacing:  8.0,
                 radius:  80.0,
                 dotWidth:  10.0,
                 dotHeight:  10.0,
                 paintStyle:  PaintingStyle.fill,
                 strokeWidth:  1.5,
                 dotColor:  Colors.grey,
                 activeDotColor:  AppColors.primary
             ),
           ),
         )


          ],
        )

      ),
        bottomNavigationBar: Container(
          color: AppColors.white,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  onPressed: (){
                    {
                      if (_curr == 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      } else {
                        _curr = _curr + 1;
                        controller.animateToPage(_curr,
                            curve: Curves.decelerate,
                            duration: Duration(milliseconds: 300));
                      }
                    }


                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  )),
            ),
          ),
        )
    );
  }
  languagedialog (BuildContext context) async {
    return showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: EdgeInsets.only(left: 10,right: 10),
            iconPadding:EdgeInsets.zero,
            content: Container(

                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.close_rounded)
                      ],
                    ),
                  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(subMenu.image),
                          SizedBox(width: 10,),
                          boldtext(AppColors.black,18,"Choose Language",),
                        ],
                      ),
                      ListView.builder(
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
                                        setState(() {

                                        });
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
                    ],
                  ),
                )
            ),

          );
        });
  }

  setSelectedLanguage() async {
    await getLocale().then((value) {
      if (value != null) {
        selectedIndex = LanguageModel.languageList.indexWhere(
                (element) => element.languageCode == value.languageCode);
        setState(() {});
      } else {
        selectedIndex = 0;
        setState(() {});
      }
    });
  }



}
class Pages extends StatelessWidget {
  final text;
  final subtext;
  final image;
  Pages({this.text, required this.subtext,required this.image});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(

          children:<Widget>[
            Container(
              height:  MediaQuery.of(context).size.height,
              decoration:  BoxDecoration (
                color:  Color(0xffffffff),
              ),
              child:
              Stack(
                children:  [

                  Positioned(
                    left:  0,
                    child:
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:  MediaQuery.of(context).size.height,
                      child:
                      Stack(
                        children:  [

                          Positioned(
                            left:  0,
                            top:  0,
                            child:
                            Align(
                              child:
                              SizedBox(
                                width:  MediaQuery.of(context).size.width,
                                child:
                                Image.asset(
                                  image,
                                  fit:  BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left:  0,
                            top: MediaQuery.of(context).size.height/1.5,
                            child:
                            Align(
                              child:
                              SizedBox(
                                width:  MediaQuery.of(context).size.width,
                                height:  200,
                                child:
                                Container(
                                    decoration:  BoxDecoration (
                                      gradient:  LinearGradient (
                                        begin:  Alignment(0, -1),
                                        end:  Alignment(0, 1),
                                        colors:  <Color>[Color(0x00ffffff), Color(0x7fffffff), Color(0xffffffff)],
                                        stops:  <double>[0, 0.072, 0.339],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        subtext,
                                        textAlign:  TextAlign.center,
                                        style:  TextStyle (
                                          letterSpacing: 1,
                                          fontFamily: 'OpenSans',
                                          fontSize:  14,
                                          fontWeight:  FontWeight.w600,
                                          height: 1.5,
                                          color:  AppColors.black,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),

          ]
      ),
    );
  }
}
