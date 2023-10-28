import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/wallet/lock_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LockScreenController>(
        init: LockScreenController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: const Color(0xff62C8A9),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  walletIcon(context),
                  Image.asset(
                    AppAssets.lockScreenIcon,
                    height: 121,
                    width: 122,
                  ),
                  // const SizedBox(height: 20.0),
                  _.buildPinDisplay(),
                  const SizedBox(height: 20.0),
                  buildKeypad(context, _),
                  forgetPassword()
                ],
              ),
            ),
          );
        });
  }

  Widget walletIcon(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppAssets.lockScreenBackIcon,
              height: 42,
              width: 42,
            ).marginOnly(left: 18, bottom: 35)));
  }

  Widget forgetPassword() {
    return const MyText(
      'Forgot passcode',
      color: Colors.white,
      fontSize: 9,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );
  }

  Widget buildKeypad(BuildContext context, LockScreenController _) {
    return SizedBox(
      // color: Colors.red,
      width: Get.width,
      height: Get.height / 2,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: [
          _buildDigitButton('1', context, _),
          _buildDigitButton('2', context, _),
          _buildDigitButton('3', context, _),
          _buildDigitButton('4', context, _),
          _buildDigitButton('5', context, _),
          _buildDigitButton('6', context, _),
          _buildDigitButton('7', context, _),
          _buildDigitButton('8', context, _),
          _buildDigitButton('9', context, _),
          Container(),
          _buildDigitButton('0', context, _),
          _.buildBackspaceButton(),
        ].map((button) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: InkWell(
              onTap: () {
                _.buildPinDisplay();
              },
              child: button,
            ),
          );
        }).toList(),
      ),
    ).marginOnly(left: 63, right: 62);
  }

  Widget _buildDigitButton(
      String digit, BuildContext context, LockScreenController _) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(side: BorderSide()),

        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // Set the text color to black
      ),
      onPressed: () {
        _.onDigitPress(
          digit,
          context,
        );
      },
      child: Text(digit),
    );
  }
}
