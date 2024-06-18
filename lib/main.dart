// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/Screen/authentication/walkthrough_one.dart';
import 'package:businessgym/conts/global_values.dart';

import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/translator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'Utils/SharedPreferences.dart';
import 'values/Colors.dart';
import 'package:google_translator/google_translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newlocale) {
    print(newlocale);
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newlocale);
  }
}

class _MyAppState extends State<MyApp> {
 // final apiKey = 'AIzaSyBLlDB37YPbULTRu7ms76TvaqthIlvYj54';

   final apiKey = Global.Google_Api_Key;

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    getLocale().then((locale) => setLocale(locale));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit(
      apiKey,
      translateFrom: const Locale('en'),
      translateTo: _locale ?? const Locale('gu'),
      builder: () => GetMaterialApp(
        title: 'Business Gym',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(addressController());
  final trans = Get.put(TranslationController());
  SharedPreference sharedPreference = SharedPreference();

  @override
  void initState() {
    super.initState();
    trans.onInit();
   // getNotification();
    Timer(const Duration(seconds: 5), () => getScreen());
  }

  // getNotification() {
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       RemoteNotification? notification = message.notification;
  //       AndroidNotification? android = message.notification?.android;
  //       if (notification != null && android != null) {
  //         //dailog logic
  //         print(notification);
  //       }
  //     }
  //   });
  // }

  getScreen() async {

    String? login = await sharedPreference.isLoggedIn();
    if (login == "true") {
      controller.onInit();
      print("Location data");
      print(controller.lat.value);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => walkthrough_one()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    AppImages.APP_TEXTLOGO,
                    height: 120,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.APP_SMALLTLOGO,
                          height: 200,
                        ),
                        Column(
                          children: [
                            boldtext(AppColors.DarkBlue, 14, "Supported by"),
                            boldtext(AppColors.DarkBlue, 18, "Saath Janvikas"),
                            boldtext(
                                AppColors.DarkBlue, 18, "Multipurpose Cooperative")
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
