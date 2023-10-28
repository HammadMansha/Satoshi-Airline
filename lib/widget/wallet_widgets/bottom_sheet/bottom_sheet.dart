import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../buttons/copy_address_button.dart';
import '../common_toast_message.dart';
import '../qr_code/qr_widget_container.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final String defaultAddress = GetStorage().read('public_key');
    void copyAddressToClipboard() {
      Clipboard.setData(ClipboardData(text: defaultAddress));
      ShowToastMessage('Address Copied');
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
          height: Get.height / 1.8,
          decoration: const BoxDecoration(
            color: AppColor.cntrColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            // border: Border.all()
          ),
          child: Column(
            children: [
              const QRCodeWidgetContainer(),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () => copyAddressToClipboard() ,

                  child: const CopyAddress())
            ],
          ),
        ).marginOnly(top: 5),
      ]
      ),
    );
  }
}
