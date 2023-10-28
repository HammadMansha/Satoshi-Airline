import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/wallet/sending_coins/all_coins_controller/arbcoin_controller.dart';
import 'package:satoshi/Controllers/wallet/wallet_tab_controller.dart';
import 'package:web3dart/web3dart.dart';
import '../../../widget/wallet_widgets/common_toast_message.dart';

class SendArbCoinController extends GetxController {
  TextEditingController qrContentEditingController = TextEditingController();
  final storage = GetStorage();
  final formKey = GlobalKey<FormState>();
  FocusNode amountFocusNode = FocusNode();
  bool shouldPopulateAmount = false;
  double walletAmount = 0.0; // Wallet amount

  var qrCode = ''.obs;
  bool loading = true;
  String scannedQrcode = '';
  TextEditingController toAddress = TextEditingController();
  TextEditingController amount = TextEditingController();

  ArbCoinController arbCoinController = Get.find<ArbCoinController>();
  WalletController walletController = Get.find<WalletController>();
  late EthereumAddress walletAddress;
  double totalAmount = 0.0;
  List transactionHistoryList = [];


  @override
  void onInit() {
    //<----------- Check Storage exist or not ---------->
    if (storage.hasData('wallet_transaction_history')) {
      //<------- if storage exist than add data in list -------->
      storage.read('wallet_transaction_history').forEach((e) {
        transactionHistoryList.add(e);
      });
      update();
    }
    super.onInit();
  }

  @override
  void onReady() {
    // shouldPopulateAmount = false; // Initialize shouldPopulateAmount to false
    // update();
    // calculateRemainingAmountForWallet();
    // update();
    update();
    loading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendAllWalletArbToSpending() async {
    try {
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      walletAddress = EthereumAddress.fromHex(storage.read('public_key'));

      // Fetch the current gas price from the Ethereum network.
      EtherAmount gasPrice = await ethClient.getGasPrice();
      print("Gass price is---------------$gasPrice");

      EtherAmount balance = await ethClient.getBalance(walletAddress);
      print("Balance price is---------------$balance");

      BigInt remainingBalanceWei = balance.getInWei - gasPrice.getInWei;
      final gasFee =
          gasPrice.getInWei * BigInt.from(21000); // Assuming a simple transfer

// // Calculate the amount to send, deducting the gas fee
      final amountToSendWei = remainingBalanceWei - gasFee;
      EtherAmount remainingBalance =
      EtherAmount.fromBigInt(EtherUnit.wei, amountToSendWei);
      walletAmount = remainingBalance.getValueInUnit(EtherUnit.ether);
      amount.text = walletAmount.toStringAsFixed(12);
      update();
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }
  }




  Future<void> sendTransaction(String receiver, EtherAmount txValue) async {
    try {
      loading = true;
      update();
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));
      print('privaet_key${storage.read('private_key')}');

      EtherAmount gasPrice = await ethClient.getGasPrice();

      await ethClient
          .sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 97,
      )
          .then((value) async {
        //<-------- Add transaction in list than override data in storage ------->
        transactionHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': receiver,
          'amount': '-${amount.text} ARB',
          'date_time': DateTime.now().toString(),
        });
        update();
        storage.write('wallet_transaction_history', transactionHistoryList);

        arbCoinController.update();
        await arbCoinController.getHistory();
        update();
        arbCoinController.onInit();
        update();
      });
      Get.back();
      loading = false;
      update();
      ShowToastMessage('Transaction sent successfully');
    } catch (e) {
      loading = false;
      update();
      ShowToastMessage('You Have Insufficient Balance');
    }
  }
}
