import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MinitingGlobleController extends GetxController {
  bool isLoading = true;

  String rpcUrl = '';
  String contractAddress = '';
  String contractAddress2 = '';

  List value = [];
  RxList assetsData1 = [].obs;
  RxList assetsData = [].obs;
  RxList tokenDataList = [].obs;
  var price;

  final storage = GetStorage();

  int itselfCall = 0;
  int nftdataFunCall = 0;
  String url = '';
  var tokenId;

  @override
  void onInit() async {
    rpcUrl = dotenv.env["RPC"]!;
    contractAddress = dotenv.env["TOKEN_CONTRACT_ADDRESS"]!;
    // contractAddress2 = dotenv.env["TOKEN_CONTRACT_ADDRESS"]!;
    print('contract addresss..............${contractAddress}');
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    super.onReady();
  }

  Future<void> getDataFromJson(String url, {var value}) async {
    try {
      // String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("json Data is $data");
        print("Status code ${res.statusCode}");
      }
      if (data['error'].toString().contains('Request failed')) {
        if (nftdataFunCall < 3) {
          nftdataFunCall++;
          update();
          print("Url Data $url");
          print("Url Data $tokenId");
          await getDataFromJson(url, value: tokenId);
        }
      } else {
        assetsData.add({"id": value, "jsonData": data});
        nftdataFunCall = 0;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      CommonToast.getToast(
          'Something went wrong please refresh again'); // CustomToast.showToast(
      if (kDebugMode) {
        print("Data Error in get api ${e.toString()}");
      }
    }
  }

  Future<void> getUserFreeNftData({bool recall = false}) async {
    try {
      print('getUserFreeNftData is ..................');
      if (recall) {
        isLoading = true;
        assetsData1.clear();
      }
      String address = storage.read('public_key');
      print('adrees is ..................${address}');

      String token = await storage.read('token');

      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.nftdata),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      var data = json.decode(res.body);
      print('data is ..................${res.statusCode}');
      if (recall && data['status'].toString() == 'false') {
        getUserNftData(recall: true);
      } else {
        assetsData1.clear(); // Clear the list before populating it
        data['nfts'].forEach((e) {
          assetsData1.add({
            "id": e['token_id'],
            "token_uri": e['token_uri'],
            "cardLevel": e['cardLevel'],
          });
        });
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print("Api Error is ${e.toString()}");
    }
  }

  Future<void> getUserNftData({bool recall = false}) async {
    try {
      print('getUserNftData is ..................');
      if (recall) {
        isLoading = true;
        assetsData.clear();
      }

      //String address = await storage.read('public_key');
      String address = storage.read('public_key');
      print('adrees is ..................${address}');

      String token = await storage.read('token');

      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.nftdata + address),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      var data = json.decode(res.body);
      print('data is ..................${res.body}');
      if (recall && data['status'].toString() == 'false') {
        getUserNftData(recall: true);
      } else {
        assetsData.clear(); // Clear the list before populating it
        data['nfts'].forEach((e) {
          assetsData.add({
            "id": e['token_id'],
            "token_uri": e['token_uri'],
            "cardLevel": e['cardLevel'],
          });
        });
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print("Api Error is ${e.toString()}");
    }
  }

  // Future<bool> hasAddressMinted(String rpcUrl, String contractAddress, String userAddress) async {
  //   final client = Web3Client(rpcUrl, Client());
  //
  //   final contract = DeployedContract(
  //     ContractAbi.fromJson(contractAbi, "YourContractName"),
  //     EthereumAddress.fromHex(contractAddress),
  //   );
  //
  //   final hasMintedFunction = contract.function('_hasMinted');
  //   final result = await client.call(
  //     contract: contract,
  //     function: hasMintedFunction,
  //     params: [EthereumAddress.fromHex(userAddress)],
  //   );
  //
  //   return result[0] as bool;
  // }
  //
  // const contractAbi = '[YOUR_CONTRACT_ABI]'; // Make sure to replace with your actual ABI
  //

  Future<void> launchUrlFun(Uri u) async {
    if (!await launchUrl(u)) {
      throw Exception('Could not launch $u');
    }
  }
}
