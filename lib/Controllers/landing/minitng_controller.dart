import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:satoshi/Controllers/landing/miniting_globle.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:web3dart/web3dart.dart';

class MintingController extends GetxController {
  bool isLoading = true;

  // WalletConnect? connector;
  // var session;

  ScrollController scrollController = ScrollController();

  MinitingGlobleController minitingGlobleController =
      Get.find<MinitingGlobleController>();

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  // // WebThreeServices webThreeServices = WebThreeServices();

  // var wallet;
  // String? encryptedWallet;
  int counter = 1;
  final storage = GetStorage();
  String privateKey = "";
  String publicKey = "";
  String contractAddress = "0xbA02D759E32196f4bf0Cb4b384a8807214907B21";
  String addressChange(String a) {
    return a.replaceRange(5, 30, '....');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    publicKey = storage.read("public_key");
    privateKey = storage.read("private_key");
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  nftIncrement() {
    if (counter < 1) {
      counter++;
      update();
    }
  }

  nftDecrement() {
    counter--;
    update();
  }

  Future<void> getMint() async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      print('token{$token}');
      String address = await storage.read('public_key');
      print('public_key......{$address}');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.postMint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "to": address,
          },
        ),
      );

      var data = json.decode(res.body);
      print('data is ..........${data}');
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        if (kDebugMode) {
          print("Check Result $data");
        }
        await minitingGlobleController.getUserNftData(recall: true);
        Get.back();
        Get.back();
        landingPageController.currentIndex = 0;
        landingPageController.update();
        isLoading = false;
        update();
        CommonToast.getToast('Mint success! Data fetching automatically soon');
      } else {
        if (kDebugMode) {
          print("Check Result $data");
        }
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      }
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("Check Error ${e.toString()}");
      }
    }
  }

  Future<void> mintNFT() async {
    try {
      isLoading = true;
      update();
      final client = Web3Client(
        'https://data-seed-prebsc-1-s1.binance.org:8545',
        http.Client(),
      );
      final credentials = await EthPrivateKey.fromHex(privateKey);

      String abi =
          await rootBundle.loadString("assets/contract/mintingNft.json");
      print('ABI: $abi');
      final contract = DeployedContract(
        ContractAbi.fromJson(
          abi, // Replace with your NFT contract's ABI
          'NFTContract',
        ),
        EthereumAddress.fromHex(contractAddress),
      );
      print("print 1------------------------");

      final function = contract.function(
          'CommonMint'); // Replace 'mint' with the actual minting function name
      print("print 2---------------------------");

      final double etherAmount = 0.0001;
      final int weiAmount = (etherAmount * 1e18).toInt(); // 1 Ether = 10^18 Wei
      final BigInt valueToSend = BigInt.from(weiAmount);
      final EtherAmount etherValue = EtherAmount.inWei(valueToSend);

      final transaction = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [BigInt.from(1)],
        value: etherValue,
      );
      print("print 3---------------------------");

      // Adjust gas limit as needed
      final response = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 97, // Ethereum mainnet
      );

      print("print 4---------------------------");

      if (response != null) {
        print("NFT minted with transaction hash: ${response.toString()}");
        await minitingGlobleController.getUserNftData(recall: true);
        Get.back();
        Get.back();
        landingPageController.currentIndex = 1;
        landingPageController.update();
        isLoading = false;
        update();
        CommonToast.getToast('Mint success! Data fetching automatically soon');
      } else {
        CommonToast.getToast('Something went wrong mint failed');
      }
    } catch (e) {
      // Handle any exceptions that occur during the minting process
      print('Error during NFT minting: $e');
      if(e.toString().contains("insufficient")){
        CommonToast.getToast('You have insufficient balance');

      }else{
        CommonToast.getToast('Minting after 24 hours');

      }
      isLoading = false;
      update();
    }
  }
}
