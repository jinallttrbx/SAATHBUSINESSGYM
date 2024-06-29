import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class ToMapScreen extends StatefulWidget {
  final location;
  ToMapScreen({Key? key, this.location}) : super(key: key);

  @override
  State<ToMapScreen> createState() => _ToMapScreenState();
}

class _ToMapScreenState extends State<ToMapScreen> {
  late GooglePlace googlePlace;
  final Completer<GoogleMapController> controller1 = Completer<GoogleMapController>();
  List<Marker> mark = [];
  List<AutocompletePrediction> predictions = [];
  LatLng? markerPosition;
  LatLng? finalLatLng;
  Position? _currentPosition;
  final _startSearchFieldController = TextEditingController();
  late FocusNode startFocusNode;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = Global.map_api_key;
    googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();
    _getUserLocation();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<String> getAddress(double? lat, double? lang) async {
    try {
      if (lat == null || lang == null) {
        throw Exception('Latitude or longitude is null');
      }

      List<Placemark> value = await placemarkFromCoordinates(lat, lang);
      return '${value.first.name}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}-${value.first.postalCode}';
    } catch (e) {
      return 'Error: Failed to get address. Please try again later.';
    }
  }

  addMarker(LatLng position) async {
    final markerIcon = await getBytesFromAsset(AppImages.mapmarker, 150);
    finalLatLng = position;
    Marker newMarker = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId: const MarkerId('id'),
      position: LatLng(position.latitude, position.longitude),
    );
    mark.add(newMarker);
    setState(() {});
  }

  _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      finalLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      addMarker(finalLatLng!);
    });

    final GoogleMapController mapController = await controller1.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: finalLatLng!,
      zoom: 14.0,
    )));
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Your Location',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (con) => controller1.complete(con),
            initialCameraPosition: CameraPosition(
              target: finalLatLng ?? LatLng(23.1141798, 72.54025709999999),
              zoom: 14.0,
            ),
            zoomControlsEnabled: false,
            markers: mark.toSet(),
            onTap: (argument) {
              addMarker(argument);
              getAddress(argument.latitude, argument.longitude).then((value) {
                _startSearchFieldController.text = value;
              });
            },
            onCameraMove: (position) {
              addMarker(LatLng(position.target.latitude, position.target.longitude));
              getAddress(position.target.latitude, position.target.longitude).then((value) {
                _startSearchFieldController.text = value;
              });
            },
          ),
          Card(
            margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
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
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(const Duration(milliseconds: 1000), () {
                          if (value.isNotEmpty) {
                            autoCompleteSearch('$value India');
                          } else {
                            setState(() {
                              predictions = [];
                            });
                          }
                        });
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(
                              Icons.pin_drop,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(predictions[index].description.toString()),
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _startSearchFieldController.text = predictions[index].description.toString();
                            final placeId = predictions[index].placeId!;
                            final details = await googlePlace.details.get(placeId);

                            if (details != null && details.result != null && mounted) {
                              setState(() {
                                finalLatLng = LatLng(
                                    details.result!.geometry!.location!.lat!,
                                    details.result!.geometry!.location!.lng!);
                                predictions = [];
                              });
                              addMarker(finalLatLng!);
                              final GoogleMapController mapController = await controller1.future;
                              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                target: finalLatLng!,
                                zoom: 14.0,
                              )));
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.primary,
            onPressed: () {
              _getUserLocation().then((value) async {


                // marker added for current users location
                addMarker(
                  LatLng(value.latitude, value.longitude),
                );

                //to add current address in search area field
                try {
                  getAddress(
                    value.latitude,
                    value.longitude,
                  ).then((value) {
                    _startSearchFieldController.text = value;
                  });
                } catch (e) {

                }

                // specified current users location
                CameraPosition cameraPosition = new CameraPosition(
                  target: LatLng(value.latitude, value.longitude),
                  zoom: 14,
                );

                final GoogleMapController _controller = await controller1.future;
                _controller.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {});
              });
            },
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: () {

                  Navigator.pop(
                    context,
                    [finalLatLng, _startSearchFieldController.text],
                  );
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
      // floatingActionButton: Column(
      //   mainAxisSize: MainAxisSize.min,
      //    crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       backgroundColor:AppColors.primary,
      //       onPressed: () {
      //         _getUserLocation();
      //        // Navigator.pop(context, [finalLatLng, _startSearchFieldController.text]);
      //       },
      //       child: const Icon(Icons.gps_fixed),
      //     ),
      //   Padding(
      //       padding: const EdgeInsets.only(left: 30),
      //       child: SizedBox(
      //         height: 50,
      //         width: double.infinity,
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               backgroundColor: AppColors.primary),
      //           onPressed: () {
      //
      //             Navigator.pop(
      //               context,
      //               [finalLatLng, _startSearchFieldController.text],
      //             );
      //           },
      //           child: Text(
      //             "OK",
      //           ),
      //         ),
      //       ),
      //     ),
      //     // FloatingActionButton(
      //     //   backgroundColor: Colors.blue,
      //     //   onPressed: () {
      //     //     Navigator.pop(context, [finalLatLng, _startSearchFieldController.text]);
      //     //   },
      //     //   child: const Icon(Icons.check),
      //     // ),
      //   ],
      // )

    );
  }
}
