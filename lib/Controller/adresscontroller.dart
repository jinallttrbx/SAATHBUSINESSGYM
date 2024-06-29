import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../conts/global_values.dart';

class addressController extends GetxController {
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var address = 'Search for home service...'.obs;

  getlocation() async {

    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
    lat.value = position.latitude;
    long.value = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    await sendUserLocation(
        position.latitude.toString(), position.longitude.toString());
    Placemark place = placemarks[0];
    address.value = '${place.street}, ${place.subLocality}, ${place.locality},';

  }

  Future<void> sendUserLocation(String lat, String lng) async {
    try {
      Map<String, String> requestBody = <String, String>{
        'latitude': lat,
        'longitude': lng
      };
      final response = await http.post(
        Uri.parse(ApiUrl.updatelocation),
        headers: {'Authorization': USERTOKKEN.toString()},
        body: requestBody,
      );
      if (response.statusCode == 200) {



      } else {

      }
    } catch (e) {

    }
  }

  updatelocation(var latt, var longt, var addresst) {
    lat.value = latt;
    long.value = longt;
    address.value = addresst;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlocation();
  }
}

Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> GetAddressFromLatLong(Position position) async {
  try {
    String Address = 'search';

    List<Placemark> newPlace = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude,
            localeIdentifier: "en");

    Placemark place = newPlace[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality},';

  } catch (e) {

  }
}
