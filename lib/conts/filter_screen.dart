// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:convert';

import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/model/CategoryProviderModel.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../Utils/ApiUrl.dart';
import '../model/getSupplierProductCategory.dart';

class filterscreen extends StatefulWidget {
  final List? categoryList;
  final String? catType;
  final String? rating;
  final String? lat;
  final String? lng;
  final String? openAt;
  final String? closeAt;
  final double? min;
  final double? max;
  const filterscreen(
      {super.key,
        this.categoryList,
        this.rating,
        this.lat,
        this.lng,
        this.openAt,
        this.closeAt,
        this.min,
        this.max,
        this.catType});

  @override
  State<filterscreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<filterscreen> {
  // List<String> selectedServices = [];
  TextEditingController search = TextEditingController();
  int selectedOption = 1;
  String? dropdownvalue1;
  String? dropdownvalue2;
  var items1 = [
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM'
  ];
  var items2 = [
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM'
  ];

  final double _min = 0.0;
  final double _max = 10000.0;
  SfRangeValues _values = const SfRangeValues(1000.0, 2000.0);

  List<GetServiceCategorydata>? servicecategorydata = [];
  List<GetProductCategorydata>? productcategorydata = [];
  @override
  void initState() {
    String apiKey = 'AIzaSyDol_h12uYHFgBzADFmC5MfFVkk9tivq-o';
    googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
    if (widget.catType != null) {
      categoryType = widget.catType;
    }
    if (widget.categoryList != null) {
      selectedServices = widget.categoryList ?? [];
    }
    if (widget.rating != null) {
      startrating = widget.rating;
    }
    if (widget.lat != null) {
      lat = widget.lat.toString();
    }
    if (widget.lng != null) {
      lng = widget.lng ?? "";
    }
    if (widget.min != null) {
      _values = SfRangeValues(widget.min, widget.max);
    }
    setState(() {});
    getUserData();
    super.initState();
  }

  Future<List<GetServiceCategorydata>?>? servicecategorylist;
  Future<List<GetProductCategorydata>?>? productcategorylist;

  getUserData() async {
    await getproductcategory();
    await getservicecategory();
  }

  Future<void> getproductcategory() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.getsupplierproductlist),
          headers: {"Authorization": USERTOKKEN.toString()});
      if (response.statusCode == 200) {
        GetProductCategory? allServiceModel =
        GetProductCategory.fromJson(jsonDecode(response.body));
        productcategorydata = allServiceModel.data;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getservicecategory() async {
    try {
      showLoader(context);
      final response = await http.get(Uri.parse(ApiUrl.getsupplierservicelist),
          headers: {"Authorization": USERTOKKEN.toString()});

      if (response.statusCode == 200) {
        hideLoader();
        GetServiceCategory? allServiceModel =
        GetServiceCategory.fromJson(jsonDecode(response.body));
        servicecategorydata = allServiceModel.data;
        setState(() {});
      } else {
        hideLoader();
      }
    } catch (e) {
      print(e);
    }
  }

  var selectedServices = [];
  String? startrating;

  var rangeValue = [];

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  final _startSearchFieldController = TextEditingController();
  Timer? _debounce;
  final _endSearchFieldController = TextEditingController();
  String? lat;
  String? lng;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  String? categoryType = 'Service';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(gradient: bgGradient),
          // ),
          title: boldtext(AppColors.DarkBlue, 16, "Filter"),
          centerTitle: true,
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      selectedServices = [];
                      startrating = null;
                      lat = null;
                      lng = null;
                      dropdownvalue1 = null;
                      dropdownvalue2 = null;
                      _values = const SfRangeValues(1000.0, 2000.0);
                      setState(() {});
                    },
                    child: regulartext(AppColors.primary, 14, "Reset")),
                const SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 'Service',
                      groupValue: categoryType,
                      onChanged: (value) {
                        categoryType = value;
                        selectedServices = [];
                        setState(() {});
                      },
                      title:  boldtext(AppColors.black,16,"Service"),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: 'Product',
                      groupValue: categoryType,
                      onChanged: (value) {
                        categoryType = value;
                        selectedServices = [];
                        setState(() {});
                      },
                      title: boldtext(AppColors.black,16,"Product"),
                    ),
                  )
                ],
              ),
              categoryType != "Product"
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Category"),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ListView.builder(
                          itemCount: servicecategorydata?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: selectedServices.contains(
                                    servicecategorydata?[index].id,
                                  ),
                                  onChanged: (_) {
                                    if (selectedServices.contains(
                                        servicecategorydata?[index].id)) {
                                      selectedServices.remove(
                                        servicecategorydata?[index].id,
                                      );
                                    } else {
                                      selectedServices.add(
                                        servicecategorydata?[index].id,
                                      );
                                    }
                                    setState(() {});
                                  },
                                ),
                                regulartext(AppColors.black,16,
                                  servicecategorydata?[index].name ?? '',
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Category"),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ListView.builder(
                          itemCount: productcategorydata?.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: selectedServices.contains(
                                    productcategorydata?[index].id,
                                  ),
                                  onChanged: (_) {
                                    if (selectedServices.contains(
                                        productcategorydata?[index].id)) {
                                      selectedServices.remove(
                                        productcategorydata?[index].id,
                                      );
                                    } else {
                                      selectedServices.add(
                                        productcategorydata?[index].id,
                                      );
                                    }
                                    setState(() {});
                                  },
                                ),
                                regulartext(AppColors.black,16,
                                  productcategorydata?[index].name ?? '',

                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Rating"),
                  children: [
                    RadioListTile(
                      value: '4',
                      groupValue: startrating,
                      onChanged: (value) {
                        startrating = value;
                        setState(() {});
                      },
                      title:  regulartext(AppColors.black,16,("4+ Rating"),)
                    ),
                    RadioListTile(
                      value: '3',
                      groupValue: startrating,
                      onChanged: (value) {
                        startrating = value;
                        setState(() {});
                      },
                      title:  regulartext(AppColors.black,16,"3 Rating"),
                    ),
                    RadioListTile(
                      value: '2',
                      groupValue: startrating,
                      onChanged: (value) {
                        startrating = value;
                        setState(() {});
                      },
                      title:  regulartext(AppColors.black,16,"2 Rating"),
                    ),
                    RadioListTile(
                      value: '1',
                      groupValue: startrating,
                      onChanged: (value) {
                        startrating = value;
                        setState(() {});
                      },
                      title:  regulartext(AppColors.black,16,"1 Rating"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Location"),
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) {
                            _debounce!.cancel();
                          }
                          _debounce = Timer(
                            const Duration(milliseconds: 1000),
                                () {
                              if (value.isNotEmpty) {
                                autoCompleteSearch('$value India');
                              } else {
                                setState(() {
                                  predictions = [];
                                  startPosition = null;
                                });
                              }
                            },
                          );
                        },
                        minLines: 1,
                        maxLines: 1,
                        controller: _startSearchFieldController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(AppImages.search),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.25),
                            ),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "search location"),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.location_on_outlined,
                              color: Colors.blue),
                          title:
                          regulartext(AppColors.black,16,predictions[index].description.toString()),
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _startSearchFieldController.text =
                                predictions[index].description.toString();
                            final placeId = predictions[index].placeId!;
                            final details =
                            await googlePlace.details.get(placeId);
                            if (details != null &&
                                details.result != null &&
                                mounted) {
                              if (startFocusNode.hasFocus) {
                                setState(() {
                                  startPosition = details.result;
                                  _startSearchFieldController.text =
                                  details.result!.name!;
                                  predictions = [];
                                  lat =
                                      details.result?.geometry?.location?.lat.toString() ??
                                          "";
                                  lng =
                                      details.result?.geometry?.location?.lng.toString() ??
                                          "";
                                });
                              } else {
                                setState(() {
                                  endPosition = details.result;
                                  _endSearchFieldController.text =
                                  details.result!.name!;
                                  predictions = [];
                                  lat =
                                      details.result?.geometry?.location?.lat.toString() ??
                                          "";
                                  lng =
                                      details.result?.geometry?.location?.lng.toString() ??
                                          "";
                                });
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Timing"),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: regulartext(AppColors.black,16,
                                          "Open at",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 45,
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 17, right: 17),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 0.80),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            elevation: 0,
                                            hint:  regulartext(AppColors.black,14,'Select Time'),
                                            value: dropdownvalue1,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items1.map((String items) {
                                              return DropdownMenuItem(
                                                  value: items, child: regulartext(AppColors.black,16,items));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue1 = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: regulartext(AppColors.black,16,
                                          "Close at",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 45,
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 17, right: 17),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 0.80),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            elevation: 0,
                                            hint:  regulartext(AppColors.black,14,'Select Time'),
                                            value: dropdownvalue2,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items2.map((String items) {
                                              return DropdownMenuItem(
                                                  value: items, child: regulartext(AppColors.black,16,items));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue2 = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: ExpansionTile(
                  title:  boldtext(AppColors.black,16,"Price Range"),
                  children: [
                    Column(
                      children: [
                        SfRangeSlider(
                          min: _min,
                          max: _max,
                          values: _values,
                          interval: 2000,
                          showTicks: true,
                          showLabels: true,
                          onChanged: (SfRangeValues value) {
                            setState(() {
                              _values = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: InkWell(
            onTap: () {

              Navigator.pop(
                context,
                {
                  "type": categoryType,
                  "category_id": selectedServices,
                  "rating": startrating,
                  "lat": lat.toString(),
                  "lng": lng.toString(),
                  "open_at": dropdownvalue1,
                  "close_at": dropdownvalue2,
                  "min_price": _values.start.toString(),
                  "max_price": _values.end.toString(),
                },
              );
            },
            child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: boldtext(
                      AppColors.primary,
                      16,
                      "Apply",
                    ),
                  ),
                )),
          ),
        ));
  }
}
