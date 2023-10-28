import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/wallet/importwallet_controller.dart';
import 'package:satoshi/widget/common_textfield.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';

import '../../../../Utils/app_asset_wallet.dart';
import '../../../../Utils/app_constants.dart';
import '../../../../Utils/app_text_styles.dart';
import '../../../../Utils/appcolor_wallet.dart';
import '../../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class ImportWalletScreen extends StatelessWidget {
  const ImportWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return GetBuilder<ImportWalletController>(
      init: ImportWalletController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child:
          Scaffold(
            backgroundColor: AppColor.primary,
            body: _.isLoading ? Center(
                child: Image.asset(AppConstants.loadingGif)
            )
                :
            SingleChildScrollView(
              child: Form(
                key: _.formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const TopTransfer('IMPORT WALLET'),
                    const SizedBox(
                      height: 30,
                    ),
                    text(),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      controller: _.words,
                      bordercolor: Colors.black,
                      radius: 5,
                      fillcolor: AppColor.white,
                      maxlines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the mnemonic words';
                        }
                        return null; // No error if the input is valid
                      },
                    ).marginOnly(left: 12, right: 12),



                    const SizedBox(
                      height: 20,
                    ),
                    verficationText(),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      controller: _.pin,
                      bordercolor: Colors.black,
                      radius: 5,
                      fillcolor: AppColor.white,
                      keyboardType: TextInputType.number,
                      validator: (value) {

                        if (_.pin == null) {
                          return 'Please enter Verification Code';
                        }
                        return null; // No error if the input is valid
                      },
                      suffixicon: TextButton(
                        onPressed: _.isClock == false
                            ? () async {
                                // _.isLoading = true;

                                await _.sendEmailCode();
                              }
                            : () {},
                        child: _.isClock
                            ? Text(
                                '${_.seconds}',
                                style: textButtonStyle,
                              )
                            : Text(
                                AppConstants.sendCode,
                                style: textButtonStyle,
                              ),
                      ),
                    ).marginOnly(left: 12, right: 12),
                    SizedBox(
                      height: Get.height / 3.15,
                    ),
                    lastButton(_)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget text() {
    return const Align(
            alignment: Alignment.topLeft,
            child: MyText('To Address',
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 9))
        .marginOnly(left: 14);
  }

  Widget verficationText() {
    return const Align(
            alignment: Alignment.topLeft,
            child: MyText('Email verification code',
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 9))
        .marginOnly(left: 14);
  }

  Widget lastButton(ImportWalletController _) {
    return GestureDetector(
      onTap: () async {
        if (_.formKey.currentState!.validate()) {
          final isCodeVerified = await _.verifysendEmailCode();

          // _.isLoading = false;
          // _.update(); // Hide the loading indicator

          if (isCodeVerified) {
            _.isLoading = true;
            _.update();
            // Proceed with account recovery
            await _.recover();


            _.controller2.onInit();

            // Navigate back four times
            Get.back();
            Get.back();
            Get.back();
            Get.back();
            _.isLoading = false;
            _.update();
          } else {
            ShowToastMessage('Verification code is incorrect');
          }
        } else {
          ShowToastMessage('Please fill out the form correctly');
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          _.isLoading
              ? Loading() // Loading indicator
              : SizedBox(), // Empty container when not loading
          Center(
            child: Image.asset(
              AppAssets.importWallet,
              width: 258,
              height: 48,
            ),
          ),
        ],
      ),
    );
  }

}
