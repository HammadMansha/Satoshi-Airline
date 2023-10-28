import 'dart:async';
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin, pi, pow, sin;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:satoshi/Controllers/flytoearn_controller.dart';
import 'package:satoshi/Utils/api.dart';
import '../../../Controllers/landingpage_controller.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/commonSnackbar.dart';

class ArrivalFerryJetController extends GetxController {
  Rx<TextEditingController> from = TextEditingController().obs;

  bool isLoading = true;
  bool isStopped = false;
  bool showMap = true;

  bool isLoadLoaction = true;

  LandingPageController landingPageController =
  Get.put(LandingPageController());

  FlyToEarnController flyToEarnController =  Get.put(FlyToEarnController());

  // AssetsPageController assetsPageController = Get.find<AssetsPageController>();

  // For Location Purpose
  double lat = 0.0;
  double long = 0.0;

  List nearbyLoc = [];

  final storge = GetStorage();

  // <--------- Google Map ----------->
  // late GoogleMapController googleMapController;

  LatLng currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  // <---- Live ----->

  double livelat = 0.0;
  double livelong = 0.0;

  //<-------- Map --------->

  final Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition initialposition = CameraPosition(
    target: LatLng(
      24.88453,
      67.07886,
    ),
    zoom: 15,
  );

  @override
  Future<void> onInit() async {
    // if (storge.hasData('from') == false) {
    //   await storge.write("from", storge.read('session_from'));
    //   await storge.write("to", storge.read('session_to'));
    //   await storge.write("distance", storge.read('session_totalDistance'));
    //   await storge.write("tokenId", storge.read('session_tokenId'));
    //   await storge.write("time", '${storge.read('session_time')}h');
    // }
    // Timer.periodic(Duration(seconds: 5), (Timer t) {
    //   if (isStopped == true) {
    //     t.cancel();
    //   } else {
    //     getLatLngLive();
    //   }
    // });
    getLatLong();
    super.onInit();
  }

  @override
  void onReady() {
    showMap;
    update();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    // googleMapController.dispose();
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
      update();
      GoogleMapController controller = await googleMapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            target: LatLng(
                storge.read('session_tolat'), storge.read('session_tolng')),
            zoom: 13.0,
          ),
        ),
      );
      // update();
      final Uint8List markerIcon =
      await getBytesFromAsset(AppConstants.airplane, 100);
      addMarker(
          LatLng(
            storge.read('session_lat'),
            storge.read('session_lng'),
          ),
          "1",
          BitmapDescriptor.fromBytes(markerIcon),
          title: storge.read('fromCountry'));
      final Uint8List markerIcon1 =
      await getBytesFromAsset(AppConstants.pin, 100);
      addMarker(
          LatLng(storge.read('session_tolat'), storge.read('session_tolng')),
          "2",
          BitmapDescriptor.fromBytes(markerIcon1),
          title: storge.read('toCountry'));
      List<LatLng> listofPloylines = [
        LatLng(storge.read('session_lat'), storge.read('session_lng')),
        LatLng(storge.read('session_tolat'), storge.read('session_tolng')),
      ];
      update();
      addPolyLine(listofPloylines);
      // await getNearbyPlaces();
    }).catchError((error) {
      if (kDebugMode) {
        print("Error $error");
      }
    });
  }

  Future<void> cancelProcess() async {
    try {
      isLoading = true;
      update();
      String token = await storge.read('token');
      var distance = await storge.read('distance');
      String tokenid = await storge.read('tokenId');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.cancelRecord),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            'distance': distance,
            'tokenId': tokenid,
          },
        ),
      );
      var data = json.decode(res.body);
      print("Check Res body $data");
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        storge.remove('from');
        storge.remove('to');
        storge.remove('distance');
        storge.remove('tokenId');
        storge.remove('time');
        storge.remove('session_from');
        storge.remove('session_to');
        storge.remove('session_totalDistance');
        storge.remove('session_tokenId');
        storge.remove('session_time');
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        isLoading = false;
        update();

        update();
        update();
        CommonToast.getToast(data['showableMessage']);
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(data['showableMessage']);
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Api Error: ${e.toString()}");
    }
  }

  // Future<void> getNearbyPlaces() async {
  //   try {
  //     if (kDebugMode) {
  //       print("object");
  //     }
  //     nearbyLoc.clear();
  //     update();
  //     var url = Uri.parse(
  //         'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=15&key=${destinationController.apikey}');
  //     var response = await http.post(url);
  //     var d = json.decode(response.body);
  //     Get.log("check res ${response.body}");
  //     if (response.statusCode >= 200 && response.statusCode <= 300) {
  //       nearbyLoc.addAll(d['results']);
  //       update();
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Check Error is ${e.toString()}");
  //     }
  //     isLoading = false;
  //     update();
  //   }
  // }

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

  addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      {String? title}) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      infoWindow: InfoWindow(title: title),
    );
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
    isLoadLoaction = false;
    update();
    if (landingPageController.isSound) {
      playSoundEffect();
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

  // getLatLngLive() async {
  //   Future<Position> data = determinePosition();
  //   data.then(
  //     (value) async {
  //       livelat = value.latitude;
  //       livelong = value.longitude;
  //       update();
  //     },
  //   );
  // }
  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.checkInSound));
  }
}
