import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' show cos, sqrt, asin, pi, pow, sin;
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/landing/miniting_globle.dart';
import 'package:satoshi/Services/wallet_services.dart';
import 'package:satoshi/Utils/app_constants.dart';
import 'package:web3dart/web3dart.dart';
import '../Utils/api.dart';
import '../Utils/commonSnackbar.dart';
import '../Views/AuthScreens/signup.dart';

class LandingPageController extends GetxController {
  bool isLoading = true;
  bool internetConnection = false;
  var tokenBalance = 0.00;
  final publicKey = RxString('');
  var sapCoin = 0.00.obs;
  var balanceInBNB = 0.00;
  bool isSound = true;

  int currentIndex = 1;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  // MarketPlaceController marketPlaceController = MarketPlaceController();
  final storage = GetStorage();

  Map user = {}.obs;
  Map balanceData = {};

  RxString assetImage = ''.obs;
  RxString username = ''.obs;

  MinitingGlobleController minitingGlobleController = Get.put(MinitingGlobleController(), permanent: true);
  MinitingGlobleController mgc = Get.find<MinitingGlobleController>();

  //<------------- Wallet ---------->

  WalletAddress walletAddress = WalletAddress();
  Map addressData = {};

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.comingSoonSound));
  }

  // <---------- Get Current Location ------>
  double livelat = 0.0;
  double livelong = 0.0;

  bool isStopped = true;

  //<------ User Travel History ------->

  List travelHistory = [];

  @override
  void onInit() {
    updateTokenBalance();
    checkBalance();
    minitingGlobleController.getUserNftData();
    update();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    if (storage.hasData('sound')) {
      isSound = storage.read('sound');
      update();
    }
    if (storage.hasData('session_tolat') &&
        storage.hasData('checkout_complete') == false) {
      isStopped = false;
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await getUser();
    await getBalance();
    await getAddress();
    if (storage.hasData('session_tolat')) {
      getCurrentLocationRealtime();
    }
    if (storage.hasData('invite_code')) {
      await getGraphData();
      if (travelHistory.isNotEmpty) {
        storage.write('invite_code', '');
      }
      print("Check Storage ${storage.read('invite_code')}");
    }
    initDynamicLinks();
    isLoading = false;
    update();
    super.onReady();
  }

  //<---------- Firebase Dynamic links ------------->

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print("Dynmaic Link ${dynamicLinkData.link.query}");
      String c =
          dynamicLinkData.link.query.toString().split('invitecode=').last;
      String code = c.split('%').first;
      print("Code is $code");
      //<------- function triger when user open app with invite url ----->
      await getGraphData();
      if (travelHistory.isEmpty) {
        storage.write('invite_code', code);
      } else {
        storage.write('invite_code', '');
      }
      print("Check Storage ${storage.read('invite_code')}");
      //<-------- Add Your Funcationality -------->
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> getGraphData() async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      String wallet = await storage.read('wallet');
      var res = await http.get(
        Uri.parse(
            '${ApiData.baseUrl}/travel/get-travel-history/$wallet/year/0'),
        headers: {
          // 'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        data['graphData'].forEach(
          (e) {
            travelHistory.add(e);
          },
        );
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("Check Error ${e.toString()}");
      }
    }
  }

  Future<void> getAddress() async {
    try {
      String id = await storage.read("userId");
      String token = await storage.read('token');
      var res = await Dio().get(
        ApiData.baseUrl + ApiData.getaddress + id,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      var data = res.data;
      if (res.statusCode!.toInt() >= 200 && res.statusCode!.toInt() <= 300) {
        print("APi Response $data");
        addressData.addAll(data['data']);
        isLoading = false;
        update();
      }
    } on DioException catch (e) {
      var error = e.response!.data;
      if (kDebugMode) {
        print("Get Addresses Api Error $error");
      }
      await createAddress();
      CommonToast.getToast("${error['message']}");
      isLoading = false;
      update();
    }
  }

  Future<void> createAddress() async {
    try {
      final words = await walletAddress.generateMnemonic();
      final privatekey = await walletAddress.getPrivateKey(words);
      final publickey = await walletAddress.getPublicKey(privatekey);
      String privateAddress = privatekey;
      String publicAddress = publickey.toString();
      String id = await storage.read("userId");
      String token = await storage.read('token');
      update();
      print("Private_spending $privatekey");

      print("Public_spending $publickey");
      storage.write('Public_spending', publicAddress);
      var res = await Dio().post(
        ApiData.baseUrl + ApiData.saveaddress,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        }),
        data: {
          "userId": id,
          "publicAddress": publicAddress,
          "privateKey": privateAddress,
        },
      );
      var data = res.data;
      if (res.statusCode!.toInt() >= 200 && res.statusCode!.toInt() <= 300) {
        print("APi Response $data");
        await getAddress();
        isLoading = false;
        update();
      }
    } on DioException catch (e) {
      var error = e.response!.data;
      if (kDebugMode) {
        print("Address create Error $error");
      }
      CommonToast.getToast("${error['message']}");
      isLoading = false;
      update();
    }
  }

  void getCurrentLocationRealtime() {
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (isStopped == true) {
        t.cancel();
      } else {
        print("Location is working");
        getLatLngLive();
      }
    });
  }

  //<----------- Current Location Realtime -------->

  getLatLngLive() async {
    Future<Position> data = determinePosition();
    data.then(
      (value) async {
        livelat = value.latitude;
        livelong = value.longitude;
        update();
        if (storage.hasData('session_tolat') == false) {
          isStopped = true;
          update();
          getCurrentLocationRealtime();
        } else {
          if (distance(livelat, livelong, storage.read('session_tolat'),
                  storage.read('session_tolng')) <=
              5) {
            storage.write('checkout_complete', 'done');
            isStopped = true;
            update();
            await notification(
              notificationtitle: 'Congratulations',
              notificationbody:
                  'Please collect your reward within the 24 hours',
              timeinterval: 0,
            );
            getCurrentLocationRealtime();
          }
        }
      },
    );
  }

  //<--------- For Current Location ----------->

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CommonToast.getToast(
        'Location services are disabled.',
      );
      // CommonSnackbar.getSnackbar(
      //     "Warning", "Location services are disabled.", Colors.blue);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CommonToast.getToast(
          'Location permissions are denied',
        );

        // CommonSnackbar.getSnackbar(
        //     "Warning", "Location permissions are denied", Colors.blue);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonToast.getToast(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //<----------------------------------------------------------------------->

  //<---------------- Get Difference ------------->

  double distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a =
        _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));

    return r * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  num _haversin(double radians) => pow(sin(radians / 2), 2);

  Future<void> getUser() async {
    try {
      internetConnection = false;
      update();
      String id = await storage.read("userId");
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getUser + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = await json.decode(res.body);
      user = data['data'];
      await storage.write("wallet", data['data']['walletAddress']);
      mgc.assetsData.clear();
      mgc.update();
      await mgc.getUserNftData();
      // await mgc.getWalletOfOwner(data['data']['walletAddress']);
      if (user['avatar'] != null) {
        assetImage.value = user['avatar']['path'];
      }
      username.value = user['name'] ?? 'Satoshi01';
      update();
      if (kDebugMode) {
        print("Check Data is $data");
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("Internet Error ${e.toString()}");
      }
      isLoading = false;
      internetConnection = true;
      update();
      CommonToast.getToast(
          "Please check your internet connection and restart your app again");
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> getBalance() async {
    try {
      String token = await storage.read('token');
      String address = await storage.read('wallet');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getBalance + address),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = await json.decode(res.body);
      if (kDebugMode) {
        print("Res body: $data");
        print("Res body: ${res.statusCode}");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        balanceData.addAll(data['response']);
        update();
      } else {
        isLoading = false;
        update();
        if (data['message'] == 'Invalid authentication token') {
          await storage.erase();
          Get.offAll(() => const SignUp());
          CommonToast.getToast(
            'Your token is expire please login again',
          );
        }
      }
    } catch (e) {
      print("data error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  //<------- Local Notification -------->

  Future<void> notification(
      {String notificationtitle = '',
      String notificationbody = '',
      int timeinterval = 0}) async {
    try {
      String localTimeZone =
          await AwesomeNotifications().getLocalTimeZoneIdentifier();
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: notificationtitle,
          body: notificationbody,
          actionType: ActionType.Default,
          criticalAlert: true,
        ),
        schedule: NotificationInterval(
          interval: timeinterval,
          timeZone: localTimeZone,
          preciseAlarm: true,
        ),
      );
    } catch (e) {
      print("Notification Error ${e.toString()}");
    }
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
    print('token balnace is ,,,,,,${tokenBalance}');
    update();
  }
}
