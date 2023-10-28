import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

class BasicTabController extends GetxController {
  bool isLoading = true;

  final storage = GetStorage();

  LandingPageController landingPageController = Get.find<LandingPageController>();

  String address = '';

  @override
  void onInit() async {
    // address = storage.read('wallet').toString().replaceRange(5, 30, '....');
    address = storage.read('wallet');
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
