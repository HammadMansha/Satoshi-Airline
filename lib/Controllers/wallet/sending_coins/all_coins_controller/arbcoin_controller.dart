import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:web3dart/credentials.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class ArbCoinController extends GetxController {
  bool isLoading = true;
  var isButtonClicked = false.obs;
  var balanceInBNB = 0.00;
  List transactionList = [];
  final storage = GetStorage();

  @override
  void onInit() async {
   await checkBalance();
    update();
    print('come back from arbCOIN screen..........');
    print("Check Data ${storage.read('wallet_transaction_history')}");

     // await myText = storage.read('bnb_balance');
      update();

    if (storage.hasData('wallet_transaction_history')) {
      print("Check Data ${storage.read('wallet_transaction_history')}");
      await getHistory();
    }
    super.onInit();
  }

  Future<String> getBalanceOfBNB(String address) async {
    var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    EthereumAddress ethAddress = EthereumAddress.fromHex(address);
    EtherAmount balanceWei = await ethClient.getBalance(ethAddress);

    BigInt balanceInWei = balanceWei.getInWei;
    final balanceInBNB = EtherAmount.fromBigInt(EtherUnit.ether, balanceInWei);

    return balanceInBNB.getValueInUnit(EtherUnit.ether).toString();
  }

  Future<void> checkBalance() async {
    try {
      String balanceInWei = await getBalanceOfBNB(storage.read('public_key'));
      balanceInBNB = double.parse(balanceInWei) / 1000000000000000000;
      print('balance in ARB IS: {$balanceInBNB}');

      update();

    } catch (e) {
      print("Error is $e");
    }
  }
  void handleButtonClick() {
    isButtonClicked.value = true;
    Timer(const Duration(seconds: 10), () {
      isButtonClicked.value = false;
      update();
    });
  }

  @override
  void onReady()async {
   await checkBalance();
   update();
    isLoading = false;
    update();
    super.onReady();
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
    await storage.read('wallet_transaction_history').forEach((e) {
      transactionList.add(e);
    });
    update();
  }

  String formatDate(String d) {
    var outputFormat = DateFormat('yyyy-MM-dd HH:mm');
    return outputFormat.format(DateTime.parse(d));
  }
}
