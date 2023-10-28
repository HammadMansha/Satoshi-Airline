import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../Controllers/landingpage_controller.dart';
import '../../../Utils/api.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/commonSnackbar.dart';
import '../../AuthScreens/signup.dart';


class LevelScreenFreeController extends GetxController {
  bool isLoading = true;
  bool isBoost = false;

  String errorString = '';

  Rx<TextEditingController> avalue = TextEditingController().obs;
  Rx<TextEditingController> selectedValue =
      TextEditingController(text: 'FUEL').obs;

  LandingPageController landingPageController =
  Get.find<LandingPageController>();

  final formKey = GlobalKey<FormState>();

  int currentIndex = 0;

  final storage = GetStorage();
  Map nftData = {};
  Map levelInfo = {};
  String imagePath = '';
  bool isArrgument = false;
  var id;

  var maxValaue;
  var minValue;

  List attributesList = [];
  RxInt timer = 0.obs;
  RxString t = ''.obs;

  List<Tab> myTabs = [];

  int indexing = 0;
  // String selectedValue = 'FUEL';

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
      imagePath = Get.arguments['path'];
      id = await Get.arguments['id'];
      isArrgument = true;
      update();
      await getAttributes(Get.arguments['id']);
      await getLevelInfo(Get.arguments['id']);
    } else {
      await getData();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    // await getData();
    // isLoading = false;
    super.onReady();
  }

  Future<void> getData() async {
    try {
      if (landingPageController
          .minitingGlobleController.assetsData.isNotEmpty) {
        isLoading = true;
        update();
        imagePath = landingPageController.minitingGlobleController
            .assetsData[currentIndex]['jsonData']['image'];
        id = landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id'];
        update();
        await getAttributes(landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id']);
        await getLevelInfo(landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id']);
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> getAttributes(var v) async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getAttributes + v.toString()),
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
        await storage.write(
            "mineValue",
            double.parse(
                (data['data']['attributes']['mine']['value']).toString())
                .toStringAsFixed(2));
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
        isLoading = false;
        update();
      } else {
        if (data['message'] == 'Invalid authentication token') {
          await storage.erase();
          Get.offAll(() => const SignUp());
          CommonToast.getToast(
            'Your token is expire please login again',
          );

          // CommonSnackbar.getSnackbar(
          //   "Info",
          //   "your token is expire please login again",
          //   Colors.amber,
          // );
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> getLevelInfo(var v, {String type = '' , int levelNo = 0}) async {
    try {
      print("Level $levelNo");
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getLevelInfo + v.toString()),
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
        levelInfo.addAll(data["data"]);
        update();
        print("Total Time ${checkData(levelInfo['expiry'])}");
        if (type != 'booster' && type != '') {
          await landingPageController.notification(
            notificationtitle: 'Congrats !',
            notificationbody: 'Level up from $levelNo to Level ${levelNo + 1}',
            timeinterval: checkData(levelInfo['expiry']),
          );
        }
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
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
      print("Check Data ${data}");
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await getAttributes(id);
        await landingPageController.getBalance();
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      }
    } catch (E) {
      print("check ${E.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> updateLevel(String type , {int levelno = 0}) async {
    try {
      if (kDebugMode) {
        print("Function Call $type");
      }
      Get.back();
      isLoading = true;
      update();
      String token = await storage.read('token');
      var link = type == 'booster'
          ? ApiData.baseUrl + ApiData.boostLevel
          : ApiData.baseUrl + ApiData.updateLevel;
      var res = await http.post(
        Uri.parse(link),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "type": type,
          "tokenId": id.toString(),
        }),
      );
      var data = await json.decode(res.body);
      if (kDebugMode) {
        print("check Data $data");
      }
      if (res.statusCode >= 200 && res.statusCode < 300) {
        nftData.clear();
        levelInfo.clear();
        update();
        if (type == 'booster') {
          AwesomeNotifications().cancelAllSchedules();
        }
        await getAttributes(id);
        await getLevelInfo(id, type: type , levelNo: levelno);
        await landingPageController.getBalance();
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
        // CommonSnackbar.getSnackbar(
        //     "ERROR", data['showableMessage'], Colors.red);
      }
    } catch (e) {
      print("Api Error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  int checkData(String d) {
    DateTime dt1 = DateTime.parse(d);
    DateTime now = DateTime.now();
    // Duration diff = now.difference(dt1);
    Duration diff = dt1.difference(now);
    return diff.inSeconds;
  }

  void runTime() {
    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      timer.value--;
      if (timer.value > 0) {
        runTime();
      }
    });
  }

  String maxValue() {
    return avalue.value.text;
  }
}


