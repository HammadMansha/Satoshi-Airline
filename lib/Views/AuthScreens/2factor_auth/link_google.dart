import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import 'backup_key.dart';

class GoogleLink extends StatelessWidget {
  const GoogleLink({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    ProfileController controler = Get.find<ProfileController>();

    return SafeArea(
      child: MediaQuery(
        data: mqDataNew,
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: Column(
            children: [
              topBar(controler),
              Image.asset(
                AppAssets.mobileIcon,
                height: Get.height / 10,
                width: Get.width / 5,
              ).marginOnly(top: 50),
              linkButtons().marginOnly(top: 50),
              SizedBox(
                height: 20,
              ),
              googleButton()
            ],
          ),
        ),
      ),
    );
  }
}

Widget linkButtons() {
  return InkWell(
    onTap: () {
      Get.to(() => BacKUpKey());
    },
    child: Container(
        width: 300,
        height: Get.height / 17,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                // Set your shadow color here
                offset: Offset(0, 2),
                // Offset of the shadow (horizontal, vertical)
                blurRadius: 4,
                // Blur radius
                spreadRadius: 0, // Spread radius
              ),
            ],
            // color: const Color(0xffFFFDFD),
            color: AppColor.cntrColor,
            border: Border.all(
              color: Colors.black,
              width: 1, // <-- set border width here
            ),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
            child: MyText(
          'LINK',
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ))).marginOnly(left: 33, right: 33),
  );
}

Widget googleButton() {
  return InkWell(
    onTap: () {
      openPlayStoreForAuthentication();
    },
    child: Center(
      child: Image.asset(
        AppAssets.googleAuthentication,
        width: 300,
        height: 54,
      ),
    ),
  );
}

Widget topBar(ProfileController controller) {
  return SizedBox(
    width: Get.width,
    height: Get.height / 9,
    // color: Colors.red,

    child: Padding(
      padding: const EdgeInsets.only(left: 12, top: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              controller.onInit();

              Get.back();

              // Get.off(const WalletScreenOne());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 42,
                width: 42,
                child: Image.asset(AppAssets.backButton),
              ),
            ),
          ),
          const SizedBox(
            width: 17,
          ),
          SizedBox(
              height: Get.height / 9,
              width: Get.width / 1.3,
              child: Stack(
                children: [
                  Positioned(
                    top: 23,
                    left: 2,
                    child: Transform(
                      transform: Matrix4.identity(),
                      child: Container(
                        width: Get.width / 1.4,
                        height: 39,
                        decoration: BoxDecoration(
                            color: const Color(0xff62C8A9),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5, // <-- set border width here
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    // left: 67,
                    child: Transform(
                      transform: Matrix4.identity(),
                      child: Container(
                          width: Get.width / 1.4,
                          height: 39,
                          decoration: BoxDecoration(
                              // color: const Color(0xffFFFDFD),
                              //   color: AppColor.buttonColor,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5, // <-- set border width here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'LINK',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: 'Sora'),
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ),
  );
}

Future<void> openPlayStoreForAuthentication() async {
  print('hello g');
  const playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2';

  if (await canLaunch(playStoreUrl)) {
    await launch(playStoreUrl);
  } else {
    throw 'Could not launch $playStoreUrl';
  }
}
