import 'dart:async';
import 'dart:math' show cos, sqrt, asin, pi, pow, sin;
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

import '../../../Utils/commonSnackbar.dart';


class FlyToEarnFerryController extends GetxController {
  bool isLoading = true;
  bool isStopped = false;

  LandingPageController landingPageController =
  Get.put(LandingPageController());

  final storage = GetStorage();

  RxDouble minitingValue = 0.0.obs;

  @override
  void onInit() async {
    if (storage.hasData('from') == false) {
      await storage.write("from",
          LatLng(storage.read('session_lat'), storage.read('session_lng')));
      await storage.write("to",
          LatLng(storage.read('session_tolat'), storage.read('session_tolng')));
      await storage.write("distance", storage.read('session_totalDistance'));
      await storage.write("tokenId", storage.read('session_tokenId'));
      await storage.write("time", '${storage.read('session_time')}h');
    }
    super.onInit();
  }

  @override
  void onReady() {
    landingPageController.isStopped = false;
    landingPageController.update();
    landingPageController.getCurrentLocationRealtime();
    isLoading = false;
    update();
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (isStopped == true) {
        t.cancel();
      } else {
        print("object");
        getLatLng();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // <---------------- Get Location ----------->

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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonToast.getToast(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLng() async {
    try {
      Future<Position> data = determinePosition();
      data.then((value) async {
        print("Lat data is ${value.latitude}");
        print("Lat data is ${value.longitude}");
        print("${storage.read("mineValue")}");
        print("${storage.read("sapReward")}");
        print(
            "Result ${distance(storage.read('session_lat'), storage.read('session_lng'), value.latitude, value.longitude).round() * double.parse(storage.read("mineValue").toString())}");
        print(
            "Distance ${distance(value.latitude, value.longitude, storage.read('session_lat'), storage.read('session_lng')).round()}");
        minitingValue.value = distance(
            storage.read('session_lat'),
            storage.read('session_lng'),
            value.latitude,
            value.longitude)
            .round() *
            double.parse(storage.read("mineValue").toString()) /
            100;
      });
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  // <---------------------------------------->

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
}
