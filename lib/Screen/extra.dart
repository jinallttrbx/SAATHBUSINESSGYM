// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_place/google_place.dart';
// import 'package:http/http.dart' as http;
//
// class ToMapScreen extends StatefulWidget {
//   final location;
//   ToMapScreen({Key? key, this.location}) : super(key: key);
//
//   @override
//   State<ToMapScreen> createState() => _ToMapScreenState();
// }
//
// class _ToMapScreenState extends State<ToMapScreen> {
//   late GooglePlace googlePlace;
//   final Completer<GoogleMapController> controller1 = Completer<GoogleMapController>();
//   List<Marker> mark = [];
//   List<AutocompletePrediction> predictions = [];
//   LatLng? markerPosition;
//   LatLng? finalLatLng;
//   Position? _currentPosition;
//   final _startSearchFieldController = TextEditingController();
//   late FocusNode startFocusNode;
//   Timer? _debounce;
//
//   @override
//   void initState() {
//     super.initState();
//     String apiKey = "YOUR_GOOGLE_API_KEY"; // Replace with your Google Maps API key
//     googlePlace = GooglePlace(apiKey);
//     startFocusNode = FocusNode();
//     _getUserLocation();
//   }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
//   }
//
//   Future<String> getAddress(double? lat, double? lang) async {
//     try {
//       if (lat == null || lang == null) {
//         throw Exception('Latitude or longitude is null');
//       }
//
//       List<Placemark> value = await placemarkFromCoordinates(lat, lang);
//       return '${value.first.name}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}-${value.first.postalCode}';
//     } catch (e) {
//       return 'Error: Failed to get address. Please try again later.';
//     }
//   }
//
//   addMarker(LatLng position) async {
//     final markerIcon = await getBytesFromAsset('assets/map_marker.png', 150);
//     finalLatLng = position;
//     Marker newMarker = Marker(
//       icon: BitmapDescriptor.fromBytes(markerIcon),
//       markerId: const MarkerId('id'),
//       position: LatLng(position.latitude, position.longitude),
//     );
//     mark.add(newMarker);
//     setState(() {});
//   }
//
//   _getUserLocation() async {
//     try {
//       bool serviceEnabled;
//       LocationPermission permission;
//
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         throw Exception('Location services are disabled.');
//       }
//
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.deniedForever) {
//         throw Exception('Location permissions are permanently denied.');
//       }
//
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//           throw Exception('Location permissions are denied.');
//         }
//       }
//
//       _currentPosition = await Geolocator.getCurrentPosition();
//       setState(() {
//         finalLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
//         addMarker(finalLatLng!);
//       });
//
//       final GoogleMapController mapController = await controller1.future;
//       mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: finalLatLng!,
//         zoom: 14.0,
//       )));
//     } catch (e) {
//       // If location is not available, fall back to IP-based location
//       _getIpBasedLocation();
//     }
//   }
//
//   Future<void> _getIpBasedLocation() async {
//     try {
//       final response = await http.get(Uri.parse('http://ip-api.com/json'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final double lat = data['lat'];
//         final double lon = data['lon'];
//
//         setState(() {
//           finalLatLng = LatLng(lat, lon);
//           addMarker(finalLatLng!);
//         });
//
//         final GoogleMapController mapController = await controller1.future;
//         mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target: finalLatLng!,
//           zoom: 14.0,
//         )));
//       } else {
//         throw Exception('Failed to get location from IP.');
//       }
//     } catch (e) {
//       print('Error getting IP-based location: $e');
//     }
//   }
//
//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Your Location',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             onMapCreated: (con) => controller1.complete(con),
//             initialCameraPosition: CameraPosition(
//               target: finalLatLng ?? LatLng(0, 0), // Default to (0,0) if no location is available
//               zoom: 14.0,
//             ),
//             zoomControlsEnabled: false,
//             markers: mark.toSet(),
//             onTap: (argument) {
//               addMarker(argument);
//               getAddress(argument.latitude, argument.longitude).then((value) {
//                 _startSearchFieldController.text = value;
//               });
//             },
//           ),
//           Card(
//             margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               padding: const EdgeInsets.all(5),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
//                       controller: _startSearchFieldController,
//                       autofocus: true,
//                       focusNode: startFocusNode,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: InputBorder.none,
//                           hintText: 'Select your location'),
//                       onChanged: (value) {
//                         if (_debounce?.isActive ?? false) _debounce!.cancel();
//                         _debounce = Timer(const Duration(milliseconds: 1000), () {
//                           if (value.isNotEmpty) {
//                             autoCompleteSearch('$value India');
//                           } else {
//                             setState(() {
//                               predictions = [];
//                             });
//                           }
//                         });
//                       },
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: predictions.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(
//                               Icons.pin_drop,
//                               color: Colors.white,
//                             ),
//                           ),
//                           title: Text(predictions[index].description.toString()),
//                           onTap: () async {
//                             FocusManager.instance.primaryFocus?.unfocus();
//                             _startSearchFieldController.text = predictions[index].description.toString();
//                             final placeId = predictions[index].placeId!;
//                             final details = await googlePlace.details.get(placeId);
//
//                             if (details != null && details.result != null && mounted) {
//                               setState(() {
//                                 finalLatLng = LatLng(
//                                     details.result!.geometry!.location!.lat!,
//                                     details.result!.geometry!.location!.lng!);
//                                 predictions = [];
//                               });
//                               addMarker(finalLatLng!);
//                               final GoogleMapController mapController = await controller1.future;
//                               mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//                                 target: finalLatLng!,
//                                 zoom: 14.0,
//                               )));
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             backgroundColor: Colors.blue,
//             onPressed: () {
//               _getUserLocation();
//             },
//             child: const Icon(Icons.gps_fixed),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 30),
//             child: SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                     [finalLatLng, _startSearchFieldController.text],
//                   );
//                 },
//                 child: const Text(
//                   "OK",
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
