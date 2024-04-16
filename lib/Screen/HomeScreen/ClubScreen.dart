import 'package:businessgym/Screen/HomeScreen/MyGroupNewScreen.dart';
import 'package:businessgym/Screen/HomeScreen/JoinScreen.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../values/Colors.dart';
import '../../../values/const_text.dart';
import '../../../values/translator.dart';



class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  ClubScreenState createState() => ClubScreenState();
}

class ClubScreenState extends State<ClubScreen> {
  final trans = Get.find<TranslationController>();
  final _controller = PageController();
  int selected = 1;
  List<Widget> switcher = [
    MyGroupNewScreen(),
    const JoinScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: APPBar(title: ""),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 45,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        margin: EdgeInsets.only(
                            left: selected == 2 ? Get.width * 0.5 : 0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 45,

                        duration: const Duration(seconds: 1),
                        child: const SizedBox(),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _controller.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                              setState(() {
                                selected = 1;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.5,
                              height: 45,
                              decoration:  BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: selected==1?AppColors.primary:AppColors.white),
                                      right: BorderSide(
                                          width: 2, color: selected==1?AppColors.white:AppColors.white))),
                              child: Center(
                                  child:
                                  boldtext(selected==1?AppColors.primary:AppColors.DarkBlue, 16, 'My Group')),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _controller.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                              setState(() {
                                selected = 2;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.5,
                              height: 45,
                              decoration:  BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: selected==1?AppColors.white:AppColors.primary),
                                      right: BorderSide(
                                          width: 2, color: selected==1?AppColors.white:AppColors.primary))),
                              child: Center(
                                  child: boldtext(
                                      selected==2?AppColors.primary:AppColors.DarkBlue, 16, 'Explore')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 140,
                    child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: switcher,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }


}
