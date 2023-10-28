import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Views/Wallet/creat_and_import/import_wallet/import_wallet_screen.dart';
import '../../../Views/Wallet/creat_and_import/new_wallet_create.dart';
import '../text_widget/text_widget.dart';
// import 'new_wallet_dialog.dart';

class CreateAndImport extends StatelessWidget {
  const CreateAndImport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffDDFFF4),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: EdgeInsets.only(left: 60),
          child: MyText('ARBITRUM WALLET',
              fontSize: 13, fontWeight: FontWeight.w700),
        ),
        InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(child: Image.asset(AppAssets.crossIcon),radius:
              42,)),
      ]),
      actions: <Widget>[
        Container(
          width: Get.width,
          height: Get.height / 19,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Get.to(()=>newWalletDialog());
                Get.to(() => NewWallet());
              },
              child: MyText('Create a new wallet',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ).marginOnly(left: 15, right: 15),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: Get.height / 10,
          width: Get.width,
          // color: Colors.red,

          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: Get.width,
                  height: Get.height / 19,
                  decoration: BoxDecoration(
                      color: const Color(0xff000000),
                      border: Border.all(
                        color: Colors.black,
                        width: 1, // <-- set border width here
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ).marginOnly(left: 17, right: 17),
              ),
              Positioned(
                // top: 82,
                // left: 16,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ImportWalletScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height / 19,
                    decoration: BoxDecoration(
                        // color: const Color(0xffFFFDFD),
                        color: const Color(0xffFFBB42),
                        border: Border.all(
                          color: Colors.black,
                          width: 1, // <-- set border width here
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: MyText(
                        'Import a wallet using Seed Pharse',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).marginOnly(left: 17, right: 17),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
