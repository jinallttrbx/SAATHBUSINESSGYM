import 'package:businessgym/Screen/FeedScreen/NewsScreen.dart';
import 'package:businessgym/Screen/FeedScreen/PollScreen.dart';
import 'package:businessgym/Screen/FeedScreen/QuizScreen.dart';
import 'package:businessgym/Screen/FeedScreen/feedmain.dart';
import 'package:businessgym/Screen/FeedScreen/videoscreen.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/model/ViewNewsModel.dart';
import 'package:businessgym/model/ViewpollsModel.dart';
import 'package:businessgym/model/ViewquizModel.dart';
import 'package:businessgym/model/all_videos_model.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String selectedTop = "All";
  List<AllVideosModal> searchlist = [];
  final SharedPreference _sharedPreference = SharedPreference();
  List<ViewNewsModelData?>? viewnewsmodelData = [];
  List<ViewpollsModelData>? viewpollsModelData = [];
  List<ViewquizModelData>? viewquizModelData = [];
  List sendOption = ["A", "B", "C", "D", "E", "F", "G"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  // textAreasearchfield(search, "Search"),
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: topNavView("All", () {
                              setState(() {
                                selectedTop = "All";
                              });
                            }, selectedTop == "All" ? true : false),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Videos", () {
                              setState(() {
                                selectedTop = "Videos";
                              });
                            }, selectedTop == "Videos" ? true : false),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("News", () {
                              setState(() {
                                selectedTop = "News";
                              });
                            }, selectedTop == "News" ? true : false),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Poll", () {
                              setState(() {
                                selectedTop = "Poll";
                              });
                            }, selectedTop == "Poll" ? true : false),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: topNavView("Quiz", () {
                              setState(() {
                                selectedTop = "Quiz";
                              });
                            }, selectedTop == "Quiz" ? true : false),
                          )

                          // topNavView("All", () {
                          //   setState(() {
                          //     selectedTop = "All";
                          //   });
                          // }, selectedTop == "All" ? true : false),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(top: 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 300),
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "All") FeedmainScreen(),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Videos") videoScreen(),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "News") NewsScreen(),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Poll") const PollScreen(),
                              for (int index = 0; index < 1; index++)
                                if (selectedTop == "Quiz") const QuizScreen()
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

final SharedPreference _sharedPreference = SharedPreference();

Widget textAreasearchfield(TextEditingController controller, String hint,
    void Function(String)? onChanged,
    {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: TextField(
          onTap: () async {
            String becomeSuplier = await _sharedPreference.isLoggedIn();
            // Get.to(MyServicesScreensProvider(becomeSuplier));
          },
          minLines: hint.contains("Description") ? 5 : 1,
          maxLines: hint.contains("Description") ? 5 : 1,
          controller: controller,
          keyboardType: TextInputType.text,
          onChanged: onChanged,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(AppImages.search,height: 5,width: 5,),
              ),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white, width: 0.25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.grey, width: 0.25),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: AppColors.white,
              hintText: hint),
        ),
      ),
    ],
  );
}

Widget topNavView(String title, VoidCallback ontap, bool view) {
  return InkWell(
    onTap: ontap,
    child: Container(
        width: 50,
        height: 30,
        padding: const EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 5),
        decoration: BoxDecoration(
          color: view ? AppColors.primary : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: view ? Colors.blue : Colors.transparent, width: 1),
        ),
        child: Center(
          child: regulartext(view ? Colors.white : Colors.black, 14, title),
        )),
  );
}
