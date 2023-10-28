import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Utils/api.dart';
import 'package:intl/intl.dart';

class LeadingBoardController extends GetxController {
  bool isLoading = true;


  final storage = GetStorage();

  List ranklist = [];

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  String dropdownvalue = 'all';

  @override
  void onReady() async {
    await getRecord();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getRecord() async {
    try {
      ranklist.clear();
      isLoading = true;
      update();
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.ranking + dropdownvalue),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = json.decode(res.body);
      print("Check Data $data");
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        data['ranks'].forEach((e) {
          ranklist.add(e);
        });
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      print("Api's error is ${e.toString()}");
      isLoading = false;
      update();
    }
  }

}
