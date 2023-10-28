import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:web3dart/web3dart.dart';
import '../../../Controllers/wallet/sending_coins/send_arb_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/buttons/confirm_button.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';


class SendARBCoins extends StatelessWidget {
  const SendARBCoins({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SendArbCoinController>(
        init: SendArbCoinController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: AppColor.primary,
              body: _.loading
                  ? Loading()
                  : Form(
                      key: _.formKey,
                      child: Column(children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              const TopTransfer('SEND TO'),
                              sapLogo(),
                              const SizedBox(
                                height: 23,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: const MyText(
                                    'To Address',
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff858585),
                                  ).marginOnly(left: 15)),
                              const SizedBox(
                                height: 15,
                              ),
                              toAddressField(context, _),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: const MyText(
                                    'Amount',
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff858585),
                                  ).marginOnly(left: 15)),
                              const SizedBox(
                                height: 15,
                              ),
                              amountField(context, _),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        lastPart(_)
                      ]),
                    ),
            ),
          );
        });
  }
}

Widget sapLogo() {
  return Center(
    child: SizedBox(
      height: Get.height / 10,
      width: Get.width,
      // color: Colors.red,
      child: Image.asset(AppAssets.arbLogo),
    ),
  ).marginOnly(left: 100, right: 100);
}

Widget toAddressField(BuildContext context, SendArbCoinController controller) {
  return TextFormField(
    controller: controller.toAddress,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColor.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    keyboardType: TextInputType.text,
    validator: (value) {
      if (value != null && value.length != 42) {
        return 'Address must be exactly 42 digits';
      }
      return null; // No error if the input is valid
    },
  ).marginOnly(left: 12, right: 12);
}

Widget amountField(BuildContext, SendArbCoinController _) {
  return TextFormField(
    focusNode: _.amountFocusNode,
    controller: _.amount,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColor.white,
      suffixIcon: Padding(
        padding: EdgeInsets.only(left: 4, top: 20),
        child: InkWell(
          onTap: () {
            _.sendAllWalletArbToSpending();
          },
          child: MyText(
            'All',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Color(0xff0EA375),
          ),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    keyboardType: TextInputType.text,
  ).marginOnly(left: 12, right: 12);
}

Widget lastPart(SendArbCoinController _) {
  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height / 2.05,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: EdgeInsets.only(left: 12),
                child:
                MyText(
                  "ARB:${_.storage.read('bnb_balance')}",
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff858585),
                )
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 90,
                width: Get.width,
                // color: Colors.red,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'The network you have selected is ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Arbirtum .',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF5C5C)),
                      ),
                      TextSpan(
                        text:
                            'Please ensure that the withdrawal adress supports the ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Arbirtum',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF5C5C)),
                      ),
                      TextSpan(
                        text: 'network.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'You will lose your assets',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF5C5C)),
                      ),
                      TextSpan(
                        text:
                            ' if the chosen platform does not support retrievals.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Sora',
                        color: Colors.black),
                  ),
                )).marginOnly(left: 45, right: 45),
            SizedBox(
              height: Get.height / 4.5,
            ),
            InkWell(
                onTap: () async {
                  if (_.formKey.currentState!.validate()) {
                    double amount = double.parse(_.amount.text);
                    BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                    print(bigIntValue);
                    EtherAmount ethAmount =
                        EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                    print(ethAmount);
                    _.sendTransaction(_.toAddress.text, ethAmount);
                    print("Balance is ${_.sendTransaction}");

                  }
                },
                child: _.loading == true ? Loading() : const ConfirmButton())
          ],
        ),
      ),
    ),
  );
}
