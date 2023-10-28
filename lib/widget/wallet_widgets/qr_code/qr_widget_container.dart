import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/widget/wallet_widgets/qr_code/qr_code.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../text_widget/text_widget.dart';

class QRCodeWidgetContainer extends StatelessWidget {
  const QRCodeWidgetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final publicKey = GetStorage().read('public_key');
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),

        const MyText(
          'RECEIVE',
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            // alignment: Alignment.center,
            width: Get.width,
            height: Get.height / 30,
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(5)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText('Arbitrum',
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center),
                Icon(Icons.keyboard_arrow_down)
              ],
            )).marginOnly(left: 128, right: 128),
        const SizedBox(
          height: 20,
        ),

        QRCodeWidget(qrData: publicKey),
        const SizedBox(
          height: 20,
        ),

        Container(
          height: Get.height / 24,
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(),
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: MyText(
            '${publicKey}',
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          )),
        ).marginOnly(left: 14, right: 14),
        // SizedBox(height:30 ,),
      ],
    );
  }
}
