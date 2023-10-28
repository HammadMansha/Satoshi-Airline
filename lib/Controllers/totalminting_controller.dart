import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Controllers/level/level_controller.dart';

import '../../Utils/api.dart';
import '../../Utils/commonSnackbar.dart';
import '../Utils/app_constants.dart';
import '../Views/AuthScreens/signup.dart';

class TotalMintingController extends GetxController {
  bool isLoading = true;

  Rx<TextEditingController> avalue = TextEditingController().obs;

  Rx<TextEditingController> selectedValue =
      TextEditingController(text: 'FUEL').obs;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final formKey = GlobalKey<FormState>();

  final storage = GetStorage();

  Map usernftData = {};
  Map nftData = {};

  String imagePath = '';
  String fromCountry = '';
  String toCountry = '';

  var id;

  double checkInLat = 0.0;
  double checkInLong = 0.0;
  double currentlat = 0.0;
  double currentlong = 0.0;
  double totalDistance = 0.0;

  LevelController levelController = Get.find<LevelController>();

  List attributesList = [];
  var maxValaue;
  var minValue;

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
    id = storage.read('session_token_id');
    if (Get.arguments != null) {
      // checkInLat = Get.arguments['lat'];
      // checkInLong = Get.arguments['lng'];
      // fromCountry = Get.arguments['fromCountry'];
      // toCountry = Get.arguments['toCountry'];
      // totalDistance = Get.arguments['totalDistance'];
      checkInLat = storage.read('session_lat');
      checkInLong = storage.read('session_lng');
      fromCountry = storage.read('session_fromCountry');
      toCountry = storage.read('session_toCountry');
      totalDistance = storage.read('session_totalDistance');
      update();
    }
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    await getAttributes();
    await getReward();

    isLoading = false;
    super.onReady();
  }

  Future<void> updateAttribute(String a) async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      String uid = await storage.read("userId");
      double c = double.parse(avalue.value.text);
      var b = {
        "userId": uid,
        "tokenId": id.toString(),
        "attribute": a.toLowerCase(),
        "upgradeValue": avalue.value.text,
      };
      print("check $b");
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.buyAttributes),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": uid,
          "tokenId": id.toString(),
          "attribute": a.toLowerCase(),
          "upgradeValue": c,
        }),
      );
      var data = await json.decode(res.body);
      print("check ${data}");
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await getAttributes();
        await levelController.landingPageController.getBalance();
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        // CommonSnackbar.getSnackbar(
        //     "Success", data['showableMessage'], Colors.green);
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      }
    } catch (E) {
      print("Error ${E.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> getAttributes() async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(
          ApiData.baseUrl +
              ApiData.getAttributes +
              storage.read('session_token_id'),
        ),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        nftData.addAll(data["data"]);
        maxValaue = data['data']['attributes']['fuel']['maxValue'];
        minValue = data['data']['attributes']['fuel']['value'];
        attributesList = [
          {
            "id": "FUEL",
            "name": "FUEL",
            "minvalue": "${data['data']['attributes']['fuel']['value']}",
            "value": "${data['data']['attributes']['fuel']['maxValue']}",
            "iconPath": AppConstants.fuelIcon
          },
          {
            "id": "MINE",
            "name": "MINE",
            "minvalue": "${data['data']['attributes']['mine']['value']}",
            "value": "${data['data']['attributes']['mine']['maxValue']}",
            "iconPath": AppConstants.mineIcon
          },
          {
            "id": "DURABILITY",
            "name": "DURABILITY",
            "minvalue": "${data['data']['attributes']['durability']['value']}",
            "value": "${data['data']['attributes']['durability']['maxValue']}",
            "iconPath": AppConstants.durabilityIcon
          },
          {
            "id": "LUCK",
            "name": "LUCK",
            "minvalue": "${data['data']['attributes']['luck']['value']}",
            "value": "${data['data']['attributes']['luck']['maxValue']}",
            "iconPath": AppConstants.luckyIcon
          },
        ];
        update();
      } else {
        if (data['message'] == 'Invalid authentication token') {
          await storage.erase();
          Get.offAll(() => const SignUp());
          CommonToast.getToast(
            'Your token is expire please login again',
          );
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("check error ${e.toString()}");
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
              '${ApiData.baseUrl + ApiData.getReward + storage.read('session_token_id')}/${storage.read('session_totalDistance')}'),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          });
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        usernftData.addAll(data);
        isLoading = false;
        update();
        if (kDebugMode) {
          print(usernftData);
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

  double calValue(var a, var b) {
    return double.parse(
      (a / b).toString(),
    );
  }

  String maxValue() {
    return avalue.value.text;
  }
}
