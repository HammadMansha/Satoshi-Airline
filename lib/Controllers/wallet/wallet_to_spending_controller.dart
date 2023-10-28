import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/wallet/sending_coins/all_coins_controller/arbcoin_controller.dart';
import 'package:satoshi/Controllers/wallet/spending_tab_controller.dart';
import 'package:satoshi/Controllers/wallet/wallet_tab_controller.dart';
import 'package:web3dart/web3dart.dart';
import '../../Utils/app_asset_wallet.dart';
import '../../widget/wallet_widgets/common_toast_message.dart';

class WalletToSpendingController extends GetxController {
  RxString currentText = 'Wallet'.obs;
  RxString currentText1 = 'Spending'.obs;
  String? defaultValue = 'Please Select Token';
  late double balanceInBNB;

  bool shouldPopulateAmount = false; // Added flag to control amount population
  final storage = GetStorage();
  List dropdownList = [];
  bool isLoading = true;
  SpendingTabController spendingTabController =
      Get.find<SpendingTabController>();
  WalletController walletController = Get.put(WalletController());
  ArbCoinController arbCoinController = Get.put(ArbCoinController());

  TextEditingController selected = TextEditingController();
  TextEditingController toAddress = TextEditingController();
  TextEditingController amount =
      TextEditingController(); // Initialize with "0.00"

  double walletAmount = 0.0; // Wallet amount
  double spendingAmount = 0.0; // Spending amount

  late EthereumAddress walletAddress;
  late EthereumAddress walletAddressNew;

  void swapText() {
    String temp = currentText.value;
    currentText.value = currentText1.value;
    currentText1.value = temp;
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

  Future<void> sendAllSpendingArbToWallet() async {
    try {
      print('hello g');
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      walletAddressNew = EthereumAddress.fromHex(spendingTabController
          .landingPageController.addressData['publicAddress']);

      // Fetch the current gas price from the Ethereum network.
      EtherAmount gasPrice = await ethClient.getGasPrice();
      print("Gass price is---------------$gasPrice");

      EtherAmount balance = await ethClient.getBalance(walletAddressNew);
      print("Balance price is---------------$balance");

      BigInt remainingBalanceWei = balance.getInWei - gasPrice.getInWei;
      final gasFee =
          gasPrice.getInWei * BigInt.from(210000); // Assuming a simple transfer

// // Calculate the amount to send, deducting the gas fee
      final amountToSendWei = remainingBalanceWei - gasFee;
      EtherAmount remainingBalance =
          EtherAmount.fromBigInt(EtherUnit.wei, amountToSendWei);

      spendingAmount = remainingBalance.getValueInUnit(EtherUnit.ether);
      amount.text = spendingAmount.toStringAsFixed(12);
      update();
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }
  }

  List spendingHistoryList = [];
  List walletHistoryList = [];
  List HistoryListSap = [];

  @override
  void onInit() {
    if (storage.hasData('wallet_transaction_history')) {
      storage.read('wallet_transaction_history').forEach((E) {
        walletHistoryList.add(E);
      });
    }
    if (storage.hasData('sap_transaction_history')) {
      storage.read('sap_transaction_history').forEach((E) {
        HistoryListSap.add(E);
      });
    }
    //<----------- Check Storage exist or not ---------->
    if (storage.hasData('spending_transaction_history')) {
      //<------- if storage exist than add data in list -------->
      storage.read('spending_transaction_history').forEach((e) {
        spendingHistoryList.add(e);
      });
      update();
    }
    update();

    dropdownList = [
      {
        "logo": AppAssets.arbLogo,
        "name": 'ARB',
      },
      {
        "logo": AppAssets.sapLogo,
        "name": 'SAP',
      },
      {
        "logo": AppAssets.satLogo,
        "name": 'SAT',
      },
      {
        "logo": AppAssets.usdtLogo,
        "name": 'USDT',
      },
    ];
    update();

    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  void setAllAmountForSend() {
    if (shouldPopulateAmount) {
      amount.text = walletAmount.toStringAsFixed(12);
    } else {
      shouldPopulateAmount = true;
    }
    update();
  }

  Future<void> sendArbWalletToSpending(EtherAmount txValue) async {
    try {
      isLoading = true;
      update();
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));
      print('credentials : ${credentials}');
      EtherAmount gasPrice = await ethClient.getGasPrice();
      update();
      print(
          'txValue : ${txValue.getValueInUnit(EtherUnit.ether)}'); // Convert to double

      await ethClient
          .sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(spendingTabController
              .landingPageController.addressData['publicAddress']),
          gasPrice: gasPrice,
          maxGas: 21000,
          value: txValue,
        ),
        chainId: 97,
      )
          .then((value) async {
        double txAmountInEther = txValue.getValueInUnit(EtherUnit.ether);

        spendingHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': spendingTabController
              .landingPageController.addressData['publicAddress'],
          'amount': '+${txAmountInEther} ARB',
          'date_time': DateTime.now().toString(),
        });
        walletHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': spendingTabController
              .landingPageController.addressData['publicAddress'],
          'amount': '-${txAmountInEther} ARB',
          'date_time': DateTime.now().toString(),
        });

        storage.write('spending_transaction_history', spendingHistoryList);
        storage.write('wallet_transaction_history', walletHistoryList);
        spendingTabController.isLoading = true;
        spendingTabController.update();
        await spendingTabController.checkBalance();
        await spendingTabController.getHistory();
        spendingTabController.isLoading = false;
        spendingTabController.update();
        isLoading = false;
        update();
        print("Transaction added successfully");
        spendingTabController.onInit();
        update();
        walletController.onInit();
        update();
        arbCoinController.onInit();
        update();
        Get.back();
      });

      ShowToastMessage('Transaction sent successfully');
    } catch (e) {
      print("error---------------------------$e");
      isLoading = false;
      update();
      ShowToastMessage('Insufficient Balance');
    }
  }

  Future<void> sendArbSpendingToWallet(EtherAmount txValue) async {
    try {
      isLoading = true;
      update();
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(spendingTabController
          .landingPageController.addressData['privateKey']);

      EtherAmount gasPrice = await ethClient.getGasPrice();

      await ethClient
          .sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(storage.read('public_key')),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 97,
      )
          .then((value) {
        spendingHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': storage.read('public_key'),
          'amount': '-${amount.text} ARB',
          'date_time': DateTime.now().toString(),
        });
      });
      walletHistoryList.add({
        'userId': storage.read("userId"),
        'receiver_address': storage.read('public_key'),
        'amount': '+${amount.text} ARB',
        'date_time': DateTime.now().toString(),
      });
      storage.write('spending_transaction_history', spendingHistoryList);
      storage.write('wallet_transaction_history', walletHistoryList);
      spendingTabController.isLoading = true;
      spendingTabController.update();
      await spendingTabController.checkBalance();
      await spendingTabController.getHistory();
      spendingTabController.isLoading = false;
      spendingTabController.update();
      isLoading = false;
      update();
      print("Transaction added successfully");
      spendingTabController.onInit();
      update();
      walletController.onInit();
      update();
      arbCoinController.onInit();
      update();
      Get.back();

      ShowToastMessage('Transaction sent successfully');
    } catch (e) {
      isLoading = false;
      update();
      ShowToastMessage('Insufficient Balance');
    }
  }

  Future<void> sendSapTokensWithContract() async {
    try {
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));
      print('private_key: ${storage.read('private_key')}');

      final sapTokenContractAddress =
          EthereumAddress.fromHex('0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');
      final recipientAddress = EthereumAddress.fromHex(spendingTabController
          .landingPageController.addressData['publicAddress']);

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

      final response = await ethClient.sendTransaction(
        credentials,
        transaction,
        chainId: 97, // Set the correct chain ID
      );
      print('response ${response}');
      if (response != null) {
        HistoryListSap.add({
          'userId': storage.read("userId"),
          'receiver_address': spendingTabController
              .landingPageController.addressData['publicAddress'],
          'amount': '-${amount.text}',
          'date_time': DateTime.now().toString(),
        });
        spendingHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': spendingTabController
              .landingPageController.addressData['publicAddress'],
          'amount': '+${amount.text} SAP', // Add "SAP" text here
          'date_time': DateTime.now().toString(),
        });
        print('userId :${storage.read("userId")}');
        print('receiver_address :${recipientAddress}');
        print('amount :${amount.text}');
        print('dateTime :${DateTime.now().toString()}');

        update();
        storage.write('sap_transaction_history', HistoryListSap);
        storage.write('spending_transaction_history', spendingHistoryList);
        spendingTabController.isLoading = true;
        spendingTabController.update();
        await spendingTabController.checkBalance();
        await spendingTabController.getHistory();
        spendingTabController.isLoading = false;
        spendingTabController.update();
        isLoading = false;
        update();
        print("Transaction added successfully");
        spendingTabController.onInit();
        update();
        walletController.onInit();
        update();
        arbCoinController.onInit();
        update();

        Get.back();
        ShowToastMessage('Transaction successful');
      } else if (response == null) {
        ShowToastMessage('Insufficient Balance');
        print('Transaction was not successful');
      }
    } catch (e) {
      print('Error: $e');
      ShowToastMessage('Insufficient Balance');
      isLoading = false;
      update();
      // Handle any exceptions that occur during the transaction.
    }
  }

  Future<void> sapSpendingToWallet() async {
    try {
      print('hello g');
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(spendingTabController
          .landingPageController.addressData['privateKey']);
      print(
          'private_key: ${spendingTabController.landingPageController.addressData['publicAddress']}');
      //
      final sapTokenContractAddress =
          EthereumAddress.fromHex('0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');
      final recipientAddress =
          EthereumAddress.fromHex(storage.read('public_key'));

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

      final response = await ethClient.sendTransaction(
        credentials,
        transaction,
        chainId: 97, // Set the correct chain ID
      );
      print('response ${response}');
      if (response != null) {
        HistoryListSap.add({
          'userId': storage.read("userId"),
          'receiver_address': storage.read('public_key'),
          'amount': '+${amount.text}',
          'date_time': DateTime.now().toString(),
        });
        spendingHistoryList.add({
          'userId': storage.read("userId"),
          'receiver_address': storage.read('public_key'),
          'amount': '-${amount.text} SAP',
          'date_time': DateTime.now().toString(),
        });
        print('userId :${storage.read("userId")}');
        print('receiver_address :${recipientAddress}');
        print('amount :${amount.text}');
        print('dateTime :${DateTime.now().toString()}');

        update();
        storage.write('sap_transaction_history', HistoryListSap);
        storage.write('spending_transaction_history', spendingHistoryList);
        spendingTabController.isLoading = true;
        spendingTabController.update();
        await spendingTabController.checkBalance();
        await spendingTabController.getHistory();
        spendingTabController.isLoading = false;
        spendingTabController.update();
        isLoading = false;
        update();
        print("Transaction added successfully");
        spendingTabController.onInit();
        update();
        walletController.onInit();
        update();
        arbCoinController.onInit();
        update();
        Get.back();

        ShowToastMessage('Transaction successful');
      } else {
        ShowToastMessage('Transaction was not successful');
        print('Transaction was not successful');
      }
    } catch (e) {
      print('Error: $e');
      ShowToastMessage('Insufficient Balance');
      isLoading = false;
      update();

      // Handle any exceptions that occur during the transaction.
    }
  }

  @override
  void onClose() {
    super.onClose();
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
        EthereumAddress.fromHex(storage.read('public_key'))
      ];

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
      amount.text = formattedBalance.toString();
      return formattedBalance;

      // storage.write(key, value)
    } catch (e) {
      print('Error getting SAP Token balance: $e');
      return "0.00000000"; // Return a default value if an error occurs
    }
  }

  Future<String> getTokenBalancespending() async {
    try {
      print('hello g');
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
        EthereumAddress.fromHex(spendingTabController
            .landingPageController.addressData['publicAddress'])
      ];

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
      amount.text = formattedBalance.toString();
      return formattedBalance;

      // storage.write(key, value)
    } catch (e) {
      print('Error getting SAP Token balance: $e');
      return "0.00000000"; // Return a default value if an error occurs
    }
  }
}
