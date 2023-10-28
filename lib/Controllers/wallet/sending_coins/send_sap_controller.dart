import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class SendSapCoinController extends GetxController {
  TextEditingController qrContentEditingController = TextEditingController();

  var qrCode = ''.obs;
  bool shouldPopulateAmount = false;
  bool isLoading = true;
  TextEditingController toAddress = TextEditingController();
  TextEditingController amount = TextEditingController();
  String scannedQrcode = '';
  final storage = GetStorage();
  List HistoryListSap = [];
  double sapAmount = 0.0;
  late EthereumAddress walletAddress ;
  var tokenBalance = 0.00;

  @override
  void onInit() {
    if (storage.hasData('sap_transaction_history')) {
      //<------- if storage exist than add data in list -------->
      storage.read('sap_transaction_history').forEach((e) {
        HistoryListSap.add(e);
      });
      update();
    }
    // getTokenBalance;
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading   = false;
    // update();
    update();
    super.onReady();
  }
  Future<void> sendSapTokensWithContract() async {
    try {
      isLoading = true;
      update();
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));
      print('private_key: ${storage.read('private_key')}');

      final sapTokenContractAddress =
          EthereumAddress.fromHex('0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');
      final recipientAddress = EthereumAddress.fromHex(toAddress.text);

      // Parse the amount.text as a double and then convert it to BigInt
      final amountValue = double.tryParse(amount.text);
      if (amountValue == null) {
        // Handle the case where amount.text is not a valid number
        print('Invalid amount: ${amount.text}');
        return;
      }

      final amountInWei = BigInt.from((amountValue * 1e8).toInt());
      print('amountInWei: ${amountInWei}');

      String abi =
          await rootBundle.loadString("assets/contract/contract.abi.json");
      print('abi: ${abi}');

      final sapTokenContractAbi =
          ContractAbi.fromJson(abi, 'contract_abi_here');
      print('sapTokenContractAbi: ${sapTokenContractAbi}');

      final sapTokenContract = DeployedContract(
        sapTokenContractAbi,
        sapTokenContractAddress,
      );
      print('sapTokenContract: ${sapTokenContract}');

      final transferFunction = sapTokenContract.function('transfer');
      print('transferFunction: ${transferFunction}');

      final transferParams = [
        recipientAddress,
        BigInt.from(amountInWei.toInt()),
      ];

      final transaction = Transaction.callContract(
        contract: sapTokenContract,
        function: transferFunction,
        parameters: transferParams,
      );
      print('transaction${transaction}');

      final response = await ethClient
          .sendTransaction(
        credentials,
        transaction,
        chainId: 97, // Set the correct chain ID
      );
      print('response ${response}');
      if (response != null){
          HistoryListSap.add({
            'userId': storage.read("userId"),
            'receiver_address': toAddress.text,
            'amount': '-${amount.text}',
            'date_time': DateTime.now().toString(),
          });
          print('userId :${storage.read("userId")}');
          print('receiver_address :${recipientAddress}');
          print('amount :${amount.text}');
          print('dateTime :${DateTime.now().toString()}');

          update();
          storage.write('sap_transaction_history', HistoryListSap);
          update();
          isLoading = false;
          update();
        print('Transaction was successful');
        Get.back();

        // Get.back();
        ShowToastMessage('Transaction successful');
      } else {
        isLoading = false;
        update();
        ShowToastMessage('Transaction was not successful');
        print('Transaction was not successful');
      }
    } catch (e) {
      isLoading = false;
      update();
      ShowToastMessage('Transaction was not successful');
      print('Error: $e');
      // Handle any exceptions that occur during the transaction.
    }
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
      balanceInEther.toStringAsFixed(8); // 8 decimal places
      print('balance in ether is : ${formattedBalance}');
      amount.text= formattedBalance.toString();
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

    update();

  }
}
