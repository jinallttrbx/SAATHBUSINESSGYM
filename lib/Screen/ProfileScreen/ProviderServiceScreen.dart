import 'dart:convert';
import 'package:businessgym/Controller/serviceController.dart';
import 'package:businessgym/Screen/ProfileScreen/EditProductservice.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Screen/ProfileScreen/ProviderServiceAddScreen.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/model/ServiceListModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/common_route.dart';
import '../../../values/Colors.dart';
import '../../../values/const_text.dart';




class ProviderServiceScreen extends StatefulWidget {
  @override
  ProviderServiceScreenState createState() => ProviderServiceScreenState();
}
class ProviderServiceScreenState extends State<ProviderServiceScreen> {
  final servicecontroller = Get.find<ServiceController>();
  @override
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body:servicecontroller.serviceprofilelist!.isEmpty?Center(
          child:    SvgPicture.asset(AppImages.nofound,height: 170,width: 170,)
        ):

        ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: servicecontroller.serviceprofilelist!.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 02),
                    decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child:  GestureDetector(
                      child: _buildListservice(servicecontroller.serviceprofilelist[index]),
                      //Text(categorydata![index].data[index].subCategory.length.toString())

                    )
                )
        ),
        bottomNavigationBar: Padding(
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
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProviderServiceAddScreen(
                    isEdit: false,
                    title: 'Service',

                  )));


                },
                child:  Text(
                  'Add Service',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
          ),
        )

    );
  }
  Widget _buildListservice(ServiceCategory list) {
    if (list.subCategory.isNotEmpty)
      return ExpansionTile(
        // leading: Icon(list.icon),
        title: Row(
          children: [
            boldtext(Colors.black,16,
              list.categoryName,
            ),
            Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                decoration: BoxDecoration(
                    color: list.type.name!="PROVIDER"?AppColors.primary.withOpacity(0.05):AppColors.LightGreens,
                    borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: list.type.name=="PROVIDER"?boldtext(AppColors.Green,10,
                  "ME",
                ):boldtext(AppColors.primary,10,
                  "Supplier",
                )
            ),
          ],
        ),
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: list.subCategory.length,
              itemBuilder: (context,position){
              print(list.subCategory.length.toString());
                return GestureDetector(
                  onTap: (){
                    Get.to(editproviderservicepcreen(title: 'Service',list:list,list1: list.subCategory[position],));
                  },
                  child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  height: 60,
                                  width: 60,
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    child:  Image.network(list.subCategory[position].serviceImage,fit: BoxFit.fill,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    regulartext(AppColors.hint,12,list.subCategory[position].productName),
                                    list.subCategory[position].subCategoriesName!=null? boldtext(AppColors.black,14,list.subCategory[position].subCategoriesName!):boldtext(AppColors.black,14,list.subCategory[position].subCategoriesName!),
                                  ],
                                ),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    regulartext(AppColors.hint,12,"Price range"),
                                    boldtext(AppColors.black,14,"${list.subCategory[position].minPrice.toString()} to ${list.subCategory[position].maxPrice.toString()}"),
                                  ],
                                )


                              ],
                            ),
                          )


                        ],
                      )
                  ),
                );
              })
        ],
      );
    return SizedBox.shrink();
  }





}


