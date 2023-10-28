import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landing/destination_controller.dart';
import 'package:satoshi/Controllers/level/level_controller.dart';

import '../../../Controllers/landingpage_controller.dart';
import '../../../Utils/api.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/commonSnackbar.dart';
class CheckInFerryJetController extends GetxController {
  bool isLoading = true;

  String dropdownvalue = ' Fuel';
  var dropdownCur = ' 90';
  var dropdownUpg = ' 60';

  String apikey = "AIzaSyCrY92DPLOQXPHEUzoN9vjQvrX5NtOAVjk";
  String radius = "30";
  String fromCountry = '';
  String toCountry = '';

  final storage = GetStorage();
  Map nftData = {};

  double latitude = 31.5203274;
  double longitude = 74.4103575;

  double checkInLat = 0.0;
  double checkInLong = 0.0;

  double currentlat = 0.0;
  double currentlong = 0.0;

  double totalDistance = 0.0;

  // LevelController levelController = Get.find<LevelController>();
  DestinationController destinationController = Get.put(DestinationController());
  LevelController levelController = Get.put(LevelController());
  int currentIndex = 0;

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  List<Tab> myTabs = [];
  int indexing = 0;

  @override
  void onInit() async {
    myTabs = [
      const Tab(text: 'Basic'),
      const Tab(text: 'Pro'),
      Tab(
          icon: Image.asset(
            AppConstants.helpIcon,
            height: 17,
          )),
    ];
    update();
    if (Get.arguments != null) {
      checkInLat = Get.arguments['lat'];
      checkInLong = Get.arguments['lng'];
      fromCountry = Get.arguments['fromCountry'];
      toCountry = Get.arguments['toCountry'];
      totalDistance = Get.arguments['totalDistance'];
      storage.write("session_totalDistance", Get.arguments['totalDistance']);
      storage.write("session_tokenId", levelController.id.toString());
      update();
    }
    await getLatLong();
    super.onInit();
  }

  LandingPageController landingPageController =
  Get.put(LandingPageController());

  @override
  void onReady() async {
    await getReward();
    // await getNearbyPlaces();
    isLoading = false;
    update();
    super.onReady();
  }

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
          ' Location permissions are denied',
        );
        // CommonSnackbar.getSnackbar(
        //     "Warning", "Location permissions are denied", Colors.blue);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonToast.getToast(
        ' Location permissions are permanently denied, we cannot request permissions.',
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
    data.then((value) {
      if (kDebugMode) {
        print("Lat Long is $value");
      }
      currentlat = value.latitude;
      currentlong = value.longitude;
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
    if (kDebugMode) {
      print("location function call");
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      // from.text = "${placemarks[0].street!} ${placemarks[0].country!}";
      update();
      for (int i = 0; i < placemarks.length; i++) {
        if (kDebugMode) {
          print("Full Address is  $i ${placemarks[i]}");
        }
      }
    } catch (E) {
      if (kDebugMode) {
        print("Get Address error is ${E.toString()}");
      }
    }
  }

  Future<void> getNearbyPlaces() async {
    try {
      if (kDebugMode) {
        print("object");
      }
      var url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentlat.toString()},${currentlong.toString()}&radius=$radius&key=$apikey');
      var response = await http.post(url);
      Get.log("check res ${response.body}");
    } catch (e) {
      if (kDebugMode) {
        print("Check Error is ${e.toString()}");
      }
      isLoading = false;
      update();
    }
  }

  Future<void> getReward() async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
          Uri.parse(
              '${ApiData.baseUrl + ApiData.getReward + levelController.id.toString()}/$totalDistance'),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          });
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        nftData.addAll(data);
        isLoading = false;
        update();
        if (kDebugMode) {
          print(nftData);
        }
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("check Data ${e.toString()}");
      }
      isLoading = false;
      update();
    }
  }

  double time() {
    print("check Time ${totalDistance / 750}");
    return totalDistance / 750;
  }

  String getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    String hourValue = getHourString(flooredValue);
    String minuteString = getMinuteString(decimalValue);

    return '${hourValue}H ${minuteString}M';
  }

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }

  String min(String d) {
    if (d.length > 2) {
      if (int.parse(d.substring(0, 2)) > 60) {
        return '59';
      } else {
        d.substring(0, 2);
      }
    }
    return d;
  }

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.checkInSound));
  }

}
