import 'dart:async';
import 'dart:convert';
import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Controller/productController.dart';
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/serviceController.dart';
import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/Screen/HomeScreen/MyGroupScreen.dart';
import 'package:businessgym/Screen/HomeScreen/recommanded_Product_screen.dart';
import 'package:businessgym/Screen/HomeScreen/recommanded_Service_screen.dart';
import 'package:businessgym/Screen/HomeScreen/AdverTiseMentScreen.dart';
import 'package:businessgym/Screen/FeedScreen/MfiScreen.dart';
import 'package:businessgym/Screen/authentication/NotificationScreen.dart';
import 'package:businessgym/Screen/ProfileScreen/MyEntitlementsScreen.dart';
import 'package:businessgym/Screen/HomeScreen/FinancePageScreen.dart';
import 'package:businessgym/Screen/HomeScreen/MyServicesScreensProvider.dart';
import 'package:businessgym/Screen/extra.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Screen/HomeScreen/ClubScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/Screen/HomeScreen/loandetailScreen.dart';
import 'package:businessgym/conts/to_map_scree.dart';
import 'package:businessgym/model/AllViewTransectionModel.dart';
import 'package:businessgym/model/GetGroupsModel.dart';
import 'package:businessgym/model/GetHomeModel.dart';
import 'package:businessgym/model/LoanListModel.dart';
import 'package:businessgym/model/ViewAdvertismentModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/model/notification_response_model.dart';
import 'package:businessgym/Screen/ProfileScreen/profile.dart';
import 'package:businessgym/Screen/HomeScreen/serviceprovider_screen.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController search = TextEditingController();
  String usertype = '';
  String username = '';
  var controlleradd = Get.put(addressController());
  int currentIndex = 0;
  int _currentIndex = 0;
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  String? totalcashin;
  String? totalcashout;
  List<TransectionData?>? transactionData = [];
  String? userid;
  String? cdate;
  final profilecontroller = Get.find<ProfileController>();
  final userprofile=Get.find<UserProfileController>();
  final productcontroller=Get.find<ProductController>();
  final servicecontroller=Get.find<ServiceController>();
  Future<List<TransectionData>?>? alltransactionmodel;
  Future<LoanListModel?>? providerdatalist;
  List<LoanListModelData>? productsellerdata = [];
  LoanListModel? addCallModel;
  bool status = false;
  String waitappliy = "no";
  String loanFilter = "Approved";
  List<GetGroupsModelData>? getGroupsModeldata = [];
  Future<GetHomeModel?>? allservice1;
  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    username = await _sharedPreference.isUserName();
    allservice1 = gethomedata();
    controlleradd.onInit();
    userprofile.viewprofile();
    setState(() {});
  }

  final GlobalKey<ScaffoldState> key = GlobalKey();
  SharedPreference sharedPreference = SharedPreference();
  List<ViewAdvertismentModelData> transactionData1 = [];
  Future<List<ViewAdvertismentModelData?>?>? advertisement() async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.viewAdvertisement),
      );
      if (response.statusCode == 200) {
        ViewAdvertismentModel? myBookingModel =
            ViewAdvertismentModel.fromJson(jsonDecode(response.body));
        transactionData1 = myBookingModel.data!;
        setState(() {});
        return myBookingModel.data;
      } else {
        if (kDebugMode) {

        }
      }
    } catch (e) {
      if (kDebugMode) {

      }
    }
    return null;
  }

  Response? notificationResponse;
  NotificationResponseModel? notificationResponseModel;

  Future<void> getNotification(String userid) async {
    print("${ApiUrl.dynamicNotification + userid}");
    try {
      Map<String, String> headers = {'Authorization': USERTOKKEN.toString()};
      var url = Uri.parse(ApiUrl.dynamicNotification + userid);
      final response = await http.get(url, headers: headers);
      notificationResponseModel =
          NotificationResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (notificationResponseModel?.data?.isNotEmpty ?? false) {
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 2), () {
              notificationDialog(
                  context: context,
                  image: notificationResponseModel?.data?.last.image ?? '',
                  title: notificationResponseModel?.data?.last.title ?? '',
                  subTitle:
                      notificationResponseModel?.data?.last.description ?? '');
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
      }
    }
  }

  @override
  void initState() {
    super.initState();
    advertisement();
    getuserType();
    getuserid();
    profilecontroller.onInit();
    productcontroller.viewproductprofile();
    servicecontroller.viewsericeprofile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        backgroundColor: AppColors.BGColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 50, bottom: 16),
              color: AppColors.primary,
              child: Row(
                children: [
                  Stack(
                    children: [
                    GestureDetector(
                      onTap:(){
                        Get.to(
                              () => ProfileScreen(),
                        );

    },
                      child:   CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        NetworkImage( userprofile.productprofilelist?.profileImage??"",),
                      ),
                    ),
                      Positioned(
                          left: 40,
                          top: 40,
                          child: GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://play.google.com/store/apps/details?id=saath.com.businessgym';
                              try {
                                await Share.share(url);
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Share Error------------$e');
                                }
                              }
                              // for files share
                              // Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.primary,
                              child: SvgPicture.asset(AppImages.shareprofile),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                         Text(
                          "Welcome",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white),
                        ).translate(),
                        Text(
                          profilecontroller.firstname.value??"",
                          style: const TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white),
                        ).translate(),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  ToMapScreen(),
                          ),
                        );
                       // showmapbottomsheet(context);
                      },
                      icon: SvgPicture.asset(
                        AppImages.mappoint,
                        height: 25,
                        width: 25,
                        color: Colors.white,
                      )),
                  notificationResponseModel==null?IconButton(onPressed: (){
                    Get.to(() => NotificationScreen(
                      notificationResponseModel:
                      notificationResponseModel,
                    ));
                  }, icon: SvgPicture.asset(
                    AppImages.notification,
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  )): IconButton(
                      onPressed: () {
                        Get.to(() => NotificationScreen(
                          notificationResponseModel:
                          notificationResponseModel!,
                        ));
                        // print("NOTIFICATION DATA PRINT ${notificationResponseModel}");
                        // if (notificationResponseModel == null) {
                        //
                        // }
                      },
                      icon: Badge(
                        label: Text(
                          notificationResponseModel?.data?.length.toString() ??
                              '0',
                        ),
                        child: SvgPicture.asset(
                          AppImages.notification,
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        )
                      )),
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder<GetHomeModel?>(
                  future: allservice1,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(
                                  children: [
                                    // vertical(100),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: boldtext(AppColors.black, 20,
                                              "${snapshot.data!.profilecompleted.toString()}%",
                                              fontFamily: 'caviarbold'),
                                        ),
                                      GestureDetector(
                                        onTap: (){
                                          changeTab(3);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                                        },
                                        child:   Row(
                                          children: [
                                            boldtext(AppColors.black, 12,
                                                "Complete your profile"),
                                            SvgPicture.asset(
                                                AppImages.roundaltarroe,height: 20,)
                                          ],
                                        ),
                                      )
                                      ],
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      alignment: Alignment.center,
                                      child: LinearPercentIndicator(
                                        barRadius: const Radius.circular(30),
                                        //leaner progress bar
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 5.0,
                                        percent:
                                            (snapshot.data!.profilecompleted! /
                                                100),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: const Color(0xffF59E20),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                    textAreasearch(
                                      search,
                                      'Search Service Provider/Product Seller'
                                    ),
                                    CarouselSlider(
                                        items: transactionData1.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .only(
                                                              topRight: Radius
                                                                  .circular(16),
                                                              topLeft: Radius
                                                                  .circular(16),
                                                              bottomLeft: Radius
                                                                  .circular(16),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            height: 300,
                                                            decoration: const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(
                                                                            16),
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            16),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            16),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            16))),
                                                            child: ClipRRect(
                                                                borderRadius: const BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(
                                                                            16),
                                                                    topLeft:
                                                                        Radius.circular(16)),
                                                                child: Column(
                                                                  children: [
                                                                    Image
                                                                        .network(
                                                                      i.image!,
                                                                      height:
                                                                          250,
                                                                      width: Get
                                                                          .width,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              i.title!,
                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "OpenSans"),
                                                                            ).translate(),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) =>  AdverTiseMentScreen(i.id.toString(),i.title),
                                                                                  ));
                                                                              // getViewVideo(UserId,i.vid!.toString(),i);
                                                                              //  Navigator.push(context, MaterialPageRoute(builder: (context) =>VideosDetailsScreen(videos: i,)));
                                                                            },
                                                                            child:
                                                                                const Icon(Icons.info_outline,color: AppColors.hint,),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ))),
                                                      ],
                                                    ),
                                                  ));
                                            },
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 300,
                                          viewportFraction: 1.0,
                                          initialPage: 0,
                                          padEnds: false,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 6),
                                          // autoPlayAnimationDuration:
                                          // const Duration(milliseconds: 800),
                                          // autoPlayCurve: Curves.fastOutSlowIn,
                                         // enlargeCenterPage: true,
                                          enlargeFactor: 0.5,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                          scrollDirection: Axis.horizontal,
                                        )),
                                    SizedBox(height: 10,),
                                    DotsIndicator(
                                      dotsCount: transactionData1.isNotEmpty
                                          ? transactionData1.length
                                          : 2,
                                      position: currentIndex,
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>serviceproviderScreen("Service Provider")));
                                                // Get.to(serviceproviderScreen());
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(16))),
                                                height: 80,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width/8,
                                                      decoration:
                                                      const BoxDecoration(
                                                          color:
                                                          Color(0xffF9F9F9),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  16))),
                                                      child: Center(
                                                        child: SvgPicture.asset(
                                                            AppImages.Case),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!.serviceCount
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontSize: 14),
                                                        ).translate(),
                                                        const Text(
                                                          "Service Provider",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontSize: 12),
                                                        ).translate(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>serviceproviderScreen("Product Seller")));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(16))),
                                                height: 80,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width/8,
                                                      decoration:
                                                      const BoxDecoration(
                                                          color:
                                                          Color(0xffF9F9F9),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  16))),
                                                      child: Center(
                                                        child: SvgPicture.asset(
                                                            AppImages.shop),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!.productCount!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontSize: 14),
                                                        ).translate(),
                                                        const Text(
                                                          "Product Seller",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontSize: 12),
                                                        ).translate(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                               Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Recommended Product Seller",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontFamily: "OpenSans"),
                                                      ).translate(),
                                                      Text(
                                                        "you might be interested in",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xffA6A6A6)),
                                                      ).translate(),
                                                    ],
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      RecomandedProductScreen("product"));
                                                },
                                                child: SvgPicture.asset(
                                                  AppImages.roundaltarroe,
                                                  height: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: AppColors.primary),
                                          const SizedBox(
                                            height: 20,
                                          ),

                                          snapshot
                                              .data!.productList!.isEmpty?Text("No Data Found"): ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .data!.productList!.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return GestureDetector(
                                                onTap: (){
                                                  CommonBottomSheet.show(context,snapshot.data!.productList[i].providerId.toString(),snapshot.data!.productList[i].id.toString(),"product","");
                                                },
                                                child: Container(
                                                    margin:
                                                    const EdgeInsets.all(10),
                                                    padding:
                                                    const EdgeInsets.all(10),
                                                    decoration:
                                                    const BoxDecoration(
                                                        color:
                                                        Color(0xffF9F9F9),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius
                                                                .circular(
                                                                16))),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data!
                                                              .productList[i]
                                                              .profileImage),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data!
                                                                      .productList![i]
                                                                      .username!,
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      fontFamily:
                                                                      "OpenSans"),
                                                                ).translate(),
                                                                Row(
                                                                  children: [
                                                                    Expanded(child:  regulartext(
                                                                      AppColors.hint,
                                                                      14,
                                                                      snapshot
                                                                          .data!
                                                                          .productList![
                                                                      i]
                                                                          .name!,
                                                                    ),),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left: 15,
                                                                            right: 15,
                                                                            top: 5,
                                                                            bottom:
                                                                            5),
                                                                        decoration: BoxDecoration(
                                                                            color: snapshot.data!.productList![i].tag !=
                                                                                "Supplier Service"
                                                                                ? AppColors.primary.withOpacity(
                                                                                0.05)
                                                                                : AppColors
                                                                                .LightGreens,
                                                                            borderRadius:
                                                                            const BorderRadius.all(Radius.circular(
                                                                                9))),
                                                                        child: snapshot
                                                                            .data!
                                                                            .productList![i]
                                                                            .tag !=
                                                                            "Supplier Service"
                                                                            ? boldtext1(
                                                                          AppColors
                                                                              .Green,
                                                                          10,
                                                                          "ME",
                                                                        )
                                                                            : boldtext1(
                                                                          AppColors
                                                                              .primary,
                                                                          10,
                                                                          "Supplier",
                                                                        )),
                                                                  ],
                                                                ),
                                                                InkWell(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      RatingBarIndicator(
                                                                        direction: Axis
                                                                            .horizontal,
                                                                        rating:snapshot.data!.productList![i].averageRating.toDouble(),
                                                                        // double.parse(""),
                                                                        itemCount: 5,
                                                                        itemSize: 14,
                                                                        itemPadding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                        unratedColor:
                                                                        Colors
                                                                            .grey,
                                                                        itemBuilder: (context,
                                                                            _) =>
                                                                            SvgPicture.asset(
                                                                                AppImages
                                                                                    .rating),
                                                                      ),
                                                                      snapshot.data!.productList![i].averageRating ==
                                                                          null
                                                                          ? const SizedBox
                                                                          .shrink()
                                                                          : boldtext(
                                                                          const Color(
                                                                              0xff656565),
                                                                          12,
                                                                          '${snapshot.data!.productList![i].averageRating.toStringAsFixed(1)!} Rating')

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        SvgPicture.asset(
                                                            AppImages.altarroe)
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                               Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Recommended Service Provider",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontFamily: "OpenSans"),
                                                      ).translate(),
                                                      Text(
                                                        "you might be interested in",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xffA6A6A6)),
                                                      ).translate(),
                                                    ],
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      RecomandedServiceScreen("service"));
                                                },
                                                child: SvgPicture.asset(
                                                  AppImages.roundaltarroe,
                                                  height: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          snapshot
                                              .data!.serviceList!.isEmpty?Text("No Data Found"):     ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemCount: snapshot
                                                .data!.serviceList!.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return GestureDetector(
                                                onTap: () {
                                                  CommonBottomSheet.show(context,snapshot.data!.serviceList[i].providerId.toString(),snapshot.data!.serviceList[i].id.toString(),"service","");
                                                },
                                                child: Container(
                                                    margin:
                                                    const EdgeInsets.all(
                                                        10),
                                                    padding:
                                                    const EdgeInsets.all(
                                                        10),
                                                    decoration: const BoxDecoration(
                                                        color:
                                                        Color(0xffF9F9F9),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data!
                                                              .serviceList![
                                                          i]
                                                              .profileImage),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data!
                                                                      .serviceList![
                                                                  i]
                                                                      .username!,
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      fontFamily:
                                                                      "OpenSans"),
                                                                ).translate(),
                                                                Row(
                                                                  children: [
                                                                    Expanded(child:  regulartext(
                                                                      AppColors.hint,
                                                                      14,
                                                                      snapshot
                                                                          .data!
                                                                          .serviceList![
                                                                      i]
                                                                          .name!,
                                                                    ),),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            15,
                                                                            right:
                                                                            15,
                                                                            top: 5,
                                                                            bottom:
                                                                            5),
                                                                        decoration: BoxDecoration(
                                                                            color: snapshot.data!.serviceList![i].tag !=
                                                                                "Supplier Service"
                                                                                ? AppColors.primary.withOpacity(
                                                                                0.05)
                                                                                : AppColors
                                                                                .LightGreens,
                                                                            borderRadius:
                                                                            const BorderRadius.all(Radius.circular(
                                                                                9))),
                                                                        child: snapshot.data!.serviceList![i].tag !=
                                                                            "Supplier Service"
                                                                            ? boldtext1(
                                                                          AppColors.Green,
                                                                          8,
                                                                          "ME",
                                                                        )
                                                                            : boldtext1(
                                                                          AppColors.primary,
                                                                          8,
                                                                          "Supplier",
                                                                        )),
                                                                  ],
                                                                ),
                                                                InkWell(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      RatingBarIndicator(
                                                                        direction: Axis
                                                                            .horizontal,
                                                                        rating: snapshot.data!.serviceList![i].averageRating.toDouble(),
                                                                        // double.parse("${4}"),
                                                                        itemCount:
                                                                        5,
                                                                        itemSize:
                                                                        14,
                                                                        itemPadding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                        unratedColor:
                                                                        Colors
                                                                            .grey,
                                                                        itemBuilder: (context,
                                                                            _) =>
                                                                            SvgPicture.asset(
                                                                                AppImages.rating),
                                                                      ),
                                                                      snapshot.data!.serviceList![i].averageRating ==
                                                                          null
                                                                          ? const SizedBox
                                                                          .shrink()
                                                                          : boldtext(
                                                                          const Color(
                                                                              0xff656565),
                                                                          12,
                                                                          '${snapshot.data!.serviceList![i].averageRating!.toStringAsFixed(1)} Rating')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        SvgPicture.asset(
                                                            AppImages.altarroe)
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                           Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "My Statistics",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontFamily: "OpenSans"),
                                                      ).translate(),
                                                      Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xffA6A6A6)),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,

                                            children: [
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(AppImages.rating),
                                                        SizedBox(width: 5,),
                                                        Text(
                                                          "${snapshot.data!.avrageRating}/5",
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontFamily:
                                                              "OpenSans"),
                                                        ).translate(),
                                                      ],
                                                    ),
                                                    Padding(padding: EdgeInsets.only(left: 5),child: Text(
                                                      "Average \nRating",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontFamily:
                                                          "OpenSans",
                                                          color: Color(
                                                              0xff656565)),).translate(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 50),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(AppImages.activeprofile),
                                                        SizedBox(width: 5,),
                                                        Text(
                                                          snapshot.data!
                                                              .profilecompleted
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontFamily:
                                                              "OpenSans"),
                                                        ).translate(),
                                                      ],
                                                    ),

                                                    Padding(padding: EdgeInsets.only(left: 5),child: Text(
                                                      "Profile \nCompleted",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontFamily:
                                                          "OpenSans",
                                                          color: Color(
                                                              0xff656565)),
                                                    ).translate(),)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 50),
                                              Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(AppImages.homemfi),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            snapshot
                                                                .data!.overallMfiScore
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                fontFamily: "OpenSans"),
                                                          ).translate(),
                                                        ],
                                                      ),

                                                      const Text(
                                                        "Overall MFI\nScore",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xff656565)),
                                                      ).translate(),
                                                    ],
                                                  )),
                                              SizedBox(width: 5,),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    vertical(10),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                               Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Income & Expenses",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontFamily: "OpenSans"),
                                                      ).translate(),
                                                      Text(
                                                        "Finance Manager",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xffA6A6A6)),
                                                      ).translate(),
                                                    ],
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      FinancePageScreen( profilecontroller.firstname.value,profilecontroller.address.value,profilecontroller.city.value));
                                                },
                                                child: SvgPicture.asset(
                                                  AppImages.roundaltarroe,
                                                  height: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: AppColors.primary),
                                          // const SizedBox(
                                          //   height: 20,
                                          // ),
                                          // const Text(
                                          //   "This month",
                                          //   style: TextStyle(
                                          //       fontFamily: "OpenSans",
                                          //       fontWeight: FontWeight.w500,
                                          //       fontSize: 14),
                                          // ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets.all(0),
                                                      decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  16))),
                                                      height: 80,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              AppImages.wallet2),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              const Text(
                                                                "Cash In",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    fontSize: 12),
                                                              ).translate(),
                                                              Text(
                                                                "₹ $totalcashin",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    fontSize: 14),
                                                              ).translate(),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                                // const SizedBox(
                                                //   width: 10,
                                                // ),
                                                Expanded(
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets.all(10),
                                                      decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  16))),
                                                      height: 80,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              AppImages.wallet1),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              const Text(
                                                                "Cash Out",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    fontSize: 12),
                                                              ).translate(),
                                                              Text(
                                                                "₹ $totalcashout",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                    "OpenSans",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    fontSize: 14),
                                                              ).translate(),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: ElevatedButton.icon(
                                                        style: ElevatedButton.styleFrom(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    15))),
                                                            backgroundColor:
                                                            const Color(
                                                                0xff25D366)),
                                                        onPressed: () async {
                                                          _addincome(context,
                                                              "Add Income");
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                        ),
                                                        label: const Text(
                                                          "Income",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 12,
                                                              color: Colors.white),
                                                        ).translate(),),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: ElevatedButton.icon(
                                                        icon: const Icon(
                                                          Icons.add,
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    15))),
                                                            backgroundColor:
                                                            const Color(
                                                                0xffF59E20)),
                                                        onPressed: () {
                                                          _addincome(context,
                                                              "Add Expenses");
                                                        },
                                                        label: const Text(
                                                          "Expenses",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "OpenSans",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 12,
                                                              color: Colors.white),
                                                        ).translate(),),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),



                                    vertical(10),
                                    snapshot.data!.loanCount == null ||snapshot.data!.loanCount==0
                                        ? Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10),
                                        child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: boldtext(
                                                      AppColors.black,
                                                      14,
                                                      "Do you want to get a loan?"),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            12.0),
                                                      ),
                                                      backgroundColor:
                                                      AppColors
                                                          .lightblue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MfiScreen()));
                                                    },
                                                    child: boldtext(
                                                      AppColors.primary,
                                                      12,
                                                      'Apply',
                                                    )),
                                              ],
                                            )),
                                      ),
                                    )
                                        :  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                               Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Active Loan",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontFamily: "OpenSans"),
                                                      ).translate(),
                                                      Text(
                                                        "your loan details",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: "OpenSans",
                                                            color:
                                                            Color(0xffA6A6A6)),
                                                      ).translate(),
                                                    ],
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(LoneDetailScreens());
                                                  // Get.to(() => const LoneListScreens());
                                                },
                                                child: SvgPicture.asset(
                                                  AppImages.roundaltarroe,
                                                  height: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          FutureBuilder<LoanListModel?>(
                                              future: providerdatalist,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                      child: Text(
                                                        '${snapshot.error} occurred',
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    );
                                                  } else if (snapshot.hasData) {
                                                    List<LoanListModelData>
                                                    loanList = addCallModel
                                                        ?.data
                                                        ?.where((element) => loanFilter ==
                                                        'Applied'
                                                        ? element
                                                        .mfiName ==
                                                        null
                                                        : element
                                                        .mfiName !=
                                                        null)
                                                        .toList() ??
                                                        [];
                                                    return Column(
                                                      children: [
                                                        ListView.builder(
                                                            padding:
                                                            EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (context,
                                                                position) {
                                                              return loanList
                                                                  .length ==
                                                                  1
                                                                  ? Container(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    12),
                                                                margin:
                                                                const EdgeInsets.all(
                                                                    10),
                                                                decoration: const BoxDecoration(
                                                                    color: Color(
                                                                        0xffF9F9F9),
                                                                    borderRadius:
                                                                    BorderRadius.all(Radius.circular(12))),
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SvgPicture.asset(AppImages.loan),
                                                                        const SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Expanded(child:  Text(loanList[position].mfiName!).translate(),)
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                      16,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: Column(
                                                                            children: [
                                                                              regulartext(
                                                                                AppColors.hint,
                                                                                12,
                                                                                "Loan Amount",
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                "₹${loanList[position].loanAmount}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "OpenSans",
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Column(
                                                                            children: [
                                                                              regulartext(
                                                                                AppColors.hint,
                                                                                12,
                                                                                "Installment",
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                "₹${loanList[position].installmentAmount.toString()}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "OpenSans",
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                            child: Column(children: [
                                                                              regulartext(
                                                                                AppColors.hint,
                                                                                12,
                                                                                "Interest rate",
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                "${loanList[position].intrestRate!}%",
                                                                                style: const TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "OpenSans",
                                                                                ),
                                                                              )
                                                                            ]))
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                                  : SizedBox(
                                                                height:
                                                                280,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                // margin: EdgeInsets.only(left: 16,right: 16),
                                                                child: ListView.builder(
                                                                    physics: const BouncingScrollPhysics(),
                                                                    padding: EdgeInsets.zero,
                                                                    shrinkWrap: true,
                                                                    itemCount: loanList.length,
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemBuilder: (context, index) {
                                                                      return Container(
                                                                        width: MediaQuery.of(context).size.width / 2.5,
                                                                        margin: const EdgeInsets.only(left: 16, right: 16),
                                                                        padding: const EdgeInsets.only(
                                                                          left: 16,
                                                                          right: 16,
                                                                          top: 16,
                                                                        ),
                                                                        decoration: const BoxDecoration(color: Color(0xffF9F9F9), borderRadius: BorderRadius.all(Radius.circular(16))),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                SvgPicture.asset(AppImages.loan),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Expanded(child: Text(loanList[index].mfiName!),)
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 16,
                                                                            ),
                                                                            regulartext(
                                                                              AppColors.hint,
                                                                              12,
                                                                              "Loan Amount",
                                                                            ),
                                                                            Text(
                                                                              "₹${loanList[index].loanAmount}",
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "OpenSans",
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 16,
                                                                            ),
                                                                            regulartext(
                                                                              AppColors.hint,
                                                                              12,
                                                                              "Installment",
                                                                            ),
                                                                            Text(
                                                                              "₹${loanList[index].installmentAmount.toString()}",
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "OpenSans",
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 16,
                                                                            ),
                                                                            regulartext(
                                                                              AppColors.hint,
                                                                              12,
                                                                              "Interest rate",
                                                                            ),
                                                                            Text(
                                                                              "${loanList[index].intrestRate!}%",
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "OpenSans",
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }),
                                                              );
                                                            })
                                                      ],
                                                    );
                                                  }
                                                }
                                                return const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                 Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Documents",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontFamily:
                                                              "OpenSans"),
                                                        ).translate(),
                                                        Text(
                                                          "View your uploaded documents",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontFamily:
                                                              "OpenSans",
                                                              color: Color(
                                                                  0xffA6A6A6)),
                                                        ).translate(),
                                                      ],
                                                    )),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        MyEntitlementsScreen());
                                                  },
                                                  child: SvgPicture.asset(
                                                    AppImages.roundaltarroe,
                                                    height: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GridView.count(
                                              physics: NeverScrollableScrollPhysics(),
                                                childAspectRatio: 5,
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                children: List.generate(
                                                  snapshot.data!.documentList!
                                                      .length,
                                                      (index) {
                                                    return Container(
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              AppImages
                                                                  .rightarrow),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .documentList![
                                                            index]
                                                                .name!,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                "OpenSans"),
                                                          ).translate(),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ))
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                               Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Collective Groups",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "OpenSans"),
                                                  ).translate(),
                                                  Text(
                                                    "My groups",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "OpenSans",
                                                        color:
                                                            Color(0xffA6A6A6)),
                                                  ).translate(),
                                                ],
                                              )),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => const ClubScreen());
                                                },
                                                child: SvgPicture.asset(
                                                  AppImages.roundaltarroe,
                                                  height: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: getGroupsModeldata!
                                                .length
                                                .clamp(0, 3),
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => MyGroupScreen(
                                                              getGroupsModeldata![i].Groupid.toString(),
                                                              getGroupsModeldata![i].groupTitle,getGroupsModeldata!.length)));
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xffF9F9F9),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16))),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getGroupsModeldata![
                                                                      i]
                                                                  .groupTitle!,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "OpenSans"),
                                                            ).translate(),
                                                            Text(
                                                              "${getGroupsModeldata!.length} New Message",
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  color: AppColors
                                                                      .primary),
                                                            ).translate(),
                                                          ],
                                                        )),
                                                        SvgPicture.asset(
                                                            AppImages.altarroe)
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),


                                    const SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return const Center(child: SizedBox());
                  }),
            )
          ],
        ));
  }

  void _addincome(context, String addincome) {
    bool click = false;
    String paymentmode = "";
    String paymenttype = "";
    String currentdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String currentdatasend = DateFormat('yyyy-MM-dd').format(DateTime.now());
    TextEditingController addamount = TextEditingController();
    TextEditingController paidby = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController mobileno = TextEditingController();
    String? mobile = "";
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  addincome == "Add Income"
                                      ? "Add Income"
                                      : "Add Expenses",
                                  style: const TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      if (kDebugMode) {
                                        print(pickedDate);
                                      }
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      String formattedDatesend =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      if (kDebugMode) {
                                        print(formattedDate);
                                      }
                                      setState(() {
                                        currentdate = formattedDate;
                                        currentdatasend = formattedDatesend;
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primary),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(17))),
                                    height: 32,
                                    width: 100,
                                    child: Center(
                                      child: Text(currentdate),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
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
                                hintText: "Amount"),
                            controller: addamount,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
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
                                hintText: addincome=="Add Income"?"Paid by":"Paid To"),
                            controller: paidby,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          click == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      click = true;
                                    });
                                    if (kDebugMode) {
                                      print(click);
                                    }
                                  },
                                  child: const Text(
                                    "+Add description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "OpenSans",
                                        fontSize: 14,
                                        color: AppColors.primary),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          click == true
                              ? Column(
                                  children: [
                                    TextField(
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.25),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 0.25),
                                          ),
                                          filled: true,
                                          border: InputBorder.none,
                                          fillColor: AppColors.textfieldcolor,
                                          hintText: "Description"),
                                      controller: description,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.textfieldcolor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: TextFormField(
                                        controller: mobileno,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        // textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15),
                                          fillColor: AppColors.green,
                                          hintText: 'Mobile Number',
                                          border: InputBorder.none,
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.25),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.25),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 0.25),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            mobile = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : const Text(""),
                          const Text("Select payment method"),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    paymentmode = "0";
                                    paymenttype = "Cash";
                                  });
                                  if (kDebugMode) {
                                    print(paymentmode);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.circle_outlined,
                                        color: paymentmode == "0"
                                            ? AppColors.primary
                                            : AppColors.gray),
                                    const Text("Cash"),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          paymentmode = "1";
                                          paymenttype = "UPI";
                                        });
                                        if (kDebugMode) {
                                          print(paymentmode);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.circle_outlined,
                                              color: paymentmode == "1"
                                                  ? AppColors.primary
                                                  : AppColors.gray),
                                          const Text("UPI"),
                                        ],
                                      ))),
                              Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        paymentmode = "2";
                                        paymenttype = "Cheque";
                                      });
                                      if (kDebugMode) {
                                        print(paymentmode);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle_outlined,
                                            color: paymentmode == "2"
                                                ? AppColors.primary
                                                : AppColors.gray),
                                        const Text("Cheque"),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [

                              // Expanded(
                              //     child: GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       paymentmode = "3";
                              //       paymenttype = "Googlepay";
                              //     });
                              //     if (kDebugMode) {
                              //       print(paymentmode);
                              //     }
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Icon(Icons.circle_outlined,
                              //           color: paymentmode == "3"
                              //               ? AppColors.primary
                              //               : AppColors.gray),
                              //       const Text("Googlepay"),
                              //     ],
                              //   ),
                              // )),
                            ],
                          ),
                          Container(
                            color: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      backgroundColor: AppColors.primary,
                                    ),
                                    onPressed: () async {
                                      if (addamount.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Please Add  Amount"),
                                        ));
                                      } else if (paidby.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar( SnackBar(
                                          content:
                                              Text(addincome!="Add Income"?"Please Add  Paid To Name":"Please Add  Paid By Name"),
                                        ));


                                      } else if (mobileno.text.isNotEmpty && mobileno.text.length != 10) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Please 10 Digit  Mobile Number"),
                                        ));
                                      } else if (mobileno.text.isNotEmpty && mobileno.text.length < 10) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Please 10 Digit  Mobile Number"),
                                        ));
                                      } else if (paymentmode == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Please Select Payment Mode"),
                                        ));
                                      } else {

                                        print(ApiUrl.add_transection);
                                        final response = await http.post(
                                          Uri.parse(ApiUrl.add_transection),
                                          body: {
                                            "user_id": userid,
                                            "trans_date": currentdatasend,
                                            "credit_amount": addincome == "Add Income"?addamount.text:"0",
                                            "debit_amount": addincome == "Add Income"?"0":addamount.text,
                                            "description": description.text,
                                            "trans_name": paidby.text,
                                            "trans_mobile": mobileno.text,
                                            "payment_mode": paymenttype,
                                            "flag":  addincome == "Add Income"?"credit":"debit",
                                          },
                                        );
                                        print(response.body);
                                        if (response.statusCode == 200) {
                                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                            content: addincome=="Add Income"?Text(
                                                "Income Add Successfully"):Text(
                                                "Expenses Add Successfully"),
                                            duration: Duration(microseconds: 1),
                                          ));
                                          Timer(const Duration(seconds: 1), () => Navigator.of(context).pop());
                                          alltransactionmodel = myfinancelist(userid!);
                                          if (kDebugMode) {
                                            print(response.statusCode);

                                          }
                                        } else {
                                          if (kDebugMode) {
                                            print("object");
                                            Navigator.pop(context);
                                          }
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: Container(
                height: 30,
                transform: Matrix4.translationValues(170.0, -40, 0.0),
                // translate up by 30
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {

                    print('doing stuff');
                    if (kDebugMode) {
                      print('doing stuff');
                    }
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerTop,
            );
          });
        });
  }

  Future<void> getuserid() async {
    userid = await sharedPreference.isUsetId();
    alltransactionmodel = myfinancelist(userid!);
    providerdatalist = addloanmmodeloges(userid!);
    getAllservice(userid!);
   // getNotification(userid!);
    cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  Future<LoanListModel?> addloanmmodeloges(String userId) async {
    showLoader(context);
    try {
      Map<String, String> requestBody = <String, String>{
        'provider_id': "" + userId,
        'status':"1",
      };
      final response = await http.post(
        Uri.parse(ApiUrl.approved_loan_list),
        body: requestBody,
      );
      if (response.statusCode == 200) {
        hideLoader();
        addCallModel = LoanListModel.fromJson(jsonDecode(response.body));
        status = addCallModel!.status!;
        waitappliy = addCallModel!.loanapply!;
        setState(() {});
        List<LoanListModelData> loanList = addCallModel?.data
            ?.where((element) => loanFilter == 'Applied'
            ? element.mfiName == null
            : element.mfiName != null)
            .toList() ??
            [];

        return addCallModel;
      } else {
        hideLoader();
        return addCallModel;
      }
    } catch (e) {
      hideLoader();

    }
  }

  Future<List<TransectionData>?>? myfinancelist(String userId) async {
    try {
      Map<String, String> requestBody = <String, String>{
        'user_id': userId,
      };



      final response = await http.post(
        Uri.parse(ApiUrl.view_transection),
        body: requestBody,
      );
      if (response.statusCode == 200) {
        AllViewTransectionModel? allViewTransectionModel =
            AllViewTransectionModel.fromJson(jsonDecode(response.body));
        transactionData = allViewTransectionModel.data;
        totalcashin = allViewTransectionModel.totalCredit.toString();
        totalcashout = allViewTransectionModel.totalDebit.toString();
        setState(() {});
        return allViewTransectionModel.data;
      } else {
      }
    } catch (e) {
    }
    return null;
  }



  Future<GetGroupsModel?> getAllservice(String user_id) async {
    try {
      final response = await http
          .post(Uri.parse(ApiUrl.getMyGroups), body: {"user_id": user_id});
      Map<String, dynamic> map = json.decode(response.body);
      if (response.statusCode == 200) {

        GetGroupsModel? allServiceModel =
            GetGroupsModel.fromJson(jsonDecode(response.body));

        getGroupsModeldata = allServiceModel.data;

        setState(() {});
        return allServiceModel;
      } else {

      }
    } catch (e) {

    }
  }

  Future<GetHomeModel?> gethomedata() async {
    controlleradd.onInit();
    showLoader(context);

    try {
      var headers = {'Authorization': USERTOKKEN!};
      final response = await http.get(Uri.parse(ApiUrl.gethomelist), headers: headers);


      if (response.statusCode == 200) {
        GetHomeModel? allServiceModel =
            GetHomeModel.fromJson(jsonDecode(response.body));
        setState(() {
          hideLoader();
        });
        return allServiceModel;
      } else {
        setState(() {
          hideLoader();
        });

      }
    } catch (e) {
      setState(() {
        hideLoader();
      });

    }
  }





  void changeTab(int index) {
    setState(() {
      _currentIndex = 3;
    });
  }


}

Future<void> notificationDialog({
  required BuildContext context,
  required String image,
  required String title,
  required String subTitle,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              // borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                width: 100,
                fit: BoxFit.cover,
                placeholder: (context, string) => ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/icons/app_logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                errorWidget: (context, string, dynamic) => ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/icons/app_logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            title,
            maxLines: 3,
            style: const TextStyle(
              color: AppColors.black,
              fontFamily: "caviarbold",
              fontSize: 15,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            maxLines: 3,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.7),
              fontFamily: "caviarbold",
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}

final SharedPreference _sharedPreference = SharedPreference();

Widget textAreasearch(TextEditingController controller, String hint,
    {double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(
            horizontal: hint.contains("Description") ? 5 : 16, vertical: 10),
        child: TextField(
          onTap: () async {
            String becomeSuplier = await _sharedPreference.isLoggedIn();
            hint.contains("Description")
                ? print("dgfhgj")
                : Get.to(MyServicesScreensProvider(becomeSuplier));
          },
          minLines: hint.contains("Description") ? 5 : 1,
          maxLines: hint.contains("Description") ? 5 : 1,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: hint.contains("Description")
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        AppImages.search,
                        height: 16,
                        width: 16,
                      ),
                    ),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: hint.contains("Description")
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: hint.contains("Description")
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: hint == "Search" || hint == "Description"
                  ? AppColors.gray
                  : Colors.white,
              hintText: hint),
        ),
      ),
    ],
  );
}
