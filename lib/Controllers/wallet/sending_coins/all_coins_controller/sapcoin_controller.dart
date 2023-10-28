import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class SapCoinController extends GetxController {
  bool isLoading = true;
  var isButtonClicked = false.obs;
  final storage = GetStorage();
  String myText = '';
  List transactionList = [];
  var tokenBalance = 0.00;

  @override
  void onInit() async {
    update();

    if (storage.hasData('sap_transaction_history')) {
      print("Check Data ${storage.read('sap_transaction_history')}");
      await getHistory();
    }
    Timer(const Duration(seconds: 20), () {
      isButtonClicked.value = false;
      update();
    });
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  void handleButtonClick() {
    isButtonClicked.value = true;
  }
  String shortenAddress(String address, int maxLength) {
    if (address.length <= maxLength) {
      return address;
    }

    final firstPart = address.substring(0, 5);
    final lastPart = address.substring(address.length - 9);

    return '$firstPart....$lastPart';
  }

  Future<void> getHistory() async {
    transactionList.clear();
    update();
    await storage.read('sap_transaction_history').forEach((e) {
      transactionList.add(e);
    });
    update();
  }

  String formatDate(String d) {
    var outputFormat = DateFormat('yyyy-MM-dd HH:mm');
    return outputFormat.format(DateTime.parse(d));
  }
}
