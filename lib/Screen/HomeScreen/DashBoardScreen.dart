

import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Controller/productController.dart';
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/serviceController.dart';
import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/Screen/CRM%20Screens/crm_screen.dart';
import 'package:businessgym/Screen/FeedScreen/Video_screen.dart';
import 'package:businessgym/Controller/workprofileController.dart';
import 'package:businessgym/Screen/ProfileScreen/profile.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'homeview.dart';
import '../../Utils/SharedPreferences.dart';
import '../../values/Colors.dart';
import '../../values/const_text.dart';

import '../../conts/global_values.dart';




class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {

  final work = Get.put(WorkProfileController());
  final service = Get.put(ServiceController());
  final productcontroller = Get.put(ProductController());
  final profile = Get.put(ProfileController());
  final userprofile = Get.put(UserProfileController());
  var controlleradd = Get.put(addressController());
  int _selectedIndex = 0;
  final SharedPreference _sharedPreference = SharedPreference();
  String usertype = '';
  bool logintypeuser = false;
  bool logintypeprovider = false;
  static final List<Widget> _widgetOptions = <Widget>[
     HomeView(),
   FeedScreen(),
    CRMScreen(),
    ProfileScreen(),
  ];
  static final List<Widget> _widgetOptions1 = <Widget>[
     HomeView(),
    FeedScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    getuserType();
    profile.onInit();
    work.viewworkProfile();
    service.viewsericeprofile();
    userprofile.viewprofile();
    productcontroller.viewproductprofile();

  }

  void getuserType() async {
    controlleradd.onInit();
    usertype = await _sharedPreference.isUserType();
    USERTOKKEN = await _sharedPreference.isToken();
    setState(() {});
    if (usertype.endsWith("provider")) {
      setState(() {
        logintypeuser = false;
        logintypeprovider = true;
      });
    } else {
      setState(() {
        logintypeuser = true;
        logintypeprovider = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            title: boldtext(
              AppColors.DarkBlue,
              18,
              'Exit App',
            ),
            content: regulartext(
              AppColors.DarkBlue,
              14,
              'Do you want to exit App?',
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Card(
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.topLeft,
                    child: const Center(child: Text("No")),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Card(
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.topLeft,
                    child: const Center(child: Text("Yes")),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(USER_TYPE);
    }
    return WillPopScope(
      onWillPop: () {
        if (kDebugMode) {
          print(
              "-----------------------inside on will pop-------------------------------");
        }
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return Future.value(false);
        } else {
          return showExitPopup();
        }
      },
      child: Scaffold(
        backgroundColor:
            _selectedIndex == 1 ? AppColors.white : AppColors.white,
        body: bodyContent,
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          child: BottomNavigationBar(
              unselectedFontSize: 10,
              selectedFontSize: 10,
              unselectedLabelStyle: const TextStyle(
                  color: Color(
                    0xffA6A6A6,
                  ),
                  fontFamily: "OpenSans"),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.black54,
              backgroundColor: AppColors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppImages.home,
                    height: _selectedIndex == 0 ? 25 : 25,
                    fit: BoxFit.fill,
                  ),
                  activeIcon: SvgPicture.asset(
                    AppImages.activehome,
                    height: _selectedIndex == 0 ? 25 : 25,
                    fit: BoxFit.fill,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppImages.infeed,
                    height: _selectedIndex == 1 ? 25 : 25,
                    fit: BoxFit.fill,
                  ),
                  activeIcon: SvgPicture.asset(
                    AppImages.activefeed,
                    height: _selectedIndex == 0 ? 25 : 25,
                    fit: BoxFit.fill,
                  ),
                  label: 'Feed',
                ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset(
                //     AppImages.marcum,
                //     height: _selectedIndex == 1 ? 25 : 25,
                //   ),
                //   label: 'Marcom',
                // ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    usertype == 'user' ? AppImages.profile : AppImages.crm,
                    height: _selectedIndex == 3 ? 25 : 25,
                  ),
                  activeIcon: SvgPicture.asset(
                    usertype == 'user' ?  AppImages.activeprofile:AppImages.activecrm,
                    height: _selectedIndex == 0 ? 25 : 25,
                    fit: BoxFit.fill,
                  ),
                  label: usertype == 'user' ? 'Profile' : ' CRM',
                ),
                if (usertype != 'user')
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      usertype == 'user'
                          ? AppImages.profile
                          : AppImages.profile,
                      height: _selectedIndex == 4 ? 25 : 25,
                    ),
                    activeIcon: SvgPicture.asset(
                      AppImages.activeprofile,
                      height: _selectedIndex == 0 ? 25 : 25,
                      fit: BoxFit.fill,
                    ),
                    label: usertype == 'user' ? 'Profile' : ' Profile',
                  ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              // selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
              elevation: 5),
        ),
      ),
    );
  }



  Widget get bodyContent {
    return Center(
      child: usertype == 'user'
          ? _widgetOptions1.elementAt(_selectedIndex)
          : _widgetOptions.elementAt(_selectedIndex),
    );
  }
}


