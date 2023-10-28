import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/wallet/sending_coins/send_sap_controller.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/buttons/confirm_button.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class SendSapCoins extends StatelessWidget {
  const SendSapCoins({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SendSapCoinController>(
        init: SendSapCoinController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: AppColor.primary,
              body:_.isLoading ? Loading() :
              Column(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const TopTransfer('SEND TO'),

                      Center(
                        child: SizedBox(
                          height: Get.height / 10,
                          width: Get.width,
                          // color: Colors.red,
                          child: Image.asset(AppAssets.sapLogo),
                        ),
                      ).marginOnly(left: 100, right: 100),
                      //////////////////////////////////////////////////////////////////////
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
                      /////////////////////////////////////////////////////////////////////
                      const SizedBox(
                        height: 15,
                      ),
                      toAddress(context, _),

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

                      TextFormField(
                        controller: _.amount,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.white,
                          suffixIcon:  Padding(
                            padding: EdgeInsets.only(left: 4, top: 20),
                            child: InkWell(
                              onTap: () {
                                _.getTokenBalance();
                                // if (_.shouldPopulateAmount) {
                                //   _.setAllAmountForSend();
                                // }
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        keyboardType: TextInputType.text,
                      ).marginOnly(left: 12, right: 12),
                      ////////////////////////////////////////////////////////////////////

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                lastPart(_)
              ]),
            ),
          );
        });
  }
}

Widget toAddress(BuildContext context, SendSapCoinController _) {
  return TextFormField(
    controller: _.toAddress,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColor.white,
      // suffixIcon: IconButton(
      //   icon: const Icon(Icons.qr_code_scanner),
      //   onPressed: _.scanQR,
      // ).marginOnly(left: 12, right: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    keyboardType: TextInputType.text,
  ).marginOnly(left: 12, right: 12);
}

Widget lastPart(SendSapCoinController _) {
  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height / 2.05,

        // height: MediaQuery.of(context).size.height / 1.9,

        // padding: EdgeInsets.all(12),
        decoration: const BoxDecoration(
            // color: Colors.red,

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: EdgeInsets.only(left: 12),
                child: MyText(
                  'SAP  ${GetStorage().read('sapBalance').toString()}',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff858585),
                )),
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
              onTap: () {
                _.sendSapTokensWithContract();
                // _.getTokenBalance(EthereumAddress.fromHex(_.storage.read('public_key')));
              },
              // onTap: () async {
              //   // String privateKeyHex = '0x1f2dfb07b94a944e3eda627e0860dc087e494d1468e2147852c53d64f2e8a99d';
              //   // print('private_key${privateKeyHex}');
              //   var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/";
              //   var httpClient = http.Client();
              //   var ethClient = Web3Client(apiUrl, httpClient);
              //
              //   final credentials = EthPrivateKey.fromHex(_.storage.read('private_key'));
              //   print('privaet_key${_.storage.read('private_key')}');
              //
              //   final sapTokenContractAddress = EthereumAddress.fromHex(
              //       '0xE08BaB83Cdfe26d5e5427af8DA2ddB0Ba1a70A61');
              //   final recipientAddress = EthereumAddress.fromHex(_.toAddress.text);
              //   final amountInWei = BigInt.from(1 * 1e8); // Set amount to 0.01 ETH (in Wei)
              //
              //   _.sendSapTokensWithContract(ethClient, credentials,
              //       sapTokenContractAddress, recipientAddress, amountInWei);
              // },
              child:  Center(child: Image.asset(AppAssets.confirmButton,width: 258,height: 43,),),
            )

          ],
        ),
      ),
    ),
  );
}
