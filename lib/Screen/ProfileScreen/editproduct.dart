import 'dart:convert';
import 'dart:io';

import 'package:businessgym/Controller/productController.dart';
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/serviceController.dart';
import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/components/decor.dart';

import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';

import 'package:businessgym/conts/global_values.dart';

import 'package:businessgym/Controller/workprofileController.dart';

import 'package:businessgym/model/GetProductSubcategory.dart';
import 'package:businessgym/model/ProductListModel.dart';
import 'package:businessgym/model/ServiceListModel.dart';
import 'package:businessgym/model/WorkProfileList.dart';
import 'package:businessgym/model/getSupplierProductCategory.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../Utils/ApiUrl.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../Utils/common_route.dart';
import '../../../model/AllServiceModel.dart';
import '../../../model/CategoryProviderModel.dart';
import '../../../model/SubCategoryProviderNewModel.dart';
import '../../../model/ViewoccuaptionsModel.dart';
import '../../../model/viewWork_profileModel.dart';
import '../../../values/Colors.dart';

class editproviderproductpcreen extends StatefulWidget {
  ProductCategory list;
  SubCategoryProduct list1;
  String title;

  editproviderproductpcreen(
      {super.key,
      required this.title,
      required this.list,
      required this.list1});

  @override
  editproviderproductpcreenState createState() =>
      editproviderproductpcreenState();
}

class editproviderproductpcreenState extends State<editproviderproductpcreen> {
  String Categotyid = "0";
  List Categorylist = [];
  List<GetProductCategorydata> productcategory = [];
  List<GetServiceCategorydata> servicecategory = [];
  List<String> categoryNames = [];
  List subcategory = [];
  List<GetProductSubCategorydata> subcategorylist = [];
  List<String> subcategoryNames = [];
  GetServiceCategorydata? serviceValue;
  GetProductCategorydata? productValue;
  GetServiceSubCategorydata? subServiceValue;
  GetProductSubCategorydata? subProductValue;
  String typename = "";
  String subcatid = "";

  //   final providerservicecontroller = Get.find<ProviderServiceController>();
  // final productcontroller = Get.find<ProductController>();
  final servicenameController = TextEditingController();
  final mycityController = TextEditingController();
  final mynumberController = TextEditingController();

  // final myemailController = TextEditingController();
  final myminpriceController = TextEditingController();
  final mymaxpriceController = TextEditingController();
  final mydescriptionController = TextEditingController();
  final myaddressController = TextEditingController();
  final profileController = Get.find<UserProfileController>();
  final service = Get.find<ServiceController>();
  final product = Get.find<ProductController>();
  SharedPreference _sharedPreference = new SharedPreference();
  Future<AllServiceModel?>? allservice1;
  Future<List<GetServiceCategorydata>?>? servicecategorylist;
  Future<List<GetProductCategorydata>?>? productcategorylist;
  Future<List<WorkProfileModeldata>?>? occupationlist;
  List<GetServiceCategorydata>? servicecategorydata = [];
  List<GetProductCategorydata>? productcategorydata = [];
  bool _isLoading = false;
  final SharedPreference _prefs = SharedPreference();
  Future<List<GetServiceSubCategorydata>?>? sublistData1;
  Future<List<GetProductSubCategorydata>?>? sublistData2;
  List<GetServiceSubCategorydata>? subservicecategorydata = [];
  List<GetProductSubCategorydata>? subproductcategorydata = [];

  final workcontroller = Get.find<WorkProfileController>();
  String UserId = "";
  String? usertoken = "";
  String usertype = "";
  String? categotyid;
  String categoryname = "";
  String? categorype;
  String categorype1 = "0";
  String? subcategotyid;
  String subcategoryname = "";
  String occupationid = "0";
  String dropdownValueoccupation = '';

  String workprofilename = "";
  String selectedimage = "";
  File? _image;
  File? imageselected;
  PickedFile? pickedImage;
  final ImagePicker picker = ImagePicker();



  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categorype = widget.list.type.name == "PROVIDER" ? "provider" : "supplier";
    categorype1 = widget.list.type.name == "PROVIDER" ? "ME" : "supplier";
    categotyid = widget.list.id.toString();
    subcategoryname=widget.list1.subCategoriesName??"";
    subcategotyid=widget.list1.subCategoryId.toString();
    categoryname = widget.list.categoryName + categorype1;
    occupationid = widget.list1.workProfileId.toString();
    subcategoryname = widget.list1.subCategoriesName.toString();
    mydescriptionController.text = widget.list1.description ?? "";
    workprofilename = widget.list1.workProfileName ?? "";
    servicenameController.text = widget.list1.productName;
    selectedimage = widget.list1.productImage;
    myminpriceController.text = widget.list1.minPrice.toString();
    mymaxpriceController.text = widget.list1.maxPrice.toString();
    print("print service id ${widget.list.id}");
    print("print service subcategory id ${widget.list1.id}");
    getuserType();
    setState(() {});
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    sublistData2 = getproductsubAllservice1(categotyid??"", categorype??"");
    productcategorylist = getproductcategory();
    occupationlist = getoccupationData();
    setState(() {});
  }

  Future<List<GetProductCategorydata>?>? getproductcategory() async {
    print(ApiUrl.getsupplierproductlist);
    try {
      showLoader(context);
      final response = await http.get(Uri.parse(ApiUrl.getsupplierproductlist),
          headers: {"Authorization": USERTOKKEN.toString()});
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        hideLoader();
        GetProductCategory? allServiceModel =
            GetProductCategory.fromJson(jsonDecode(response.body));
        for (int i = 0; i < allServiceModel.data!.length; i++) {
          GetProductCategorydata categoryModelData = GetProductCategorydata(
            id: allServiceModel.data![i].id,
            name: allServiceModel.data![i].name,
            description: allServiceModel.data![i].description,
            status: allServiceModel.data![i].status,
            isProduct: allServiceModel.data![i].isProduct,
            isService: allServiceModel.data![i].isService,
            isFeatured: allServiceModel.data![i].isFeatured,
            deletedAt: allServiceModel.data![i].deletedAt,
            createdAt: allServiceModel.data![i].createdAt,
            updatedAt: allServiceModel.data![i].updatedAt,
            type: allServiceModel.data![i].type,
            color: allServiceModel.data![i].color,
          );
          productcategorydata!.add(categoryModelData);
        }
        setState(() {});

        return allServiceModel.data;
      } else {
        hideLoader();
        print("Something went worange");
      }
    } catch (e) {
      print("data===1 error  $e");
    }
    return null;
  }

  Future<List<GetServiceCategorydata>?> getservicecategory() async {
    try {
      showLoader(context);
      final response = widget.title != "service"
          ? await http.get(Uri.parse(ApiUrl.getsupplierservicelist),
              headers: {"Authorization": USERTOKKEN.toString()})
          : await http.post(Uri.parse(ApiUrl.getsupplierproductlist));
      if (response.statusCode == 200) {
        hideLoader();
        GetServiceCategory? allServiceModel =
            GetServiceCategory.fromJson(jsonDecode(response.body));
        for (int i = 0; i < allServiceModel.data!.length; i++) {
          GetServiceCategorydata categoryModelData = GetServiceCategorydata(
              id: allServiceModel.data![i].id,
              name: allServiceModel.data![i].name,
              description: allServiceModel.data![i].description,
              color: allServiceModel.data![i].color,
              status: allServiceModel.data![i].status,
              isProduct: allServiceModel.data![i].isProduct,
              isService: allServiceModel.data![i].isService,
              isFeatured: allServiceModel.data![i].isFeatured,
              deletedAt: allServiceModel.data![i].deletedAt,
              createdAt: allServiceModel.data![i].createdAt,
              updatedAt: allServiceModel.data![i].updatedAt,
              type: allServiceModel.data![i].type);
          servicecategorydata!.add(categoryModelData);
        }
        setState(() {});

        return allServiceModel.data;
      } else {
        hideLoader();
      }
    } catch (e) {}
    return null;
  }

  List<WorkProfileModeldata>? viewoccuaptionsModelData = [];

  Future<List<WorkProfileModeldata>?> getoccupationData() async {
    print("SERVOCE GET OCCUPATION LIST");
    try {
      final response = await http.post(
          Uri.parse("https://saath.lttrbx.in/api/workProfileLists"),
          headers: {"Authorization": USERTOKKEN.toString()});
      if (response.statusCode == 200) {
        print(USERTOKKEN.toString());
        print(response.statusCode);
        print(response.body);
        WorkProfileModel catrgortModel =
            WorkProfileModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < catrgortModel.data!.length; i++) {
          WorkProfileModeldata categoryModelData = WorkProfileModeldata(
            title: catrgortModel.data![i].title,
            workProfileId: catrgortModel.data![i].workProfileId,
            typeId: catrgortModel.data![i].typeId,
            workProfileName: catrgortModel.data![i].workProfileName,
            email: catrgortModel.data![i].email,
            modeOfBusiness: catrgortModel.data![i].modeOfBusiness,
            businessAddress: catrgortModel.data![i].businessAddress,
            location: catrgortModel.data![i].location,
            mobile: catrgortModel.data![i].mobile,
            travelCharge: catrgortModel.data![i].travelCharge,
            gstNumber: catrgortModel.data![i].gstNumber,
            licenceNumber: catrgortModel.data![i].licenceNumber,
            fssaiNumber: catrgortModel.data![i].fssaiNumber,
            latitude: catrgortModel.data![i].latitude,
            openAt: catrgortModel.data![i].openAt,
            closeAt: catrgortModel.data![i].closeAt,
            longitude: catrgortModel.data![i].longitude,
            subTitle: catrgortModel.data![i].subTitle,
            timing: catrgortModel.data![i].timing,
            serviceCount: catrgortModel.data![i].serviceCount,
            productCount: catrgortModel.data![i].productCount,
          );
          viewoccuaptionsModelData!.add(categoryModelData);
        }
        setState(() {});
        return viewoccuaptionsModelData;
      }
      print(response.statusCode);
    } catch (e) {
      print("sdfok" + e.toString());
    }
    return null;
  }

  Future<List<GetServiceSubCategorydata>?> getsubAllservice1(
      String id, String type) async {
    print("${ApiUrl.getservicesubcategorylist}category_id=$id&type=$type");
    try {
      final response = await http.get(
          Uri.parse(
              "${ApiUrl.getservicesubcategorylist}category_id=$id&type=$type"),
          headers: {"Authorization": USERTOKKEN.toString()});
      print("sub category response ${response.body}");
      if (response.statusCode == 200) {
        GetServiceSubCategory? allServiceModel =
            GetServiceSubCategory.fromJson(jsonDecode(response.body));
        // GetServiceSubCategory categoryModelData1 =
        // GetServiceSubCategory(
        // id: 0, name: "Select Sub Category");
        // subcategorydata!.add(categoryModelData1);
        for (int i = 0; i < allServiceModel.data!.length; i++) {
          GetServiceSubCategorydata categoryModelData1 =
              GetServiceSubCategorydata(
                  id: allServiceModel.data![i].id,
                  name: allServiceModel.data![i].name,
                  categoryId: allServiceModel.data![i].categoryId,
                  description: allServiceModel.data![i].description,
                  status: allServiceModel.data![i].status,
                  isFeatured: allServiceModel.data![i].isFeatured,
                  deletedAt: allServiceModel.data![i].deletedAt,
                  createdAt: allServiceModel.data![i].createdAt,
                  updatedAt: allServiceModel.data![i].updatedAt);
          subservicecategorydata!.add(categoryModelData1);
        }
        setState(() {});

        return allServiceModel.data;
      } else {
        hideLoader();
        print("Something went worange");
      }
    } catch (e) {
      print("data===1error $e");
    }
    return null;
  }

  Future<List<GetProductSubCategorydata>?> getproductsubAllservice1(
      String id, String type) async {
    subproductcategorydata = [];
    print("${ApiUrl.getproductsubcategorylist}category_id=$id&type=$type");
    try {
      final response = await http.get(
          Uri.parse(
              "${ApiUrl.getproductsubcategorylist}category_id=$id&type=$type"),
          headers: {"Authorization": USERTOKKEN.toString()});
      print("sub category response ${response.body}");
      if (response.statusCode == 200) {
        GetProductSubCategory? allServiceModel =
            GetProductSubCategory.fromJson(jsonDecode(response.body));
        // GetServiceSubCategory categoryModelData1 =
        // GetServiceSubCategory(
        // id: 0, name: "Select Sub Category");
        // subcategorydata!.add(categoryModelData1);
        for (int i = 0; i < allServiceModel.data!.length; i++) {
          GetProductSubCategorydata categoryModelData1 =
              GetProductSubCategorydata(
                  id: allServiceModel.data![i].id,
                  name: allServiceModel.data![i].name,
                  categoryId: allServiceModel.data![i].categoryId,
                  description: allServiceModel.data![i].description,
                  status: allServiceModel.data![i].status,
                  isFeatured: allServiceModel.data![i].isFeatured,
                  deletedAt: allServiceModel.data![i].deletedAt,
                  createdAt: allServiceModel.data![i].createdAt,
                  updatedAt: allServiceModel.data![i].updatedAt);
          subproductcategorydata!.add(categoryModelData1);
        }
        setState(() {});

        return allServiceModel.data;
      } else {
        hideLoader();
        print("Something went worange");
      }
    } catch (e) {
      print("data===1error $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: APPBar(title: "Edit ${widget.title}"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin:
                  const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: FutureBuilder<List<GetProductCategorydata>?>(
                      future: productcategorylist,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              DropdownButtonFormField<
                                  GetProductCategorydata?>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey)),
                                ),
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    boldtext(AppColors.black, 13,
                                        "${categoryname}"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                            color: categorype ==
                                                "SUPPLIER"
                                                ? AppColors.primary
                                                .withOpacity(0.05)
                                                : AppColors.LightGreens,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(9))),
                                        child: categorype != "SUPPLIER"
                                            ? boldtext(
                                          AppColors.Green,
                                          10,
                                          "ME",
                                        )
                                            : boldtext(
                                          AppColors.primary,
                                          10,
                                          "Supplier",
                                        )),
                                  ],
                                ),
                                // value: snapshot.data![0],
                                items: snapshot.data!.map((countries) {
                                  return DropdownMenuItem<
                                      GetProductCategorydata?>(
                                    value: countries,
                                    child: Row(
                                      children: [
                                        boldtext(AppColors.black, 13,
                                            "${countries.name}"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 5,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                                color: countries
                                                    .type.name ==
                                                    "SUPPLIER"
                                                    ? AppColors.primary
                                                    .withOpacity(0.05)
                                                    : AppColors
                                                    .LightGreens,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        9))),
                                            child: countries.type.name !=
                                                "SUPPLIER"
                                                ? boldtext(
                                              AppColors.Green,
                                              10,
                                              "ME",
                                            )
                                                : boldtext(
                                              AppColors.primary,
                                              10,
                                              "Supplier",
                                            )),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) async {
                                  print(val);
                                  setState(() {
                                    subProductValue = null;
                                    subcategotyid = null;
                                    categotyid = null;
                                    categorype = null;
                                    categotyid = val?.id.toString();
                                    categorype = val?.type.name;
                                    val?.type.name == "SUPPLIER"
                                        ? categorype = "supplier"
                                        : categorype = "provider";
                                    subproductcategorydata = [];
                                    subcategoryname="select";
                                  });
                                  sublistData2 = getproductsubAllservice1(categotyid??"", categorype??"");
                                  // await getproductsubAllservice1(
                                  //     categotyid ?? '', categorype ?? '');
                                },
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const Center(
                            child: CircularProgressIndicator(
                              semanticsLabel: "Please Wait",
                            ));
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 20, left: 20, right: 20),
                  child: DropdownButtonFormField<
                      GetProductSubCategorydata?>(
                    value: subProductValue,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                    hint: boldtext(
                        AppColors.black, 14, subcategoryname),
                    isExpanded: true,
                    // value: snapshot.data![0],
                    items: subproductcategorydata?.map((name) {
                      return DropdownMenuItem<
                          GetProductSubCategorydata?>(
                        value: name,
                        child: Row(
                          children: [
                            boldtext(AppColors.black, 13,
                                name?.name ?? ''),
                            const Spacer(),
                          ],
                        ),
                      );
                    }).toList() ??
                        [],
                    onChanged: (val) {
                      subcategotyid = val?.id.toString();
                      subProductValue = val;

                      setState(() {
                        subcategoryname=val!.name??"";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: boldtext(Colors.black, 14, "Service details"),
                ),
                GestureDetector(
                  child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: AppColors.white, width: 1)),
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.file(
                                        _image!,
                                        height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        selectedimage,
                                        height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(17),
                                  ),
                                  border: Border.all(color: AppColors.primary)),
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.upload),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  regulartext(
                                      AppColors.black, 12, "Upload picture")
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        DropdownButtonFormField<ViewWorkProfileModelClass?>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          hint: boldtext(AppColors.black, 14, workprofilename),
                          isExpanded: true,
                          // value: snapshot.data![0],
                          items: workcontroller.viewWorkprofilelist.map((name) {
                            return DropdownMenuItem<ViewWorkProfileModelClass?>(
                              value: name,
                              child: Row(
                                children: [
                                  boldtext(AppColors.black, 13,
                                      "${name.workProfileName}"),
                                  const Spacer(),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            occupationid = val!.workProfileId.toString();
                            print(occupationid);
                          },
                        ),
                      ],
                    )),
                //---------------------------------------------------------------------------------------------------------------------------------------------
                SizedBox(
                  height: 10,
                ),
                textArea(servicenameController, "${widget.title} name"),
                SizedBox(
                  height: 10,
                ),
                textArea(mydescriptionController, "Description"),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: boldtext(Colors.black, 14, "Service range"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: regulartext(AppColors.black, 12, "Min. price"),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: regulartext(AppColors.black, 12, "Max. price"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: textArea(myminpriceController, ""),
                      ),
                      Expanded(
                        child: textArea(mymaxpriceController, ""),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: GestureDetector(
              // onTap: (){
              //   widget.title == 'Product'
              //       ? usertype == "supplier"
              //       ?print("PRODUCTSUPPLIER")
              //       : print("ADDPRODUCT")
              //       : usertype == "supplier"
              //       ? print("SUPPLIERPRODUCT")
              //       :print("ADDSUPPLIER");
              // },

              onTap: () {
                bool emailaddress = RegExp(r'\b.*[a-zA-Z]+.*\b')
                    .hasMatch(servicenameController.text);
                if (categotyid == "0") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Select Category "),
                  ));
                   } else if (subcategoryname == "select") {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Select Sub Category"),
                  ));
                } else if (occupationid == "0") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Select Work Profile"),
                  ));
                  // } else if (_image == null) {
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  // content: Text("Please Select Image"),
                  // ));
                } else if (servicenameController.text.toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Enter Name"),
                  ));
                } else if (emailaddress == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Enter Proper Name!"),
                  ));
                } else if (myminpriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Enter Minimum Price"),
                  ));
                } else if (myminpriceController.text == "0") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Minimum Price Should Be More Then Zero"),
                  ));
                } else if (mymaxpriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Enter Maximum Price"),
                  ));
                } else if (mymaxpriceController.text == "0") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Maximum Price Should Be More Then Zero"),
                  ));
                } else if (mydescriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Enter Description"),
                  ));
                } else {
                  callAddProduct(
                    categotyid.toString(),
                    subcategotyid.toString(),
                    servicenameController.text.toString(),
                    myminpriceController.text.toString(),
                    mymaxpriceController.text.toString(),
                    mydescriptionController.text.toString(),
                    occupationid.toString()
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: boldtext(
                      AppColors.white,
                      20,
                      "Update",
                    )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _removeproduct(context);
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: boldtext(
                      AppColors.white,
                      20,
                      "Remove",
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  callAddProduct(String catid, String subcatId, String name, String minprice,
      String maxprice, String description, String userid) async {
    print("subcatid $subcatId");
    print(
        "Select Sub type of supplier${categorype == "PROVIDER" ? "provider" : "supplier"}");

    String url =
        widget.title == "Product" ? ApiUrl.productAdd : ApiUrl.serviceAdd;
    showLoader(context);
    print(url);

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = usertoken.toString();
      request.fields["id"] = widget.list1.id.toString();
      request.fields["category_id"] = catid;
      request.fields["subcategory_id"] = subcatId;
      request.fields["provider_id"] = UserId;
      request.fields["work_profile_id"] = occupationid.toString();
      request.fields["name"] = name;
      request.fields["min_price"] = minprice;
      request.fields["max_price"] = maxprice;
      request.fields["description"] = description;
      request.fields["type"] = categorype??"";
      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('product_image', _image!.path),
        );
      }
      // request.files.add(await http.MultipartFile.fromPath(
      //     widget.title == "Product" ? "photo" : 'service_image',
      //     (_image!.path)));
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        print(widget.list1.id.toString());
        print(catid);
        print(subcatId);
        print(UserId);
        print(occupationid);
        print(name);
        print(minprice);
        print(maxprice);
        print(description);
        print(categorype);
        hideLoader();
        await Methods1.orderSuccessAlert(context, "Product Updated Successfully");
        await product.viewproductprofile();
        await service.viewsericeprofile();

        hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      hideLoader();

      // hideLoader();
    }
  }



  Widget textArea(TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: hint == "" ? TextInputType.number : TextInputType.text,
        maxLines: hint.contains("Description") ? 4 : 1,
        controller: controller,
        style: textstyle,
        readOnly: hint.contains("Mobile") ? true : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
          counterText: "",
          hintStyle: hintstyle,
          fillColor: AppColors.white,
          filled: true,
          focusColor: AppColors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
          ),
        ),
      ),
    );
  }


  deleteservice() async {
    showLoader(context);
    try {
      final response =
          await http.post(Uri.parse(ApiUrl.deleteproduct), headers: {
        "Authorization": "${USERTOKKEN}"
      }, body: {
        "user_type": categorype,
        "id": widget.list1.id.toString(),
      });

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        await Methods1.orderSuccessAlert(context, "Product Delete Successfully");
        Navigator.of(context).pop();
        hideLoader();
        await product.viewproductprofile();
      } else {}
    } catch (e) {
      hideLoader();

      // hideLoader();
    }
  }

  _removeproduct(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: const EdgeInsets.only(left: 10, right: 10),
            iconPadding: EdgeInsets.zero,
            content: SizedBox(
                height: 245,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(subMenu.image),
                        const SizedBox(
                          width: 10,
                        ),
                        boldtext(AppColors.black, 18, "Delete Product"),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: regulartext(
                        AppColors.black.withOpacity(0.5),
                        14,
                        "Are you sure you want to delete product?",
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: AppColors.logout,
                          ),
                          onPressed: () async {
                            deleteservice();
                          },
                          child: boldtext(
                              AppColors.white, 14, "Confirm Delete product"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: regulartext(AppColors.black, 14, "Cancel"),
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }
}


