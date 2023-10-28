import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web3dart/web3dart.dart';

import '../../Utils/app_asset_wallet.dart';

class WalletController extends GetxController {
  bool isLoading = true;
  var isButtonClicked = false.obs;
  RxBool isLoggedIn = false.obs;
  final publicKey = RxString('');
  List coinList = [];
  final storage = GetStorage();
  var sapCoin = 0.00.obs;
  var tokenBalance = 0.00;

   var balanceInBNB = 0.00;

  List<String> image = [
    AppAssets.arbLogo,
    AppAssets.sapLogo,
    AppAssets.satLogo,
    AppAssets.usdtLogo,
  ];
  List<String> currencies = ['ARB', 'SAP', 'SAT', 'USDT'];
  List<String> b = [];
  List<String> c = ['0.00', '0.00', '0.00', '0.00'];

  void handleButtonClick() {
    isButtonClicked.value = true;
    Timer(const Duration(seconds: 10), () {
      isButtonClicked.value = false;
      update();
    });
  }
  @override
  void onInit() async {

print('welcome to wallet Tab View.................');
    await checkBalance();
    // print('balance in ARB is {$checkBalance()}');
    update();
    await updateTokenBalance();
// print('balance in SAP is {$updateTokenBalance()}');
    update();
    super.onInit();
  }

  @override
  void onReady() async {
   await updateCoinList;
  update();
    if (storage.hasData('public_key')) {
      await checkBalance();
      await updateTokenBalance();
      await getTokenBalance();
      update();
    }
    update();
    isLoggedIn.value = storage.hasData('public_key');
    update();

    for (int i = 0; i < currencies.length; i++) {
      b.add(currencies[i]);
      // c.add('0.00');
      update();
    }
    update();

    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> checkBalance() async {
    try {
      String balanceInWei = await getBalanceOfBNB(storage.read('public_key'));
      balanceInBNB = double.parse(balanceInWei) / 1000000000000000000;
      print('balance in ARB IS: {$balanceInBNB}');
      storage.write('bnb_balance', balanceInBNB.toStringAsFixed(4));
      updateCoinList();
      update();

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

  Future<String> getTokenBalance() async
  {
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
      final balanceParams = [EthereumAddress.fromHex(storage.read('public_key'))];

      final balanceResult = await ethClient.call(
        contract: sapTokenContract,
        function: balanceFunction,
        params: balanceParams,
      );

      final balanceInWei = balanceResult.first as BigInt;
      final balanceInEther = balanceInWei / BigInt.from(10).pow(8);

      String formattedBalance =
          balanceInEther.toStringAsFixed(2); // 8 decimal places
      print('balance in ether is : ${formattedBalance}');

      return formattedBalance;
      // storage.write(key, value)
    } catch (e) {
      print('Error getting SAP Token balance: $e');
      return "0.00000000"; // Return a default value if an error occurs
    }
  }
  Future<void> updateTokenBalance() async {
    final sapBalance = await getTokenBalance();
    tokenBalance = double.parse(sapBalance);
    storage.write('sapBalance', tokenBalance);
    updateCoinList();
    update();
    c;
  }

  void updateCoinList() {
    coinList = [
      {
        "image": AppAssets.arbLogo,
        "name": 'ARB',
        "value": balanceInBNB >= 0.000001
            ? "${balanceInBNB.toStringAsFixed(6)}"
            : "0.00",
      },
      {
        "image": AppAssets.sapLogo,
        "name": 'SAP',
        "value": tokenBalance >= 0.000001
            ? "${tokenBalance.toStringAsFixed(6)} "
            : "0.00",
      },
      {
        "image": AppAssets.satLogo,
        "name": 'SAT',
        "value": "0.00",
      },
      {
        "image": AppAssets.usdtLogo,
        "name": 'USDT',
        "value": "0.00",
      },
    ];

    update();
  }



}
