import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Views/AuthScreens/2factor_auth/link_google.dart';
import '../text_widget/text_widget.dart';

class SettingDialogBox extends StatelessWidget {
  const SettingDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
// actionsPadding: const EdgeInsets.only(bottom: 100),
      backgroundColor: const Color(0xffDDFFF4),

      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const MyText('Google Authenticator',
                fontSize: 13, fontWeight: FontWeight.w700)
            .marginOnly(left: 35),
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(child: Image.asset(AppAssets.crossIcon))),
        const SizedBox(height: 74)
      ]),
      actionsOverflowButtonSpacing: 80,
      actionsPadding: const EdgeInsets.only(left: 10, right: 10),

      actions: <Widget>[
        const Align(
            alignment: Alignment.center,
            child: MyText(
                'You must have Google Authentication turned on in order to perform this action',
                fontSize: 14,
                fontWeight: FontWeight.w300)),
        Container(
          height: Get.height / 15,
          width: Get.width,

// color: Colors.red,

          child: Stack(
            children: [
              Positioned(
                  top: 4,
                  left: 2,
                  child: Container(
                    width: Get.width / 1.5,
                    height: 48,
                    decoration: BoxDecoration(
                        color: const Color(0xff000000),
                        border: Border.all(
                          color: Colors.black,
                          width: 1, // <-- set border width here
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ).marginOnly(left: 12, right: 12)),
              Positioned(
// top: 82,
                  left: 11,
                  child: Container(
                      width: Get.width / 1.5,
                      height: 48,
                      decoration: BoxDecoration(
// color: const Color(0xffFFFDFD),
                          color: const Color(0xffFFBB42),
                          border: Border.all(
                            color: Colors.black,
                            width: 1, // <-- set border width here
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: InkWell(
                        onTap: () {
                          Get.to(() => const GoogleLink());
                        },
                        child: const MyText(
                          'Go to settngs',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )))),
            ],
          ),
        ).marginOnly(bottom: 100)
      ],
    );
  }
}
