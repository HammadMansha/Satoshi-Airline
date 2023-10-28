import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import '../../Model/chart_model.dart';
import '../../Utils/api.dart';
import '../../Utils/app_constants.dart';

class RecordTabController extends GetxController {
  bool isLoading = true;

  double value = 0.5;
  List<Tab> myTabs = [];

  String? result;
  int indexing = 3;

  final storage = GetStorage();

  Map dataMap = {};

  List<ChartSampleData> dataList = [];

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  String filter = 'day';

  @override
  void onInit() {
    myTabs = const [
      Tab(text: AppConstants.days),
      Tab(text: AppConstants.weeks),
      Tab(text: AppConstants.months),
      Tab(text: AppConstants.years),
    ];
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    await getGraphData();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getGraphData() async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      String wallet = await storage.read('wallet');
      print(
          "check data ${ApiData.baseUrl}/travel/get-travel-history/0xac9813D8D88A90F4E2d16541669904C0b2c207c3/$filter/0");
      var res = await http.get(
        Uri.parse(
            '${ApiData.baseUrl}/travel/get-travel-history/$wallet/$filter/0'),
        headers: {
          // 'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        print("Check Result $data");
        dataMap.addAll(data);
        data['graphData'].forEach(
          (e) {
            dataList.add(
              ChartSampleData(
                x: filter == 'day'
                    ? returnDateFormat(e['month'])
                    : filter == 'month'
                        ? e['month'].toString()
                        : e['month'],
                // y: e['value'],
                y: double.parse(
                    double.parse(e['value'].toString()).toStringAsFixed(2)),
              ),
            );
          },
        );
        update();
        isLoading = false;
        update();
      } else {
        dataList.clear();
        update();
        if (kDebugMode) {
          print("Check Result $data");
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("Check Error ${e.toString()}");
      }
    }
  }

  String returnDate(String d) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(d);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String returnDateFormat(String d) {
    String c = DateFormat.jm().format(DateTime.parse(d));
    return c;
  }

  String returnWeekDaysFormat(String d) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(d);
    String c = DateFormat('EEEE , h:mm a').format(parseDate);
    return c;
  }
}
