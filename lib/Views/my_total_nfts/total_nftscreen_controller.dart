import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:web3dart/web3dart.dart';
import '../../Controllers/landing/miniting_globle.dart';
import '../../Controllers/landingpage_controller.dart';
import '../../Utils/commonSnackbar.dart';
import 'package:http/http.dart' as http;

class MyNftsScreenController extends GetxController {
  final formKey2 = GlobalKey<FormState>();
  bool isLoading = true;
  String assetImage = '';
  int selectedIndex = 0;

  MinitingGlobleController minitingGlobleController =
      Get.put(MinitingGlobleController(), permanent: true);
  MinitingGlobleController mgc = Get.find<MinitingGlobleController>();
  TextEditingController transferController = TextEditingController();
  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();

  int indexing = 0;
  RxList nftDaTA = [].obs;
  String publicKey = "";
  String privateKey = "";
  String contractAddress = "0xbA02D759E32196f4bf0Cb4b384a8807214907B21";
  String nftId = "";

  @override
  void onInit() async {
    publicKey = storage.read("public_key");
    privateKey = storage.read("private_key");
    minitingGlobleController.getUserNftData();
    // abi = await rootBundle.loadString("assets/contract/contract.nft.json");

    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> pullRefresh() async {
    // landingPageController.isLoading.obs();
    landingPageController.minitingGlobleController.assetsData.clear();
    landingPageController.minitingGlobleController.update();
    await landingPageController.minitingGlobleController
        .getUserNftData(recall: true);
    CommonToast.getToast('Wait, data fetching...');
  }

  String addressChange(String a) {
    return a.replaceRange(5, 25, '....');
  }

  // Import Fluttertoast for showing toasts

  Future<void> transferNFT(
    String privateKey,
    String contractAddress,
    String fromAddress,
    String toAddress,
    int tokenId,
  ) async {
    try {
      print('$privateKey');
      print('$contractAddress');
      print('$fromAddress');
      print('$toAddress');
      print('$tokenId');
      final client = Web3Client(
        'https://data-seed-prebsc-1-s1.binance.org:8545',
        http.Client(),
      );

      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));

      String abi =
          await rootBundle.loadString("assets/contract/mintingNft.json");
      print('ABI: $abi');

      final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'contract.abi.json'), // Load contract ABI
        EthereumAddress.fromHex(contractAddress),
      );
      // final approveFunction = contract.function('approve');
      //
      // // Encode the parameters for the approve function
      // final approveData = approveFunction.encodeCall(
      //     [EthereumAddress.fromHex(toAddress), BigInt.from(tokenId)]);
      // print("print");
      //
      // // Create a transaction to call the approve function with gas and gas price specified
      // final approveTransaction = Transaction.callContract(
      //   contract: contract,
      //   function: approveFunction,
      //   parameters: [EthereumAddress.fromHex(toAddress), BigInt.from(tokenId)],
      //   from: credentials.address,
      //   gasPrice: EtherAmount.inWei(
      //       BigInt.parse('2000000000')), // Set your desired gas price
      //   maxGas: 50000, // Adjust gas limit according to your contract
      // );
      //
      // print("print 1");
      // // Build and sign the approve transaction
      //
      // final approveTransactionSigned =
      //     await client.sendTransaction(credentials, approveTransaction);
      //
      // print('Approval Transaction hash: ${approveTransactionSigned.hashCode}');
      //
      // // Once the approval is confirmed, the receiver can perform the transfer
      // print("print 2");

      final function = contract.function('transferFrom');
      print('print :1');
      final transaction = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          EthereumAddress.fromHex(fromAddress),
          EthereumAddress.fromHex(toAddress),
          BigInt.from(tokenId),
        ],
        from: credentials.address,
      );
      print('print :2');
      final chainId = await client.getNetworkId();
      print('chain Id ${chainId}');
      final tx = await client.sendTransaction(
        credentials,
        transaction,
        chainId: chainId,
      );
      print('Transaction hash: ${tx}');
      if (tx != null) {
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        ShowToastMessage('NFT send Successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
