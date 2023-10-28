import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:intl/intl.dart';

class ViewFreindsController extends GetxController {
  bool isLoading = true;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();
  List friendsList = [];

  int rewardTotal = 0;

  @override
  void onReady() async {
    await getReferalHistory();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getReferalHistory() async {
    try {
      String token = await storage.read('token');

      var res = await http.get(
        Uri.parse(
          ApiData.baseUrl + ApiData.getReferalHistory + storage.read('userId'),
        ),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      print("Referal Data status code  ${res.statusCode}");

      if (res.statusCode >= 200 && res.statusCode <= 300) {
        print("Res Data $data");
        friendsList = data['result'];
        isLoading = false;
        update();
        print("List $friendsList");
        friendsList.forEach((element) {
          rewardTotal =
              rewardTotal + int.parse(element['sapReward'].toString());
        });
        update();
      } else {
        isLoading = true;
        update();
        print("Res Data $data");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error ${e.toString()}");
    }
  }

  String returnWeekDaysFormat(String d) {
    // Parse the input date string
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(d);

    // Format the parsed date into the desired format
    String formattedDate = DateFormat('EEEE, MMM d, y, h:mm a').format(parseDate);

    return formattedDate;
  }


}
