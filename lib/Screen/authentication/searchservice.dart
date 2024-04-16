import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/components/commonBottomSheet.dart';
import 'package:businessgym/conts/stars_view.dart';
import 'package:businessgym/model/SearchListModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderServicesearchScreen extends StatefulWidget {
  String text;
  String type;
  ProviderServicesearchScreen(this.text,this.type);
  @override
  ProviderServicesearchScreenState createState() => ProviderServicesearchScreenState();
}
class ProviderServicesearchScreenState extends State<ProviderServicesearchScreen> {

  @override
  void initState() {
    searchWithFilter(widget.text);
    super.initState();
  }

  @override
  List<Serchlistmodeldata> searchlist = [];
  var categoryIdList = [];
  String? ratingValue;
  String? catType;
  double? lat;
  double? lng;
  String? openAt;
  String? closeAt;
  double? startPrice;
  double? endPrice;

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: searchlist.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.type==searchlist[index].type? GestureDetector(
                onTap: (){
                  CommonBottomSheet.show(context,searchlist![index].userid.toString(),searchlist![index].userid.toString(),"service");

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
                                "${searchlist[index].profileImage??""}",
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldtext(
                                  AppColors.black,
                                  14,
                                  "${searchlist[index].providername??""}",
                                ),
                                boldtext(
                                  AppColors.blackShade3,
                                  12,
                                  "${searchlist[index].subCategoryName==null?"-":searchlist[index].subCategoryName}",
                                ),
                                boldtext(
                                  AppColors.hint,
                                  12,
                                  "${searchlist[index].type??""}",
                                ),
                                StarsView(
                                    total:  5,
                                    colored: searchlist?[index].rating??0,

                                    ontap: () {

                                    })
                              ],
                            ))
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 1,thickness: 1,)
                      ],
                    )
                ),
              ):SizedBox.shrink() ;

            })

    );
  }

  searchWithFilter(String value) async {
    searchlist = [];
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.searchFilterUrl),
      );
      request.fields['text'] = value;
      if (categoryIdList != []) {
        for (var i = 0; i < categoryIdList.length; i++) {
          request.fields['category_id[$i]'] = categoryIdList[i].toString();
        }
      }
      if (ratingValue != null) {
        request.fields['rating'] = ratingValue ?? '';
      }
      if (startPrice != null) {
        request.fields['min_price'] = ratingValue ?? '';
      }
      if (endPrice != null) {
        request.fields['max_price'] = ratingValue ?? '';
      }
      if (lat != null) {
        request.fields['latitude'] = ratingValue ?? '';
      }
      if (lng != null) {
        request.fields['longitude'] = ratingValue ?? '';
      }
      if (openAt != null) {
        request.fields['open_at'] = ratingValue ?? '';
      }
      if (closeAt != null) {
        request.fields['close_at'] = ratingValue ?? '';
      }
      final response = await request.send();
      final data = await http.Response.fromStream(response);
      print(data.body);
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