import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controllers/wallet/seed_pharse_recover_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class SeedPhaseRecover extends StatelessWidget {
  const SeedPhaseRecover({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SeedPhaseController>(
      init: SeedPhaseController(),
      builder: (_) {
        return SafeArea(
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: AppColor.primary,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const TopTransfer('SEED PHRASE'),
                    const SizedBox(height: 40),
                    buildShortContainer(_),
                    const MyText(
                      'Do not create a digital copy such as a screenshot, text file, or email.',
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ).marginOnly(top: 20),
                    GestureDetector(
                      onLongPress: () {
                        _.toggleMnemonics(true);
                      },
                      onLongPressUp: () {
                        _.toggleMnemonics(false);
                      },
                      child: const MyText(
                        'PRESS AND HOLD TO REVEAL',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0EA375),
                      ).marginOnly(top: 40),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildShortContainer(SeedPhaseController controller) {
    return ShortContainer(
      height: Get.height / 1.7,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(AppAssets.seedPhrase, width: 33).marginOnly(top: 30),
          Text(
            'Write down your Seed Phrase in the correct order on paper',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Color(0xff858585),
            ),
          ).marginOnly(top: 12, bottom: 12),
          buildMnemonicListView(controller),
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget buildMnemonicListView(SeedPhaseController controller) {
    return Obx(() {
      String mnemonicList = GetStorage().read('mnemonics');

      return GetStorage().hasData('mnemonics')
          ? controller.showMnemonics.value
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mnemonicList.split(' ').length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    final number =
                        (index + 1).toString(); // Pad with leading zeros
                    final words = mnemonicList.split(' ');
                    final word = words[index];
                    return Row(
                      children: [
                        SizedBox(
                          width: Get.width / 10,
                          child: Text(
                            '$number',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: const Color(0xff858585),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Adjust the width as needed
                        Text(
                          word,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    );
                  },
                ).marginOnly(left: 130)
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                    width: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final number =
                        (index + 1).toString(); // Pad with leading zeros
                    final words = '----------';

                    return Row(
                      children: [
                        Container(
                          // color: Colors.red,

                          width: Get.width / 10,

                          child: Text(
                            '$number',
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: const Color(0xff858585),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Adjust the width as needed
                        Text(
                          words,
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ).marginOnly(left: 130)
          : Center(child: Text('No Data Here'));
    });
  }
}
