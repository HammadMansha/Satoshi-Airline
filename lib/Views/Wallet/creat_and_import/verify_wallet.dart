import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';

import '../../../Controllers/wallet/verify_wallet_controller.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class ExportScreen extends StatelessWidget {
  final List<String> mnemonic;

  ExportScreen({Key? key, required this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    List<String> mnemonicWords = mnemonic.join(' ').split(' ');
    mnemonicWords.shuffle();
    return GetBuilder<VerifyWalletController>(
      init: VerifyWalletController(mnemonic),
      builder: (_) {
        return SafeArea(
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: AppColor.primary,
              body: _.isLoading
                  ? Loading()
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const TopTransfer('EXPORT'),
                                const SizedBox(height: 20),
                                upperText(context, _),
                                const SizedBox(height: 20),
                                showPhare(context, _),
                                // const SizedBox(height: 10),
                                buttons(mnemonicWords, _),
                              ],
                            ),
                          ),
                        ),
                        lastPart(context, _),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget upperText(BuildContext context, VerifyWalletController _) {
    return MyText(
      'Please choose Seed Phrase in order and make sure your Seed Phrase was correctly written. Once forgotten, it cannot be recovered.',
      fontWeight: FontWeight.w600,
      fontSize: 12,
      textAlign: TextAlign.center,
      color: Colors.red,
    ).marginOnly(left: 39, right: 38);
  }

  Widget showPhare(BuildContext context, VerifyWalletController _) {
    return ShortContainer(
      height: Get.height / 6,
      width: Get.width,
      color: Colors.white,
      child: MyText(
        _.listValue(),
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Colors.black,
      ).marginOnly(top: 30),
    ).marginOnly(left: 12, right: 12);
  }

  Widget buttons(List<String> button, VerifyWalletController _) {
    // List<String> shuffledMnemonics = List.from(mnemonic);

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: button.map((title) {
        bool isPressed = _.isData(title);
        return ElevatedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: isPressed ? Colors.white : Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                isPressed ? Colors.grey : Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(
                isPressed ? Colors.white : Colors.black),
          ),
          child: Text(title),
          onPressed: () {
            _.handleButtonPressed(title);
          },
        );
      }).toList(),
    ).marginOnly(top: 20, left: 12, right: 12);
  }

  Widget lastPart(BuildContext context, VerifyWalletController _) {
    return Container(
      height: Get.height / 3.5,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColor.cntrColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          border: Border.all()),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: MyText('Email verification code',
                      color: Color(0xff858585), fontSize: 9)
                  .marginOnly(top: 31, left: 12)),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _.formKey,
            child: TextFormField(
              controller: _.emailCode,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              onChanged: (value) {
                _.formKey.currentState!.validate();
                _.update();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter code';
                } else if (value.length != 6) {
                  return 'Code must be exactly 6 characters long';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,

                enabledBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),

                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),

                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),

                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),

                  //<-- SEE HERE
                  borderSide: BorderSide(width: 1, color: Colors.redAccent),
                ),

                //border: InputBorder.none,
                suffixIcon: TextButton(
                  onPressed: _.isClock == false
                      ? () async {
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
              ),
            ),
          ).marginOnly(left: 12, right: 12),
          SizedBox(
            height: 35,
          ),
          InkWell(
              onTap: () {
                _.verifyMnemonic();
              },
              child: Center(
                child: Image.asset(
                  AppAssets.confirmButton,
                  width: 135,
                  height: 46,
                ),
              )),
        ],
      ),
    );
  }
}
