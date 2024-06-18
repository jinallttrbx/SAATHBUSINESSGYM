import 'dart:convert';
import 'dart:io';
import 'package:businessgym/Controller/productController.dart';
import 'package:businessgym/Controller/profileController.dart';
import 'package:businessgym/Controller/serviceController.dart';
import 'package:businessgym/components/decor.dart';
import 'package:businessgym/components/snackbar.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Controller/workprofileController.dart';
import 'package:businessgym/model/GetProductSubcategory.dart';
import 'package:businessgym/model/getSupplierProductCategory.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
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
import '../../../model/viewWork_profileModel.dart';
import '../../../values/Colors.dart';

class ProviderServiceAddScreen extends StatefulWidget {
  String title;
  final bool isEdit;

  ProviderServiceAddScreen(
      {super.key, required this.title, required this.isEdit});

  @override
  ProviderServiceAddScreenState createState() =>
      ProviderServiceAddScreenState();
}

class ProviderServiceAddScreenState extends State<ProviderServiceAddScreen> {
  String Categotyid = "0";
  List Categorylist = [];
  List<GetProductCategorydata> productcategory = [];
  List<GetServiceCategorydata> servicecategory = [];
  List<String> categoryNames = [];
  List subcategory = [];
  List<GetProductSubCategorydata> subcategorylist = [];
  List<String> subcategoryNames = [];
  var _chosenCategory = null;
  var _chosensubcategory = null;
  String typename = "";
  String subcatid = "";
  final service = Get.find<ServiceController>();
  final product = Get.find<ProductController>();
  final serviceController = TextEditingController();
  final myminpriceController = TextEditingController();
  final mymaxpriceController = TextEditingController();
  final mydescriptionController = TextEditingController();
  SharedPreference _sharedPreference = SharedPreference();
  List<GetServiceCategorydata?>? servicecategorydata = [];
  List<GetProductCategorydata?>? productcategorydata = [];
  bool _isLoading = false;
  final SharedPreference _prefs = SharedPreference();
  List<GetServiceSubCategorydata?>? subservicecategorydata = [];
  List<GetProductSubCategorydata?>? subproductcategorydata = [];
  final workcontroller = Get.find<WorkProfileController>();
  String UserId = "";
  String? usertoken = "";
  String usertype = "";
  String? categotyid;
  String? categorype;
  String? subcategotyid;
  String? occupationid;
  String dropdownValue = 'Mode of Business';
  String dropdownValueoccupation = '';
  String work_profileId = '';

  File? _image;
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
    super.initState();
    if (widget.isEdit) {
      serviceController.text = widget.isEdit.toString();
    }

    getuserType();
    setState(() {});
  }

  void getuserType() async {
    usertype = await _sharedPreference.isUserType();
    UserId = await _sharedPreference.isUsetId();
    usertoken = await _sharedPreference.isToken();
    await getservicecategory();
    await getproductcategory();
    setState(() {});
  }

  Future<void> getproductcategory() async {
    productcategorydata = [];
    try {
      showLoader(context);
      final response = await http.get(Uri.parse(ApiUrl.getsupplierproductlist),
          headers: {"Authorization": USERTOKKEN.toString()});

      if (response.statusCode == 200) {
        hideLoader();
        GetProductCategory? allServiceModel =
            GetProductCategory.fromJson(jsonDecode(response.body));

        productcategorydata?.addAll(allServiceModel.data);
        setState(() {});
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getservicecategory() async {
    servicecategorydata = [];
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
        servicecategorydata?.addAll(allServiceModel.data);
        setState(() {});
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getsubAllservice1(String id, String type) async {
    subservicecategorydata = [];
    try {
      final response = await http.get(
          Uri.parse(
              "${ApiUrl.getservicesubcategorylist}category_id=$id&type=$type"),
          headers: {"Authorization": USERTOKKEN.toString()});
      if (response.statusCode == 200) {
        GetServiceSubCategory? allServiceModel =
            GetServiceSubCategory.fromJson(jsonDecode(response.body));
        subservicecategorydata?.addAll(allServiceModel.data);
        setState(() {});
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getproductsubAllservice1(String id, String type) async {
    subproductcategorydata = [];
    try {
      final response = await http.get(
          Uri.parse(
              "${ApiUrl.getproductsubcategorylist}category_id=$id&type=$type"),
          headers: {"Authorization": USERTOKKEN.toString()});
      if (response.statusCode == 200) {
        GetProductSubCategory? allServiceModel =
            GetProductSubCategory.fromJson(jsonDecode(response.body));

        subproductcategorydata?.addAll(allServiceModel.data);
        setState(() {});
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e);
    }
  }

  GetServiceCategorydata? serviceValue;
  GetProductCategorydata? productValue;
  GetServiceSubCategorydata? subServiceValue;
  GetProductSubCategorydata? subProductValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: APPBar(title: "Add ${widget.title} "),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.title != "Product"
                    ? Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: DropdownButtonFormField<GetServiceCategorydata?>(
                          value: serviceValue,
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
                          isExpanded: true,
                          hint:
                              boldtext(AppColors.black, 14, "Select category"),
                          // value: snapshot.data![0],
                          items: servicecategorydata?.map((countries) {
                                return DropdownMenuItem<
                                    GetServiceCategorydata?>(
                                  value: countries,
                                  child: Row(
                                    children: [
                                      boldtext(AppColors.black, 13,
                                          countries?.name ?? ''),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color:
                                                  countries?.type == "supplier"
                                                      ? AppColors.primary
                                                          .withOpacity(0.05)
                                                      : AppColors.LightGreens,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(9))),
                                          child: countries?.type != "supplier"
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
                              }).toList() ??
                              [],
                          onChanged: (val) async {
                            print(val);
                            setState(() {
                              subServiceValue = null;
                              subcategotyid = null;
                              categotyid = null;
                              categorype = null;
                              categotyid = val?.id.toString();
                              categorype = val?.type;
                              val?.type == "supplier"
                                  ? categorype = "supplier"
                                  : categorype = "provider";
                              subservicecategorydata = [];
                            });
                            await getsubAllservice1(
                                categotyid ?? '', categorype ?? '');
                          },
                        ),
                      )
                    : Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: DropdownButtonFormField<GetProductCategorydata?>(
                          value: productValue,
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
                          isExpanded: true,
                          hint:
                              boldtext(AppColors.black, 14, "Select category"),
                          // value: snapshot.data![0],
                          items: productcategorydata?.map((countries) {
                                return DropdownMenuItem<
                                    GetProductCategorydata?>(
                                  value: countries,
                                  child: Row(
                                    children: [
                                      boldtext(AppColors.black, 13,
                                          countries?.name ?? ''),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color: countries?.type.name ==
                                                      "SUPPLIER"
                                                  ? AppColors.primary
                                                      .withOpacity(0.05)
                                                  : AppColors.LightGreens,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(9))),
                                          child:
                                              countries?.type.name != "SUPPLIER"
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
                              }).toList() ??
                              [],
                          onChanged: (val) async {
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
                            });
                            await getproductsubAllservice1(
                                categotyid ?? '', categorype ?? '');
                          },
                        ),
                      ),

                Visibility(
                  visible: categotyid == null ? false : true,
                  child: widget.title != "Product"
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: DropdownButtonFormField<
                              GetServiceSubCategorydata?>(
                            value: subServiceValue,
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
                                AppColors.black, 14, "Select sub category"),
                            isExpanded: true,
                            // value: snapshot.data![0],
                            items: subservicecategorydata?.map((name) {
                                  return DropdownMenuItem<
                                      GetServiceSubCategorydata?>(
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
                              subServiceValue = val;
                              setState(() {});
                            },
                          ),
                        )
                      : Container(
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
                                AppColors.black, 14, "Select Sub Category"),
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
                              setState(() {});
                            },
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: AppColors.white, width: 1)),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Image.file(
                                      _image!,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    AppImages.gellary,
                                    width: 50,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(17),
                                  ),
                                  border: Border.all(color: AppColors.primary)),
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.upload),
                                  const SizedBox(
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
                          hint: boldtext(
                              AppColors.black, 14, "Select work profile"),
                          isExpanded: true,
                          // value: snapshot.data![0],
                          items: workcontroller.viewWorkprofilelist.map((name) {
                            return DropdownMenuItem<ViewWorkProfileModelClass?>(
                              value: name,
                              child: Row(
                                children: [
                                  boldtext(AppColors.black, 13,
                                      name.workProfileName),
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
                const SizedBox(
                  height: 10,
                ),
                textArea(serviceController, "${widget.title} name"),
                const SizedBox(
                  height: 10,
                ),
                textArea(mydescriptionController, "Description"),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: boldtext(Colors.black, 14, "Service range"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: regulartext(AppColors.black, 12, "Min. price"),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: regulartext(AppColors.black, 12, "Max. price"),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: textArea(myminpriceController, "Min. price"),
                      ),
                      Expanded(
                        child: textArea(mymaxpriceController, "Max. price"),
                      )
                    ],
                  ),
                ),

                GestureDetector(


                  onTap: () {
                    bool servicename = RegExp(r'\b.*[a-zA-Z]+.*\b').hasMatch(serviceController.text);

                    if (categotyid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Select Category "),
                      ));
                    } else if (subcategotyid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Select Sub Category"),
                      ));
                    } else if (occupationid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Select Work Profile"),
                      ));
                    } else if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Select Image"),
                      ));
                    } else if (serviceController.text.toString().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Name"),
                      ));
                    } else if (servicename == false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Proper Name!"),
                      ));
                    } else if (myminpriceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Minimum Price"),
                      ));
                    } else if (myminpriceController.text == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Minimum Price Should Be More Then Zero "),
                      ));
                    } else if (mymaxpriceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Maximum Price"),
                      ));
                    } else if (mymaxpriceController.text == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Maximum Price Should Be More Then Zero "),
                      ));
                    } else if (mydescriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Description"),
                      ));
                    } else {
                      callAddProduct(
                          categotyid ?? '',
                          subcategotyid ?? '',
                          serviceController.text.toString(),
                          myminpriceController.text.toString(),
                          mymaxpriceController.text.toString(),
                          mydescriptionController.text.toString(),
                          work_profileId,
                          UserId);
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
                          "Add ${widget.title}",
                        )),
                      ],
                    ),
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
    );
  }

  callAddProduct(
      String catid,
      String subcatId,
      String name,
      String minprice,
      String maxprice,
      String description,
      String workprofileId,
      String userid) async {
    print("subcatid $subcatId");
    print(categorype);
    String url =
        widget.title == "Product" ? ApiUrl.productAdd : ApiUrl.serviceAdd;
    showLoader(context);
    print(url);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = usertoken.toString();
      request.fields["category_id"] = catid;
      request.fields["subcategory_id"] = subcatId;
      request.fields["provider_id"] = userid;
      request.fields["work_profile_id"] = occupationid.toString();
      request.fields["name"] = name;
      request.fields["min_price"] = minprice;
      request.fields["max_price"] = maxprice;
      request.fields["description"] = description;
      widget.title == "Product"
          ? request.fields["type"] = categorype ?? ''
          : request.fields["user_type"] = categorype ?? '';
      request.files.add(await http.MultipartFile.fromPath(
          widget.title == "Product" ? "product_image" : 'service_image',
          (_image!.path)));
      await request.send().then((value) async {
        String result = await value.stream.bytesToString();
        print("result  $result");
        print(
            "$catid,$subcatId,$userid,$usertype,$occupationid,$name,$minprice,$maxprice,$description,${_image!.path}");
        hideLoader();
        widget.title == "Product" ?  await Methods1.orderSuccessAlert(context, "Product Added Successfully") :  await Methods1.orderSuccessAlert(context, "Service Added Successfully");
        await service.viewsericeprofile();
        await product.viewproductprofile();


        hideLoader();
      });
    } catch (e) {
      print("exception" + e.toString());
      hideLoader();
      //  showInSnackBar("Http Error Try Again Later $e");
      // hideLoader();
    }
  }

  Widget textArea(TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: TextField(
        // inputFormatters: [
        //   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))
        // ],
        textCapitalization: hint == "Description"
            ? TextCapitalization.sentences
            : TextCapitalization.words,
        keyboardType: hint == "Description" || hint == "${widget.title} name"
            ? TextInputType.text
            : TextInputType.number,
        maxLines: hint.contains("Description") ? 4 : 1,
        controller: controller,
        style: textstyle,
        readOnly: hint.contains("Mobile") ? true : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: hint,
          counterText: "",
          hintStyle: hintstyle,
          fillColor: AppColors.BGColor,
          filled: true,
          focusColor: AppColors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.white, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.white, width: 1.0),
          ),
        ),
      ),
    );
  }


}


