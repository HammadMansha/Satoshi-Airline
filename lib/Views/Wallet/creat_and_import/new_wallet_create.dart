import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/wallet/create_waller_controller.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';

import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import 'verify_wallet.dart';

class NewWallet extends StatelessWidget {
  const NewWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<CreateWalletController>(
      init: CreateWalletController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: AppColor.primary,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      'NEW WALLET',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 30),
                  mnemonicsPart(context, _),
                  SizedBox(height: 80),
                  lastButton(context, _.mnemonic),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget lastButton(BuildContext context, String mnemonic) {
  void navigateToExportScreen() {
    List<String> mnemonicList = mnemonic.split(' ');
    Get.to(() => ExportScreen(mnemonic: mnemonicList));
  }

  return InkWell(
    onTap: navigateToExportScreen,
    child: Center(
      child: Image.asset(AppAssets.newWalletWritten,width: 258,height: 48,),
    ),
  );
}

Widget mnemonicsPart(BuildContext context, CreateWalletController _) {
  return Container(

    width: Get.width,

    decoration: BoxDecoration(
        color: Colors.white,
      border: Border.all()
    ),
    child: Column(
      children: [
        Container(
          // color: Colors.red,
          width: Get.width,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(


              children: [
                _.buildTextSpan(
                  'Do not risk losing your funds. Protect your Wallet by saving your Seed Phrase in a place you trust. ',
                  Colors.black,
                ),
                _.buildTextSpan(
                  'It’s the only way to recover your Wallet if you get locked out of the App or change to a new device.',
                  Colors.red,
                ),
              ],
            )
          ).marginOnly(top: 50,),
        ).marginOnly(left: 30,right: 30),
        SizedBox(height: 25,),
       mnemonics(BuildContext, _),
        SizedBox(height: 20),
      ],
    ),
  ).marginOnly(left: 12, right: 12);
}
Widget mnemonics(BuildContext ,CreateWalletController _){
  return    Container(

    // color: Colors.red,
    // height: Get.height / 2.36,
    // width: Get.width/3.8,

    child: ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _.mnemonic.split(' ').length,
      separatorBuilder: (context, index) => SizedBox(height: 10.0),
      itemBuilder: (context, i) {
        final number = i + 1;
        final words = _.mnemonic.split(' ');
        final word = words[i];
        return Container(

          height: Get.height/40,

          // color: Colors.red,
            child: Row(children:[
              MyText('$number     ',fontSize: 12, fontWeight: FontWeight.w400,),
              // Spacer(),

            MyText('$word',fontSize: 12, fontWeight: FontWeight.w400,)


            ])
        ).marginOnly(left: 150);
      },
    ),
  );
}


