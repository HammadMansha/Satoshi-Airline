import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Utils/api.dart';

class AddsController extends GetxController {
  bool isLoading = true;
  final storage = GetStorage();

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> addview(String attribute, String tokenId) async {
    try {
      String token = await storage.read('token');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.addview),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "userId": storage.read('userId'),
            "tokenId": tokenId,
            "attribute": attribute,
          },
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        print("Get AddView Data $data");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error ${e.toString()}");
    }
  }


    Future<void> viewAdd(String attribute, String tokenId) async {
    try {
      String token = await storage.read('token');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.viewAd),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "userId": storage.read('userId'),
            "wallet": storage.read('wallet'),
          },
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        print("Get AddView Data $data");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error ${e.toString()}");
    }
  }


}
