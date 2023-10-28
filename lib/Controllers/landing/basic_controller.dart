import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

class BasicController extends GetxController {
  bool isLoading = true;

  final storage = GetStorage();

  LandingPageController landingPageController = Get.find<LandingPageController>();

  String address = '';

  String spendingAddress = '';
  final publicKey = GetStorage().read('public_key');

  @override
  void onInit() async {
    print("run after import");
    // address = storage.read('wallet').toString().replaceRange(5, 30, '....');
    address = storage.read('wallet');
   // publicKey = storage.read('public_key');
    publicKey;
    update();
   print('public_key_wallet_is  $publicKey');
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  String addressChange(String a) {
    return a.replaceRange(5, 20, '....');
  }
}
