import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math' show cos, sqrt, asin, pi, pow, sin;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../../../Controllers/landingpage_controller.dart';
import '../../../Model/suggestionairport.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/commonSnackbar.dart';
// import 'package:satoshi/Utils/app_text_styles.dart';

class DestinationFerryController extends GetxController {
  bool isLoading = true;
  bool isStopped = false;
  bool soundPlayed = false;
  bool showMap = true ;


  RxBool isSearchLoading = true.obs;

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  Rx<TextEditingController> from = TextEditingController().obs;
  Rx<TextEditingController> to = TextEditingController().obs;
  Rx<TextEditingController> search = TextEditingController().obs;

  final kInitialPosition = const LatLng(-33.8567844, 151.213108);

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();

  // For Location Purpose
  double lat = 0.0;
  double long = 0.0;

// <---- Live ----->
  double livelat = 0.0;
  double livelong = 0.0;

  String apikey = "AIzaSyCrY92DPLOQXPHEUzoN9vjQvrX5NtOAVjk";

  double latfrom = 0.0;
  double longfrom = 0.0;

  double latto = 0.0;
  double longto = 0.0;

  List<Placemark> placemarksFrom = [];
  List<Placemark> placemarksTo = [];

  String fromCountry = '';
  String toCountry = '';

  RxList<CityAirport> suggestionList = <CityAirport>[].obs;

  String radius = "15";

  List nearbyLoc = [];

  // <--------- Google Map ----------->
  late GoogleMapController googleMapController;

  LatLng currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void onInit() {
    showMap;
    update();
    soundPlayed;
    update();
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (isStopped == true) {
        t.cancel();
      } else {
        getLatLngLive();
      }
    });
    super.onInit();
  }

  @override
  void onReady() async {
    getLatLong();
    // addPolyLine();
    isLoading = false;
    update();
    isSearchLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    googleMapController.dispose();
    super.onClose();
  }

  //<--------- For Current Location ----------->

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CommonToast.getToast(
        'Location services are disabled.',
      );

      // CommonSnackbar.getSnackbar(
      //     "Warning", "Location services are disabled.", Colors.blue);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CommonToast.getToast(
          'Location permissions are denied',
        );
        // CommonSnackbar.getSnackbar(
        //     "Warning", "Location permissions are denied", Colors.blue);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonToast.getToast(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      // CommonSnackbar.getSnackbar(
      //     "Warning",
      //     "Location permissions are permanently denied, we cannot request permissions.",
      //     Colors.blue);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = determinePosition();
    data.then((value) async {
      if (kDebugMode) {
        print("Lat Long is $value");
      }
      lat = value.latitude;
      long = value.longitude;
      getAddressFrom(value.latitude, value.longitude, isDirectCall: true);
      // getNearbyPlaces(value.latitude, value.longitude);
      currentLatLng = LatLng(value.latitude, value.longitude);
      update();
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            target: LatLng(lat, long),
            zoom: 10.0,
          ),
        ),
      );
      update();
      // call function for convert lat long to address
      // getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      if (kDebugMode) {
        print("Error $error");
      }
    });
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    try {
      lat = lat;
      long = long;
      update();
    } catch (E) {
      if (kDebugMode) {
        print("Get Address error is ${E.toString()}");
      }
    }
  }

  Future<void> getNearbyPlaces(double lat, double long) async {
    try {
      if (kDebugMode) {
        print("object");
      }
      nearbyLoc.clear();
      update();
      var url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&key=$apikey&type=airport');
      var response = await http.post(url);
      var d = json.decode(response.body);
      print("Near Airport ${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        nearbyLoc.addAll(d['results']);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Check Error is ${e.toString()}");
      }
    }
  }

  getAddressFrom(lat, long,
      {bool isTo = false, bool isDirectCall = false}) async {
    try {
      placemarksFrom.clear();
      update();
      print("Check Lat $lat");
      print("Check lng $long");
      String code = await getCountryCode(lat, long);
      update();
      if (isDirectCall) {
        print("Code is $code");
        fromCountry = code;
        update();
        placemarksFrom = await placemarkFromCoordinates(lat, long);

        // < Add function f
        if (placemarksFrom[0].locality == null ||
            placemarksFrom[0].locality.toString() == '') {
          final LocatitonGeocoder geocoder = LocatitonGeocoder(apikey);
          final address = await geocoder
              .findAddressesFromCoordinates(Coordinates(lat, long));
          String c = '';
          address.forEach((element) {
            if (element.locality.toString() != 'null') {
              c = element.locality!;
            }
            print("check Geocoder address ${element.locality}");
          });
          await getDataMapApi(c);

          update();
        } else {
          await getDataMapApi(placemarksFrom[0].locality!);

          update();
        }
      }
      if (isTo) {
        toCountry = code;
        update();
        // if (placemarksFrom[0].locality == null || placemarksFrom[0].locality.toString() == '') {
        //   print("Locality");

        //   update();
        //   final LocatitonGeocoder geocoder = LocatitonGeocoder(apikey);
        //   final address = await geocoder
        //       .findAddressesFromCoordinates(Coordinates(lat, long));
        //   address.forEach((element) {
        //     if (element.locality.toString() != 'null') {
        //       if (element.locality!.length <= 3) {
        //         toCountry = '${element.locality} ${element.subLocality}';
        //         update();
        //       } else {
        //         toCountry = element.locality!;
        //         update();
        //       }
        //     }
        //   });

        //   update();
        //   print("Check Address $toCountry");
        //   if(toCountry == '')
        //     {
        //       print("To is call");
        //       toCountry  = await getCityNameFromCoordinates(lat , long , apikey);
        //       update();
        //     }
        // } else {
        //   if (placemarksFrom[0].locality!.length <= 3) {
        //     toCountry =
        //         '${placemarksFrom[0].locality} ${placemarksFrom[0].subLocality}';
        //     update();
        //   } else {
        //     toCountry = placemarksFrom[0].locality!;
        //     update();
        //   }
        // }
      } else {
        fromCountry = code;
        update();
        // print("Cehck is call");
        // if (placemarksFrom[0].locality == null ||
        //     placemarksFrom[0].locality.toString() == '') {

        //   update();
        //   final LocatitonGeocoder geocoder = LocatitonGeocoder(apikey);
        //   final address = await geocoder
        //       .findAddressesFromCoordinates(Coordinates(lat, long));
        //   address.forEach((element) {
        //     if (element.locality.toString() != 'null') {
        //       if (element.locality!.length <= 3) {
        //         fromCountry = '${element.locality} ${element.subLocality}';

        //         update();
        //       } else {
        //         fromCountry = element.locality!;

        //         update();
        //       }
        //     }
        //     print("check Geocoder address ${element.locality}");
        //   });

        //   update();
        //   if(fromCountry == '')
        //   {
        //     fromCountry  = await getCityNameFromCoordinates(lat , long , apikey);
        //     update();
        //   }
        //   // print("check Geocoder address ${address}");
        // } else {
        //   print("Cehck is call ${placemarksFrom[0].locality}");
        //   if (placemarksFrom[0].locality!.length <= 3) {
        //     fromCountry =
        //         '${placemarksFrom[0].locality!} ${placemarksFrom[0].subLocality}';

        //     update();
        //   } else {
        //     fromCountry = placemarksFrom[0].locality!;

        //     update();
        //   }
        // }
      }
      update();
      print("Address ${placemarksFrom.toString()}");
      // from.value.text = placemarksFrom[0].locality!;

      // await getSuggestions(placemarksFrom[0].locality!);
    } on SocketException catch (s) {
      if (kDebugMode) {
        print("Socket expection ${s.toString()}");
      }
    } catch (E) {
      if (kDebugMode) {
        print("Get Address error is ${E.toString()}");
      }
    }
  }

  // <--------- Get Airporst from Map Api's ------->

  Future<void> getDataMapApi(String name) async {
    try {
      var res = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$name&key=$apikey&type=airport'));
      var data = json.decode(res.body);
      // print("Map Api's Response $data");
      from.value.text = data['predictions'][0]['description'];
      update();
      await getDataMapApiprediction(data['predictions'][0]['place_id']);
    } catch (e) {
      print("Check Data ${e.toString()}");

      update();
    }
  }

  Future<void> getDataMapApiprediction(String placeId) async {
    try {
      var res = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apikey'));
      var data = json.decode(res.body);
      // print("Map Api's Response $data");
      print("Function call to");
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            target: LatLng(
                double.parse(
                    data['result']['geometry']['location']['lat'].toString()),
                double.parse(
                    data['result']['geometry']['location']['lng'].toString())),
            zoom: 13.0,
          ),
        ),
      );
      update();
      latfrom = double.parse(
          data['result']['geometry']['location']['lat'].toString());
      longfrom = double.parse(
          data['result']['geometry']['location']['lng'].toString());
      getAddressFrom(
        double.parse(data['result']['geometry']['location']['lat'].toString()),
        double.parse(data['result']['geometry']['location']['lng'].toString()),
      );
      final Uint8List markerIcon =
          await getBytesFromAsset(AppConstants.airplane, 100);
      addMarker(
          LatLng(
              double.parse(
                  data['result']['geometry']['location']['lat'].toString()),
              double.parse(
                  data['result']['geometry']['location']['lng'].toString())),
          "1",
          BitmapDescriptor.fromBytes(markerIcon));
      List<LatLng> listofPloylines = [
        LatLng(latfrom, longfrom),
        LatLng(latto, longto),
      ];
      addPolyLine(listofPloylines);
      update();
    } catch (e) {
      print("Check Data ${e.toString()}");

      update();
    }
  }

  bool isFromAddressTrue() {
    if (placemarksFrom.any((e) => e.name!.toLowerCase().contains("airport"))) {
      return true;
    } else if (placemarksFrom
        .any((e) => e.name!.toLowerCase().contains("airport"))) {
      return true;
    }
    return false;
  }

  getAddressTo(lat, long) async {
    if (kDebugMode) {
      print("location function call");
    }
    try {
      placemarksTo.clear();
      update();
      placemarksTo = await placemarkFromCoordinates(lat, long);
      // toCountry = placemarksTo[0].country!;
      update();
    } on SocketException catch (s) {
      if (kDebugMode) {
        print("Socket expection ${s.toString()}");
      }
    } catch (E) {
      if (kDebugMode) {
        print("Get Address error is ${E.toString()}");
      }
    }
  }

  bool isToAddressTrue() {
    if (placemarksTo.any((e) => e.name!.toLowerCase().contains("airport"))) {
      return true;
    } else if (placemarksTo
        .any((e) => e.street!.toLowerCase().contains("airport"))) {
      return true;
    }
    return false;
  }

  bool isAddressCorrect() {
    if (kDebugMode) {
      print("check lat $latfrom");
      print("check lng $longfrom");
    }
    if (nearbyLoc.any((e) =>
        e['geometry']['location']['lat'] == latfrom &&
        e['geometry']['location']['lng'] == longfrom)) {
      return true;
    }
    return false;
  }

  // <------- Calculate Distance ---------->

  double distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a =
        _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));

    return r * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  num _haversin(double radians) => pow(sin(radians / 2), 2);

  Future<void> getSuggestions(String c) async {
    try {
      print("Function Call ");
      isSearchLoading.value = true;
      suggestionList.clear();
      var res = await http.get(Uri.parse(
          'https://api-flight-booking.travala.com/v2/suggestion/typeahead?q=$c'));
      var data = json.decode(res.body);
      log("check Data Suggestion: $data");
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        data['places_suggestions'].forEach((e) {
          suggestionList.add(CityAirport.fromJson(e));
        });
        // for (var element in suggestionList) {
        //   print("Element ${element.name}");
        // }
        isSearchLoading.value = false;
      } else {
        isSearchLoading.value = false;
      }
    } catch (e) {
      isSearchLoading.value = false;
      print("Suggestion Api Error ${e.toString()}");
    }
  }

  addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
    update();
  }

  addPolyLine(List<LatLng> listofPloylines) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: listofPloylines,
      width: 2,
    );
    polylines[id] = polyline;
    update();
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

  getLatLngLive() async {
    Future<Position> data = determinePosition();
    data.then(
      (value) async {
        livelat = value.latitude;
        livelong = value.longitude;
        update();
      },
    );
  }

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.checkInSound));
  }

  Future<String> getCityNameFromCoordinates(
      double latitude, double longitude, String apiKey) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          List<dynamic> results = data['results'];
          for (var result in results) {
            for (var addressComponent in result['address_components']) {
              List<dynamic> types = addressComponent['types'];
              if (types.contains('locality') || types.contains('political')) {
                return addressComponent['long_name'];
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return "City not found";
  }

  Future<String> getCountryCode(double lat, double lng) async {
    var res = await http.get(Uri.parse('http://iatageo.com/getCode/$lat/$lng'));
    var data = json.decode(res.body);
    return data['IATA'];
  }
}
