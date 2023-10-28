import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Utils/api.dart';

class BacKUpKeyController extends GetxController {
  bool isLoading = true;

  final formKey1 = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  TextEditingController backupKey = TextEditingController();
  String userAccessToken = "";
  GetStorage storage = GetStorage();
  String googleAuthKey = "";
  bool isKeyArrived = false;

  @override
  void onReady() async {
    userAccessToken = await storage.read("token");
    await get2FAKey();
    isLoading = false;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> get2FAKey() async {
    var res = await http.post(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userAccessToken,
      },
      Uri.parse(ApiData.get2FAKey),
      body: json.encode({
        "userId": storage.read("userId"),
      }),
    );
    var data = await json.decode(res.body);
    print("Response of Get 2FA call------------${res.statusCode}");
    if (res.statusCode == 200) {
      googleAuthKey = data["showableMessage"];
      backupKey.text = googleAuthKey;
      isKeyArrived = true;
      update();
    }
    print("Response of Get 2FA body------------$googleAuthKey");
  }
}
