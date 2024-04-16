import 'dart:convert';


import 'package:businessgym/Controller/productController.dart';

import 'package:businessgym/Screen/ProfileScreen/EditProductservice.dart';
import 'package:businessgym/Screen/ProfileScreen/editproduct.dart';
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/Utils/SharedPreferences.dart';
import 'package:businessgym/model/ProductListModel.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Utils/common_route.dart';
import '../../values/Colors.dart';
import '../../values/const_text.dart';
import '../../conts/global_values.dart';
import 'ProviderServiceAddScreen.dart';



class ProductServices extends StatefulWidget {


  @override
  ProviderServiceScreenState createState() => ProviderServiceScreenState();
}

class ProviderServiceScreenState extends State<ProductServices> {
  final productcontroller = Get.find<ProductController>();
  @override
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
        body:productcontroller.productprofilelist!.isEmpty?Center(
          child: 
            SvgPicture.asset(AppImages.nofound,height: 170,width: 170,)
        ):ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: productcontroller.productprofilelist!.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child:  _buildListproduct(productcontroller.productprofilelist![index]),
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
                  Get.to(() => ProviderServiceAddScreen(
                    isEdit: false,
                    title: 'Product',
                  ));

                },
                child:  Text(
                  'Add Product',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
          ),
        )

    );
  }
  Widget _buildListproduct(ProductCategory list) {

    if (list.subCategory.isEmpty)
      return Builder(


          builder: (context) {
            return SizedBox.shrink();
          }
      );
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

            shrinkWrap: true,
            itemCount: list.subCategory.length,
            itemBuilder: (context,position){
              return GestureDetector(
                onTap: (){
                  Get.to(editproviderproductpcreen(title: 'Product',list:list,list1: list.subCategory[position],));
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
                                  child:  Image.network(list.subCategory[position].productImage??"",fit: BoxFit.fill,),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  regulartext(AppColors.hint,12,list.subCategory[position].productName??""),
                                  list.subCategory[position].subCategoriesName!=""? boldtext(AppColors.black,14,list.subCategory[position].subCategoriesName??""):boldtext(AppColors.black,14,list.subCategory[position].subCategoriesName??""),
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
  }



}


