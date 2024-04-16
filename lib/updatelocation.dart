import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/Screen/HomeScreen/DashBoardScreen.dart';
import 'package:businessgym/conts/global_values.dart';

import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class UpdateLOcation extends StatefulWidget {
  const UpdateLOcation({Key? key}) : super(key: key);

  @override
  State<UpdateLOcation> createState() => _ToLocationScreenState();
}

class _ToLocationScreenState extends State<UpdateLOcation> {
  late GooglePlace googlePlace;
  var controller = Get.put(addressController());
  final Completer<GoogleMapController> controller1 =
  Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Marker> mark = [];
  List<AutocompletePrediction> predictions = [];
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  bool isGetLocationBusy = false;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);

    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<String> getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) {
      return "";
    }
    // GeoCode geoCode = GeoCode();
    // try {
    //   Address address =
    //       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    //   print('address');
    //   print(address);
    //   return "${address.city}, ${address.streetAddress}, ${address.countryName}, ${address.postal}";
    // } catch (e) {
    //   return '';
    // }
    else {
      // GeoCode geoCode = GeoCode();
      // try {
      //   Address address =
      //       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
      //   print('address');
      //   print(address);
      //   return "${address.city}, ${address.streetAddress}, ${address.countryName}, ${address.postal}";
      // } catch (e) {
      //   return '';
      // }
      try {
        List<Placemark> value = await placemarkFromCoordinates(
          lat,
          lang,
        );
        print(value);
        return '${value.first.name}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}-${value.first.postalCode}';
      } catch (e) {
        print(e);

        return '';
      }
    }
  }

  Set<Marker> myMarker(LatLng position) {
    _markers.add(Marker(
      markerId: MarkerId(position.toString()),
      position: _mainLocation!,
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
        _mainLocation = position;
      },
    ));
    setState(() {});
    return _markers;
  }

  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;
  LatLng? finalLatLng;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = Global.map_api_key;
    googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
    finalLatLng = LatLng(23.1141798, 72.54025709999999);
    addMarker(finalLatLng!);


  }

  addMarker(LatLng position) async {
    final markerIcon = await getBytesFromAsset(AppImages.mapmarker, 150);
    finalLatLng = position;
    Marker newMarker = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId: const MarkerId('id'),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
    );
    mark.add(newMarker);
    setState(() {});
  }

  Future<void> _goToTheLocation() async {
    final GoogleMapController mapController = await controller1.future;
    await mapController.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(endPosition!.geometry!.location!.lat!,
            endPosition!.geometry!.location!.lng!),
        14));
    // setState(() {});
  }

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  final Set<Marker> _markers = Set();
  LatLng? _mainLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Your Location',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GoogleMap(
            onMapCreated: (con) => controller1.complete(con),
            initialCameraPosition: CameraPosition(
              target: finalLatLng!,
              zoom: 14.0,
            ),
            zoomControlsEnabled: false,
            onCameraIdle: () {
              try {
                getAddress(
                  finalLatLng!.latitude,
                  finalLatLng!.longitude,
                ).then((value) {
                  //  _startSearchFieldController.text = value;
                });
              } catch (e) {
                print(e);
              }
            },
            markers: mark.map((e) => e).toSet(),
            onTap: (argument) {
              // addMarker(argument);
              // try {
              //   getAddress(
              //     argument.latitude,
              //     argument.longitude,
              //   ).then((value) {
              //     _startSearchFieldController.text = value;
              //   });
              // } catch (e) {
              //   print(e);
              // }
            },
            onCameraMove: (position) {
              addMarker(
                  LatLng(position.target.latitude, position.target.longitude));
              // try {
              //   getAddress(
              //     position.target.latitude,
              //     position.target.longitude,
              //   ).then((value) {
              //     _startSearchFieldController.text = value;
              //   });
              // } catch (e) {
              //   print(e);
              // }
            },
          ),
          Card(
            margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              // margin:  EdgeInsets.only(left: 15,right: 15),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _startSearchFieldController,
                          autofocus: true,
                          focusNode: startFocusNode,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: 'Select your location'),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();
                            _debounce =
                                Timer(const Duration(milliseconds: 1000), () {
                                  if (value.isNotEmpty) {
                                    //places api

                                    autoCompleteSearch('$value India');
                                  } else {
                                    //clear out the results
                                    setState(() {
                                      predictions = [];
                                      startPosition = null;
                                    });
                                  }
                                });
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          itemCount: predictions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Divider(color: Colors.grey),
                                ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(
                                      Icons.pin_drop,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    predictions[index].description.toString(),
                                  ),
                                  onTap: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    _startSearchFieldController.text =
                                        predictions[index]
                                            .description
                                            .toString();
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
                                          finalLatLng = finalLatLng = LatLng(
                                              details.result!.geometry!
                                                  .location!.lat!,
                                              details.result!.geometry!
                                                  .location!.lng!);
                                          predictions = [];
                                        });
                                        if (details.result != null) {
                                          addMarker(LatLng(
                                              details.result!.geometry!
                                                  .location!.lat!,
                                              details.result!.geometry!
                                                  .location!.lng!));
                                          final GoogleMapController
                                          mapController =
                                          await controller1.future;
                                          await mapController.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(
                                                      endPosition!.geometry!
                                                          .location!.lat!,
                                                      endPosition!.geometry!
                                                          .location!.lng!),
                                                  zoom: 14),
                                            ),
                                          );
                                          setState(() {});
                                        }
                                      } else {
                                        print("else-------------");

                                        setState(() {
                                          endPosition = details.result;
                                          _endSearchFieldController.text =
                                          details.result!.name!;
                                          finalLatLng = LatLng(
                                              details.result!.geometry!
                                                  .location!.lat!,
                                              details.result!.geometry!
                                                  .location!.lng!);
                                          predictions = [];
                                        });
                                        if (details.result != null) {
                                          print("else if------------");
                                          addMarker(LatLng(
                                              details.result!.geometry!
                                                  .location!.lat!,
                                              details.result!.geometry!
                                                  .location!.lng!));
                                          final GoogleMapController
                                          mapController =
                                          await controller1.future;
                                          await mapController.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(
                                                      endPosition!.geometry!
                                                          .location!.lat!,
                                                      endPosition!.geometry!
                                                          .location!.lng!),
                                                  zoom: 14),
                                            ),
                                          );
                                          setState(() {});
                                        }
                                        print("else-------");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: isGetLocationBusy == true
          //       ? CircularProgressIndicator()
          //       : TextButton.icon(
          //           onPressed: () {
          //             setState(() {
          //               isGetLocationBusy = true;
          //             });
          //             getUserCurrentLocation().then((value) async {
          //               //print("${value.latitude} ${value.longitude}");
          //
          //               // marker added for current users location
          //               // addMarker(
          //               //   LatLng(value.latitude, value.longitude),
          //               // );
          //
          //               //to add current address in search area field
          //               try {
          //                 await getAddress(
          //                   value.latitude,
          //                   value.longitude,
          //                 ).then((value) {
          //                   _startSearchFieldController.text = value;
          //                 });
          //                 setState(() {
          //                   isGetLocationBusy = false;
          //                 });
          //               } catch (e) {
          //                 setState(() {
          //                   isGetLocationBusy = false;
          //                 });
          //                 print(e);
          //               }
          //
          //               // specified current users location
          //               // CameraPosition cameraPosition = new CameraPosition(
          //               //   target: LatLng(value.latitude, value.longitude),
          //               //   zoom: 14,
          //               // );
          //
          //               // final GoogleMapController _controller =
          //               //     await controller.future;
          //               // _controller.animateCamera(
          //               //     CameraUpdate.newCameraPosition(cameraPosition));
          //               // setState(() {});
          //             });
          //           },
          //           icon: Icon(Icons.my_location),
          //           label: Text("Get Location"),
          //         ),
          //),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   backgroundColor: Colors.black,
          //   onPressed: () {
          //     getUserCurrentLocation().then((value) async {
          //       print("${value.latitude} ${value.longitude}");
          //
          //       // marker added for current users location
          //       addMarker(
          //         LatLng(value.latitude, value.longitude),
          //       );
          //
          //       //to add current address in search area field
          //       try {
          //         getAddress(
          //           value.latitude,
          //           value.longitude,
          //         ).then((value) {
          //           _startSearchFieldController.text = value;
          //         });
          //       } catch (e) {
          //         print(e);
          //       }
          //
          //       // specified current users location
          //       CameraPosition cameraPosition = new CameraPosition(
          //         target: LatLng(value.latitude, value.longitude),
          //         zoom: 14,
          //       );
          //
          //       final GoogleMapController _controller = await controller.future;
          //       _controller.animateCamera(
          //           CameraUpdate.newCameraPosition(cameraPosition));
          //       setState(() {});
          //     });
          //   },
          //   child: const Icon(Icons.gps_fixed),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: () {
                  print(finalLatLng?.latitude.toString());
                  print(finalLatLng?.longitude.toString());
                  controller.sendUserLocation(finalLatLng!.latitude.toString(),finalLatLng!.longitude.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
                },
                child: Text(
                  "OK",
                ),
              ),
            ),
          ),
          // FloatingActionButton(
          //   backgroundColor: Colors.black,
          //   onPressed: () async {
          //     Navigator.pop(
          //         context, [finalLatLng, _startSearchFieldController.text]);
          //   },
          //   child: const Text('OK'),
          //   // child: Text('OK'),
          // ),
        ],
      ),
    );
  }
}
