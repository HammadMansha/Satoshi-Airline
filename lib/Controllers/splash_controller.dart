import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/routes/app_routes.dart';

class SplashController extends GetxController {
  final storage = GetStorage();

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void onInit() {
    initDynamicLinks();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2), () {
      if (storage.hasData("token")) {
        Get.offAllNamed(Routes.landingRoutes);
        // Get.offAll(() => const LandingPage());
      } else {
        Get.offAllNamed(Routes.signupRoutes);
        // Get.offAll(() => const SignUp());
      }
    });
    super.onReady();
  }


  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print("Dynmaic Link ${dynamicLinkData.link.path}");
      //<------- function triger when user open app with invite url ----->
      String c =
          dynamicLinkData.link.query.toString().split('invitecode=').last;
      String code = c.split('%').first;
      print("Code is $code");
      storage.write('invite_code', code);
      print("Storage is ${storage.read('invite_code')}");
      //<-------- Add Your Funcationality -------->
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }


}
