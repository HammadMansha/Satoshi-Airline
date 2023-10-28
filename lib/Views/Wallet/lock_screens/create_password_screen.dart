import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/lock/createlock_controller.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';

import '../../../Utils/app_asset_wallet.dart';

class CreateLOckScreen extends StatelessWidget {
  const CreateLOckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateLockScreenController>(
      init: CreateLockScreenController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xff62C8A9),
          body: Center(
            child: _.isLoading
                ? Loading()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      walletIcon(_),
                      Image.asset(
                        _.isCreatingPassword
                            ? AppAssets.createPasswordIcon
                            : AppAssets.confirmPasswordIcon,
                        height: 121,
                        width: 121,
                      ),
                      SizedBox(height: 20.0),
                      buildPinDisplay(_),
                      SizedBox(height: 20.0),
                      buildKeypad(_),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget walletIcon(CreateLockScreenController controller) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () {
          controller.enteredPin =
              ''; // Clear entered PIN if the back button is pressed
          Get.back();
        },
        child: Image.asset(
          AppAssets.lockScreenBackIcon,
          height: 42,
          width: 42,
        ).marginOnly(left: 18, bottom: 35),
      ),
    );
  }

  Widget buildPinDisplay(CreateLockScreenController controller) {
    const int pinLength = 6;
    const double boxSize = 17.0;

    return SizedBox(
      height: Get.height / 11,
      width: Get.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: pinLength,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pinLength,
        itemBuilder: (context, index) {
          return Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                (index < controller.enteredPin.length) ? '*' : '',
                style: const TextStyle(fontSize: 10.0),
              ),
            ),
          );
        },
      ),
    ).marginOnly(left: 100, right: 100);
  }

  Widget buildKeypad(CreateLockScreenController controller) {
    return SizedBox(
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
          _buildDigitButton('1', controller),
          _buildDigitButton('2', controller),
          _buildDigitButton('3', controller),
          _buildDigitButton('4', controller),
          _buildDigitButton('5', controller),
          _buildDigitButton('6', controller),
          _buildDigitButton('7', controller),
          _buildDigitButton('8', controller),
          _buildDigitButton('9', controller),
          Container(),
          _buildDigitButton('0', controller),
          _buildBackspaceButton(controller),
        ].map((button) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: InkWell(
              onTap: () async {
                if (controller.enteredPin.length < 6) {
                  controller.onDigitPress(button.key.toString());
                }
              },
              child: button,
            ),
          );
        }).toList(),
      ),
    ).marginOnly(left: 63, right: 62);
  }

  Widget _buildDigitButton(
      String digit, CreateLockScreenController controller) {
    return ElevatedButton(
      key: ValueKey(digit),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(side: BorderSide()),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        if (controller.enteredPin.length < 6) {
          controller.onDigitPress(digit);
        }
      },
      child: Text(digit),
    );
  }

  Widget _buildBackspaceButton(CreateLockScreenController controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(side: BorderSide.none),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff62C8A9),
      ),
      onPressed: () {
        controller.onBackspacePress();
      },
      child: const Icon(Icons.backspace),
    );
  }
}
