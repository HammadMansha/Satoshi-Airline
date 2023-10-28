import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landing/basic_controller.dart';
import 'package:satoshi/Controllers/wallet/tabarview_controller.dart';
import '../../Services/wallet_services.dart';
import '../../Utils/api.dart';
import '../../Utils/commonSnackbar.dart';
import 'package:http/http.dart' as http;
import '../../widget/wallet_widgets/common_toast_message.dart';

class ImportWalletController extends GetxController {
  bool isLoading = true;
  bool isClock = false;
  final publicKey = RxString('');
  final private = RxString('');
  final storage = GetStorage();
  final formKey = GlobalKey<FormState>();
  int seconds = 180;
  Timer? countdownTimer;

  TextEditingController words = TextEditingController();
  TextEditingController pin = TextEditingController();

  WalletAddress service = WalletAddress();
  BasicController controller2=Get.put(BasicController());

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> recover() async {
    final privatekey = await service.getPrivateKey(words.text);
    final public = await service.getPublicKey(privatekey);
    await storage.write('private_key', privatekey);
    await storage.write('public_key', public.toString());

    print("Private key $privatekey");
    print("Public Key $public");
    publicKey.value = public.hex;
    private.value = privatekey;
    storage.write('mnemonics', words.text);
  }

  Future<void> sendEmailCode() async {
    try {
      String token = await storage.read('token');
      print('hello g');
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.sendEmailCodeWallet),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "userId": storage.read('userId'),
            "reason": "import_wallet",
          },
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        isLoading = false;
        update();
        print("Data is $data");
        startTimer(); // Start the countdown timer
        isLoading = false;
        CommonToast.getToast("Please check your email");
        isClock = true;
        update();
      } else {
        isLoading = false;
        update();
        print("Data is $data");
        CommonToast.getToast("Something went wrong");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Errror is ${e.toString()}");
    }
  }

  Future<bool> verifysendEmailCode() async {
    try {
      String token = await storage.read('token');
      // isLoading = true;
      // update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.verifysendEmailCodeWallet),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "userId": storage.read('userId'),
            "reason": "import_wallet",
            'emailCode': pin.text
          },
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        isLoading = false;
        update();
        print("Data is $data");
        CommonToast.getToast("Email Verify Successfully");
        return true; // Verification successful
      } else {
        isLoading = false;
        update();
        print("Data is $data");
        ShowToastMessage('Verification code is incorrect');
        return false; // Verification failed
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error is ${e.toString()}");
      return false; // Verification failed due to an error
    }
  }

  startTimer() {
    seconds = 180;
    isClock = true;
    update();

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        stopTimer();
      }
    });
  }

  stopTimer() {
    countdownTimer?.cancel();
    isClock = false;
    update();
  }
}
