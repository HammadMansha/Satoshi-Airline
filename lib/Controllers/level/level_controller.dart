import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:web3dart/web3dart.dart';

import '../../Utils/api.dart';
import '../../Utils/app_constants.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Views/AuthScreens/signup.dart';
import '../landingpage_controller.dart';

class LevelController extends GetxController {
  bool isLoading = true;
  bool transactionLoader = false;
  bool isBoost = false;

  RxBool wingPurchase = false.obs;
  RxBool enginePurchase = false.obs;
  RxBool radioPurchase = false.obs;
  RxBool blackBoxPurchase = false.obs;

  String errorString = '';
  String toAddress = "";

  Rx<TextEditingController> avalue = TextEditingController().obs;
  Rx<TextEditingController> runesSapValue = TextEditingController().obs;

  Rx<TextEditingController> selectedValue =
      TextEditingController(text: 'FUEL').obs;
  Rx<TextEditingController> selectedRunesValue =
      TextEditingController(text: 'WING').obs;
  Rx<TextEditingController> selectedRarityValue =
      TextEditingController(text: 'COMMON').obs;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final formKey = GlobalKey<FormState>();

  int currentIndex = 0;

  final storage = GetStorage();
  Map nftData = {};
  Map levelInfo = {};
  String imagePath = '';
  bool isArrgument = false;
  var id;

  var maxValaue;
  var minValue;

  List attributesList = [];
  List runesList = [];
  List rarityList = [];
  RxInt timer = 0.obs;
  RxString t = ''.obs;

  List<Tab> myTabs = [];

  int indexing = 0;
  // String selectedValue = 'FUEL';

  @override
  void onInit() async {
    myTabs = [
      const Tab(text: 'Basic'),
      const Tab(text: 'Pro'),
      Tab(
          icon: Image.asset(
        AppConstants.helpIcon,
        height: 17,
      )),
    ];
    toAddress = dotenv.env['OWNER_RECEIVER_ADDRESS']!;
    update();
    if (Get.arguments != null) {
      imagePath = Get.arguments['path'];
      id = await Get.arguments['id'];
      isArrgument = true;
      update();
      await getAttributes(Get.arguments['id']);
      await getLevelInfo(Get.arguments['id']);
    } else {
      await getData();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    // await getData();
    // isLoading = false;
    runesList = [
      {"id": "WING", "name": "WING", "iconPath": AppConstants.wingIcon},
      {"id": "ENGINE", "name": "ENGINE", "iconPath": AppConstants.engineIcon},
      {"id": "RADIO", "name": "RADIO", "iconPath": AppConstants.radioIcon},
      {
        "id": "BLACK BOX",
        "name": "BLACK BOX",
        "iconPath": AppConstants.blackBoxIcon
      },
    ];

    rarityList = [
      {
        "id": "COMMON",
        "name": "COMMON",
      },
      {
        "id": "RARE",
        "name": "RARE",
      },
      {
        "id": "EPIC",
        "name": "EPIC",
      },
      {
        "id": "LEGENDARY",
        "name": "LEGENDARY",
      },
      {
        "id": "UFO",
        "name": "UFO",
      },
    ];

    super.onReady();
  }

  Future<void> getData() async {
    try {
      if (landingPageController
          .minitingGlobleController.assetsData.isNotEmpty) {
        isLoading = true;
        update();
        imagePath = landingPageController.minitingGlobleController
            .assetsData[currentIndex]['jsonData']['image'];
        id = landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id'];
        update();
        await getAttributes(landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id']);
        await getLevelInfo(landingPageController
            .minitingGlobleController.assetsData[currentIndex]['id']);
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> getAttributes(var v) async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getAttributes + v.toString()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check attribute data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        nftData.addAll(data["data"]);
        await storage.write(
            "mineValue",
            double.parse(
                    (data['data']['attributes']['mine']['value']).toString())
                .toStringAsFixed(2));
        maxValaue = data['data']['attributes']['fuel']['maxValue'];
        minValue = data['data']['attributes']['fuel']['value'];
        attributesList = [
          {
            "id": "FUEL",
            "name": "FUEL",
            "minvalue": "${data['data']['attributes']['fuel']['value']}",
            "value": "${data['data']['attributes']['fuel']['maxValue']}",
            "iconPath": AppConstants.fuelIcon
          },
          {
            "id": "MINE",
            "name": "MINE",
            "minvalue": "${data['data']['attributes']['mine']['value']}",
            "value": "${data['data']['attributes']['mine']['maxValue']}",
            "iconPath": AppConstants.mineIcon
          },
          {
            "id": "DURABILITY",
            "name": "DURABILITY",
            "minvalue": "${data['data']['attributes']['durability']['value']}",
            "value": "${data['data']['attributes']['durability']['maxValue']}",
            "iconPath": AppConstants.durabilityIcon
          },
          {
            "id": "LUCK",
            "name": "LUCK",
            "minvalue": "${data['data']['attributes']['luck']['value']}",
            "value": "${data['data']['attributes']['luck']['maxValue']}",
            "iconPath": AppConstants.luckyIcon
          },
        ];
        wingPurchase.value = data["data"]["wing"];
        enginePurchase.value = data["data"]["engine"];
        radioPurchase.value = data["data"]["radio"];
        blackBoxPurchase.value = data["data"]["blackbox"];

        isLoading = false;
        update();
      } else {
        if (data['message'] == 'Invalid authentication token') {
          await storage.erase();
          Get.offAll(() => const SignUp());
          CommonToast.getToast(
            'Your token is expire please login again',
          );

          // CommonSnackbar.getSnackbar(
          //   "Info",
          //   "your token is expire please login again",
          //   Colors.amber,
          // );
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> getLevelInfo(var v, {String type = '', int levelNo = 0}) async {
    try {
      print("Level $levelNo");
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getLevelInfo + v.toString()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        levelInfo.addAll(data["data"]);
        update();
        print("Total Time ${checkData(levelInfo['expiry'])}");
        if (type != 'booster' && type != '') {
          await landingPageController.notification(
            notificationtitle: 'Congrats !',
            notificationbody: 'Level up from $levelNo to Level ${levelNo + 1}',
            timeinterval: checkData(levelInfo['expiry']),
          );
        }
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> updateAttribute(String a) async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      String uid = await storage.read("userId");
      double c = double.parse(avalue.value.text);
      var b = {
        "userId": uid,
        "tokenId": id.toString(),
        "attribute": a.toLowerCase(),
        "upgradeValue": avalue.value.text,
      };
      print("check $b");
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.buyAttributes),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": uid,
          "tokenId": id.toString(),
          "attribute": a.toLowerCase(),
          "upgradeValue": c,
        }),
      );
      var data = await json.decode(res.body);
      print("Check Data ${data}");
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await getAttributes(id);
        await landingPageController.getBalance();
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      }
    } catch (E) {
      print("check ${E.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> updateLevel(String type, {int levelno = 0}) async {
    try {
      if (kDebugMode) {
        print("Function Call $type");
      }
      Get.back();
      isLoading = true;
      update();
      String token = await storage.read('token');
      var link = type == 'booster'
          ? ApiData.baseUrl + ApiData.boostLevel
          : ApiData.baseUrl + ApiData.updateLevel;
      var res = await http.post(
        Uri.parse(link),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "type": type,
          "tokenId": id.toString(),
        }),
      );
      var data = await json.decode(res.body);
      if (kDebugMode) {
        print("check Data $data");
      }
      if (res.statusCode >= 200 && res.statusCode < 300) {
        nftData.clear();
        levelInfo.clear();
        update();
        if (type == 'booster') {
          AwesomeNotifications().cancelAllSchedules();
        }
        await getAttributes(id);
        await getLevelInfo(id, type: type, levelNo: levelno);
        await landingPageController.getBalance();
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        // CommonSnackbar.getSnackbar(
        //     "Success", data['showableMessage'], Colors.green);
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        // CommonSnackbar.getSnackbar(
        //     "ERROR", data['showableMessage'], Colors.red);
      }
    } catch (e) {
      print("Api Error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  int checkData(String d) {
    DateTime dt1 = DateTime.parse(d);
    DateTime now = DateTime.now();
    // Duration diff = now.difference(dt1);
    Duration diff = dt1.difference(now);
    return diff.inSeconds;
  }

  void runTime() {
    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      timer.value--;
      if (timer.value > 0) {
        runTime();
      }
    });
  }

  String maxValue() {
    return avalue.value.text;
  }

  //----------------------Calculate engine value---------------------
  double calculateEngineValue(double value) {
    return value / 0.05;
  }

  //---------------Calculate dropdown value--------------------------

  String runesValue() {
    print(
        "Selected rarity value--------------${selectedRarityValue.value.text}");
    print(
        "Selected runes value---------------${selectedRunesValue.value.text}");

    if (selectedRarityValue.value.text == "COMMON" &&
        selectedRunesValue.value.text == "WING") {
      runesSapValue.value.text = "30";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "COMMON" &&
        selectedRunesValue.value.text == "ENGINE") {
      var temp = calculateEngineValue(0.20);
      runesSapValue.value.text = temp.toString();
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "COMMON" &&
        selectedRunesValue.value.text == "RADIO") {
      runesSapValue.value.text = "5.0";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "COMMON" &&
        selectedRunesValue.value.text == "BLACK BOX") {
      runesSapValue.value.text = "60";
      return runesSapValue.value.text;
    }

//----------------------------------------RARE SELECTION-------------------------
    else if (selectedRarityValue.value.text == "RARE" &&
        selectedRunesValue.value.text == "WING") {
      runesSapValue.value.text = "50";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "RARE" &&
        selectedRunesValue.value.text == "ENGINE") {
      var temp = calculateEngineValue(0.42);
      runesSapValue.value.text = temp.toString();
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "RARE" &&
        selectedRunesValue.value.text == "RADIO") {
      runesSapValue.value.text = "8.0";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "RARE" &&
        selectedRunesValue.value.text == "BLACK BOX") {
      runesSapValue.value.text = "80";
      return runesSapValue.value.text;
    }

    //----------------------------------------EPIC selection-----------------------------

    else if (selectedRarityValue.value.text == "EPIC" &&
        selectedRunesValue.value.text == "WING") {
      runesSapValue.value.text = "70";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "EPIC" &&
        selectedRunesValue.value.text == "ENGINE") {
      var temp = calculateEngineValue(0.64);
      runesSapValue.value.text = temp.toString();
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "EPIC" &&
        selectedRunesValue.value.text == "RADIO") {
      runesSapValue.value.text = "10";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "EPIC" &&
        selectedRunesValue.value.text == "BLACK BOX") {
      runesSapValue.value.text = "100";
      return runesSapValue.value.text;
    }

    //------------------------------------------------LEGENDARY-------------------------

    else if (selectedRarityValue.value.text == "LEGENDARY" &&
        selectedRunesValue.value.text == "WING") {
      runesSapValue.value.text = "90";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "LEGENDARY" &&
        selectedRunesValue.value.text == "ENGINE") {
      var temp = calculateEngineValue(0.86);
      runesSapValue.value.text = temp.toString();
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "LEGENDARY" &&
        selectedRunesValue.value.text == "RADIO") {
      runesSapValue.value.text = "12";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "LEGENDARY" &&
        selectedRunesValue.value.text == "BLACK BOX") {
      runesSapValue.value.text = "120";
      return runesSapValue.value.text;
    }

    //--------------------------------------UFO----------------------------------------------

    else if (selectedRarityValue.value.text == "UFO" &&
        selectedRunesValue.value.text == "WING") {
      runesSapValue.value.text = "110";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "UFO" &&
        selectedRunesValue.value.text == "ENGINE") {
      var temp = calculateEngineValue(1.30);
      runesSapValue.value.text = temp.toString();
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "UFO" &&
        selectedRunesValue.value.text == "RADIO") {
      runesSapValue.value.text = "15";
      return runesSapValue.value.text;
    } else if (selectedRarityValue.value.text == "UFO" &&
        selectedRunesValue.value.text == "BLACK BOX") {
      runesSapValue.value.text = "140";
      return runesSapValue.value.text;
    }

    return "";
  }

  Future<String> sendSapTokensWithContract(double cost) async {
    try {
      update();
      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(storage.read('private_key'));
      print('private_key: ${storage.read('private_key')}');

      final sapTokenContractAddress =
          EthereumAddress.fromHex('0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');
      final recipientAddress = EthereumAddress.fromHex(toAddress);

      // Parse the amount.text as a double and then convert it to BigInt
      if (cost == null) {
        // Handle the case where amount.text is not a valid number
        print('Invalid amount: ${cost}');
        return "";
      }

      final amountInWei = BigInt.from((cost * 1e8).toInt());
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

      final response = await ethClient.sendTransaction(
        credentials,
        transaction,
        chainId: 97, // Set the correct chain ID
      );
      print('response of transection ${response}');
      return response;
    } catch (e) {
      update();
      ShowToastMessage('Transaction was not successful');
      print('Error: $e');
      return "";
      // Handle any exceptions that occur during the transaction.
    }
  }

  Future<void> purchaseRunes() async {
    try {
      String token = await storage.read('token');
      String userId = await storage.read('userId');

      print("Owner address---------------------$toAddress");

      //---------------------------Step 1 find wallet balance----------------------

      double cost = double.parse(runesValue());
      print("Calculated cost is------------------$cost");
      double tokenBalance = landingPageController.tokenBalance;

      if (tokenBalance >= cost) {
        transactionLoader = true;
        update();
        //---------------------------Step 2 perform transaction------------------
        var transactionResponse = await sendSapTokensWithContract(cost);
        if (transactionResponse != "") {
          //-------------------------Step 3 call API---------------------
          var res = await http.post(
            Uri.parse(ApiData.runesPurchase),
            headers: {
              'Authorization': token,
              'Content-Type': 'application/json',
            },
            body: json.encode({
              "userId": userId,
              "tokenId": id,
              "rune": selectedRunesValue.value.text.toLowerCase(),
              "cardType": selectedRarityValue.value.text.toLowerCase()
            }),
          );
          print("status code of purchase api--------------${res.statusCode}");
          print("response of purchase api--------------${res.body}");

          var data = await json.decode(res.body);
          if (res.statusCode == 200) {
            landingPageController.onInit();

            if (selectedRunesValue.value.text == "WING") {
              wingPurchase.value = true;
            } else if (selectedRunesValue.value.text == "RADIO") {
              radioPurchase.value = true;
            } else if (selectedRunesValue.value.text == "ENGINE") {
              enginePurchase.value = true;
            } else if (selectedRunesValue.value.text == "BLACK BOX") {
              blackBoxPurchase.value = true;
            }

            transactionLoader = false;
            update();

            ShowToastMessage("Runes purchase successfully");
          }
        }
      } else {
        transactionLoader = true;
        update();
        ShowToastMessage("Insufficient balance");
      }
    } catch (e) {
      transactionLoader = true;
      update();
      print(e);
    }
  }
}
