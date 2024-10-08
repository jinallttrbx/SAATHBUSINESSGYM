import 'dart:async';
import 'dart:convert';


import 'package:businessgym/Screen/HomeScreen/MyServicesScreens.dart';
import 'package:geolocator/geolocator.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:businessgym/Screen/ProfileScreen/RatingandReviewByUserScreens.dart';
import 'package:businessgym/Screen/ProfileScreen/SubCategoryScreen.dart';
import 'package:businessgym/Screen/ProfileScreen/myservices.dart';
import 'dart:math';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/components/button.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/filter_screen.dart';
import 'package:businessgym/conts/stars_view.dart';
import 'package:businessgym/model/GetUserReviews.dart';
import 'package:businessgym/model/SearchListModel.dart';
import 'package:businessgym/model/getproductbyuserid.dart';
import 'package:businessgym/model/getservicebyuserid.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/SharedPreferences.dart';
import '../values/Colors.dart';
import '../values/assets.dart';
import '../values/spacer.dart';
import 'global_values.dart';


class SearchWidget extends StatefulWidget {
  bool? appbar;
  bool? productView;
  SearchWidget({super.key, this.appbar, this.productView});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isLoading = false;
  dynamic totalList = [];
  List<Serchlistmodeldata> searchlist = [];
  Future<List<Getservicebyuseriddata?>?>? servicebyid;
  List<Getservicebyuseriddata>? servicebyiddata = [];
  Future<List<GetproductbyuseridData?>?>? productbyid;
  List<GetproductbyuseridData>? productbyiddata = [];
  String? filter;


  bool focus = false;
  FocusNode inputNode = FocusNode();
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  TextEditingController controller = TextEditingController();

  Timer? _debounce;

  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }
  var categoryIdList = [];
  String? ratingValue;
  String? catType;
  String? lat;
  String? lng;
  Position? _currentPosition;
  String? openAt;
  String? closeAt;
  double? startPrice;
  double? endPrice;
  bool onmick=false;
  bool _isListening = false;
  stt.SpeechToText? _speech;
  @override
  Widget build(BuildContext context) {
    filter = widget.productView == true ? 'name' : 'service_name';
    return Scaffold(
        resizeToAvoidBottomInset: false,
       // appBar: widget.appbar == false ? null : APPBar(title: 'Search Service'),
        body: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        child: TextField(
                          autofocus: focus,
                          focusNode: inputNode,
                          controller: controller,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: "caviarbold"),
                          onChanged: (value)  async{
                            _currentPosition = await Geolocator.getCurrentPosition();

                            // getSearch(controller.text);
                            if (_debounce?.isActive ?? false) {
                              _debounce!.cancel();
                            }
                            _debounce = Timer(
                              const Duration(milliseconds: 1000),
                                  () {
                                if (value.isNotEmpty) {
                                  searchWithFilter(value);
                                } else {
                                  setState(() {
                                    searchlist = [];
                                  });
                                }
                              },
                            );
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 10),
                            hintText:
                            "Search For ${widget.productView == true ? "Product" : "Service"}....",
                            hintStyle: const TextStyle(
                                color: Color(0xff808080),
                                fontFamily: 'caviarbold'),
                            fillColor: Colors.white,
                            filled: true,
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  onmick=true;
                                });
                                if(onmick==true){
                                  _initializeSpeechRecognition ();
                                }else{
                                  _stopListening();

                                }
                                print("USE MIKE AND SPEAK ORD TO SEARCH SOMETHING YOU WANT");
                              },
                              child:  _isListening==true?Icon(Icons.mic,color: AppColors.primary,):Icon(Icons.mic_off)
                            ),
                            prefixIcon: const Icon(Icons.search),

                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(

                            onPressed: () async {
                              final result = await Get.to(
                                    () => filterscreen(
                                  catType: catType,
                                  categoryList: categoryIdList,
                                  rating: ratingValue,
                                  lat: lat,
                                  lng: lng,
                                  openAt: openAt,
                                  closeAt: closeAt,
                                  min: startPrice,
                                  max: endPrice,
                                ),
                              );
                              if (result != null) {
                                catType = result['type'];
                                categoryIdList = result['category_id'];
                                ratingValue = result['rating'];
                                lat = result['lat'];
                                lng = result['lng'];
                                openAt = result['open_at'];
                                closeAt = result['close_at'];
                                startPrice = result['min_price'];
                                endPrice = result['max_price'];
                              }
                            },
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: isLoading
                    ? const Text("Loading")
                    : searchlist!.isEmpty
                        ? MyServicesScreens(
                            productView: widget.productView,
                          ):
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchlist!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          CommonBottomSheet.show(context,searchlist![index].userid.toString(),searchlist![index].typeId.toString(),"service","");

                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child:Column(

                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "${searchlist![index].profileImage??""}",
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        boldtext(
                                          AppColors.black,
                                          14,
                                          "${searchlist![index].providername??""}",
                                        ),
                                        boldtext(
                                          AppColors.blackShade3,
                                          12,
                                          "${searchlist![index].subCategoryName==null?"-":searchlist![index].subCategoryName}",
                                        ),
                                        StarsView(
                                            total:  5,
                                            colored: searchlist?[index].rating.toInt(),

                                            ontap: () {

                                            })
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Divider(height: 1,thickness: 1,)
                              ],
                            )
                        ),
                      );

                    })
              )
            ],
          ),
        ));
  }

  void _initializeSpeechRecognition() async {
    print("speak to word");
    bool available = await _speech!.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {

      setState(() => _isListening = true);
      _startListening();
    }
  }

  void _startListening() {
    _speech?.listen(
      onResult: (val) => setState(() {
        controller.text = val.recognizedWords;

        if (val.hasConfidenceRating && val.confidence > 0) {
          _confidence = val.confidence;
        }
        searchWithFilter(controller.text);
      }),
    );
  }

  void _stopListening() {
    setState(() {
      onmick=false;
    });
    _speech!.stop();
    setState(() => _isListening = false);
  }

  searchWithFilter(String value) async {
    print(ApiUrl.searchFilterUrl);
    searchlist = [];
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.searchFilterUrl),
      );
      request.fields['text'] = value;
      if (categoryIdList == []) {
        for (var i = 0; i < categoryIdList.length; i++) {
          request.fields['category_id'] = categoryIdList[i].toString();
          print("PRINT A CATEGORYLIST ${categoryIdList[i]}");
        }
      }
      if (ratingValue != null) {
        request.fields['rating'] = ratingValue ?? '';
        print(ratingValue);
      }
      if (startPrice != null) {
        request.fields['min_price'] = startPrice.toString() ?? '';
        print(startPrice);
      }
      if (endPrice != null) {
        request.fields['max_price'] = endPrice.toString() ?? '';
        print(endPrice);
      }
      if (lat != null) {
        request.fields['latitude'] = lat.toString() ?? '';
        print(lat);
      }
      if (lng != null) {
        request.fields['longitude'] = lng.toString() ?? '';
        print(lng);
      }
      if (openAt != null) {
        request.fields['open_at'] = openAt.toString() ?? '';
        print(openAt);
      }
      if (closeAt != null) {
        request.fields['close_at'] = closeAt.toString() ?? '';
        print(closeAt);
      }
      final response = await request.send();
      final data = await http.Response.fromStream(response);
      print(data.body);
      print( request.fields['text']);
      print( request.fields['category_id']);
      print( request.fields['rating']);
      print( request.fields['min_price']);
      print(request.fields['max_price']);
      print(request.fields['latitude']);
      print(request.fields['longitude']);
      print(request.fields['open_at']);
      print( request.fields['close_at']);
      print(data.statusCode);
      if (response.statusCode == 200) {
        Serchlistmodel vehicalTypeModel =
        Serchlistmodel.fromJson(jsonDecode(data.body));
        searchlist = vehicalTypeModel.data;
        setState(() {});
      } else {}
    } catch (e) {
      print(e);
    }
  }



}









