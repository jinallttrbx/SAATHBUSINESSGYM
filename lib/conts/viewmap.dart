import 'dart:convert';

import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/conts/appbar_global.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../values/const_text.dart';

import 'global_values.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  TextEditingController search = TextEditingController();
  var uuid = const Uuid();
  String? _sessiontoken;
  bool viewMap = true;
  bool loading = false;
  List<dynamic> _placesList = [];
  // GoogleMapP _places = GoogleMapsPlaces(apiKey: GOOGLE_MAP_API);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search.addListener(() {
      onchange();
    });
  }

  onchange() {
    if (_sessiontoken == null) {
      setState(() {
        _sessiontoken = uuid.v4();
        loading = true;
        viewMap = false;
      });
    }
    getSuggestion(search.text);
  }

  void getSuggestion(String input) async {
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseURL?input=$input&key=${Global.Google_Api_Key}&sessiontoken=$_sessiontoken";
    var response = await http.get(Uri.parse(request));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      _placesList = jsonDecode(response.body.toString())['predictions'];
      setState(() {
        loading = false;
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: APPBar(title: 'Current Location'),
      body: GetX<addressController>(builder: (controller) {
        return SizedBox(
          child: Column(
            children: [
              Stack(
                children: [
                  viewMap
                      ? SizedBox(
                          width: Get.width,
                          height: Get.height * 0.84,
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(controller.lat.value,
                                    controller.long.value),
                                zoom: 11.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId('place_name'),
                                  position: LatLng(controller.lat.value,
                                      controller.long.value),
                                  icon: BitmapDescriptor.defaultMarker,
                                  // icon: BitmapDescriptor.,
                                  infoWindow: const InfoWindow(
                                    title: 'Current',
                                    snippet: 'address',
                                  ),
                                ),
                              }),
                        )
                      : Container(
                          width: Get.width,
                          height: Get.height * 0.8,
                          padding: const EdgeInsets.only(top: 60),
                          child: loading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  itemCount: _placesList.length,
                                  itemBuilder: ((context, index) {
                                    return ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: boldtext(
                                          Colors.black54,
                                          12,
                                          _placesList[index]['description']
                                              .toString()),
                                      onTap: () async {
                                        try {
                                          List<Location> locations =
                                              await locationFromAddress(
                                                  _placesList[index]
                                                          ['description']
                                                      .toString(),
                                                  localeIdentifier: "en");
                                          controller.updatelocation(
                                              locations[0].latitude,
                                              locations[0].latitude,
                                              _placesList[index]
                                                  ['description']);
                                          setState(() {
                                            viewMap = true;
                                            search.clear();
                                          });
                                          print(locations[0]);
                                          print(_placesList[index]);
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      },
                                    );
                                    // Text(_placesList[index]['description'].toString());
                                  }))),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          // style: textfieldtextstyle,
                          controller: search,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                viewMap = true;
                                loading = false;
                              });
                            }
                            // provider.changecurrent(value);
                          },
                          onTap: () {
                            setState(() {
                              viewMap = false;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Your Location',
                              prefixIcon: const Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 10,
                              ),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    search.clear();
                                    setState(() {
                                      loading = false;
                                      viewMap = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey[300],
                                  )),
                              contentPadding: const EdgeInsets.only(left: 25),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.black87)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.black87)),
                              fillColor: Colors.white),
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
