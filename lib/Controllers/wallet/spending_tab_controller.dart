import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../../Utils/app_asset_wallet.dart';

class SpendingTabController extends GetxController {
  bool isLoading = true;
  List coinList = [];


  LandingPageController landingPageController =
  Get.find<LandingPageController>();
  var bnbBalance = 0.0.obs; // Rx variable to store the BNB balance
  final storage = GetStorage();
  var tokenBalance = 0.00;

  List transactionList = [];

  @override
  void onInit() async {
   await checkBalance();
    update();
    await updateTokenBalance();
    update();
    print("welcome to Spending Tab View---------------");

    update();
    if (storage.hasData('spending_transaction_history')) {
      print("Check Data ${storage.read('spending_transaction_history')}");
      await getHistory();
    }
    super.onInit();
  }

  @override
  void onReady() async {
   await getTokenBalance();
    update();
    await checkBalance();
    update();
    await updateTokenBalance();
    update();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<String> getTokenBalance() async {
    try {
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final sapTokenContractAddress =
      EthereumAddress.fromHex('0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');

      String abi =
      await rootBundle.loadString("assets/contract/contract.abi.json");

      final sapTokenContractAbi =
      ContractAbi.fromJson(abi, 'contract_abi_here');

      final sapTokenContract = DeployedContract(
        sapTokenContractAbi,
        sapTokenContractAddress,
      );

      final balanceFunction = sapTokenContract.function('balanceOf');
      final balanceParams = [
        EthereumAddress.fromHex(
            landingPageController.addressData['publicAddress'])
      ];

      final balanceResult = await ethClient.call(
        contract: sapTokenContract,
        function: balanceFunction,
        params: balanceParams,
      );

      final balanceInWei = balanceResult.first as BigInt;
      final balanceInEther = balanceInWei / BigInt.from(10).pow(8);

      String formattedBalanceof =
      balanceInEther.toStringAsFixed(2); // 8 decimal places
      print('balance in SAP is : ${formattedBalanceof}');
      storage.write('sapBalancespending', formattedBalanceof);

      return formattedBalanceof;
    } catch (e) {
      print('Error getting SAP Token balance: $e');
      return "0.00000000"; // Return a default value if an error occurs
    }
  }

  Future<void> updateTokenBalance() async {
    final sapBalance = await getTokenBalance();
    tokenBalance = double.parse(sapBalance);
    updateCoinList();
  }

  Future<void> checkBalance() async {
    try {
      String balanceInWei = await getBalanceOfBNB(
          landingPageController.addressData['publicAddress']);
      var balanceInBNB = double.parse(balanceInWei) / 1000000000000000000;

      bnbBalance.value = balanceInBNB;
      GetStorage().write('spendingBalance', bnbBalance.value);
      update();
      updateCoinList();
      print("Balance in ARB is :$balanceInBNB");
    } catch (e) {
      print("Error is $e");
    }
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

  void updateCoinList() {
    coinList = [
      {
        "image": AppAssets.arbLogo,
        "name": 'ARB',
        "value": storage.hasData('public_key')
            ? "${bnbBalance.value.toStringAsFixed(2)}"
            : "0.00",
      },
      {
        "image": AppAssets.sapLogo,
        "name": 'SAP',
        "value":storage.hasData('public_key') ?
        "${tokenBalance.toStringAsFixed(2)} " : "0.00",
      },
      {
        "image": AppAssets.satLogo,
        "name": 'SAT',
        "value": "--",
      },
      {
        "image": AppAssets.usdtLogo,
        "name": 'USDT',
        "value": "--",
      },
    ];

    update();
  }

  Future<void> getHistory() async {
    transactionList.clear();
    update();
    await storage.read('spending_transaction_history').forEach((e) {
      transactionList.add(e);
    });
    update();
  }

  String shortenAddress(String address, int maxLength) {
    if (address.length <= maxLength) {
      return address;
    }

    final firstPart = address.substring(0, 5);
    final lastPart = address.substring(address.length - 9);

    return '$firstPart....$lastPart';
  }
  String formatDate(String d) {
    var outputFormat = DateFormat('yyyy-MM-dd HH:mm');
    return outputFormat.format(DateTime.parse(d));
  }


}
