import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Controllers/wallet/wallet_tab_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/bottom_sheet/bottom_sheet.dart';
import '../../../widget/wallet_widgets/bottom_sheet/coins_bottom_sheet.dart';
import '../../../widget/wallet_widgets/buttons/recive_trade_buttons.dart';
import '../../../widget/wallet_widgets/common_toast_message.dart';
import '../../../widget/wallet_widgets/containers/custom_container.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../coins_screens/arbcoin_screen.dart';
import '../coins_screens/sapcoin_screen.dart';
import '../coins_screens/satcoin_Screen.dart';
import '../coins_screens/usdtcoin_transfer.dart';
import '../wallet_to_spending/wallet_to_spending.dart';

class WalletTabView extends StatelessWidget {
  const WalletTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 2.0 ? 2.0 : mqData.textScaleFactor);
    return GetBuilder<WalletController>(
      init: WalletController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: const Color(0xFFFFFAEC),
                body: _.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            _.isLoading = true;
                            _.update();
                            if (_.storage.hasData('public_key')) {
                              await _.checkBalance();
                              await _.updateTokenBalance();
                              _.update();
                            }
                            // await _.checkBalance();
                            _.isLoading = false;
                            _.update();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                arbitrumDropDown(context),
                                const SizedBox(
                                  height: 20,
                                ),
                                arbPoints(_),
                                const SizedBox(
                                  height: 20,
                                ),
                                publicKeyContainer(context, _),
                                const SizedBox(
                                  height: 30,
                                ),
                                tradingButtons(context, _),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        coinsWallet(context, _),
                      ])),
          ),
        );
      },
    );
  }

  Widget arbPoints(WalletController _) {
    String bnbBalance = _.storage.read('bnb_balance');
    String formattedString;

    if (bnbBalance != null) {
      final bnbBalanceDouble = double.tryParse(bnbBalance);

      if (bnbBalanceDouble != null && bnbBalanceDouble >= 0.000001) {
        formattedString = bnbBalanceDouble.toStringAsFixed(6);
      } else {
        formattedString = "0.00";
      }
    } else {
      formattedString = "0.00";
    }

    return Center(
      child: Text(
        "$formattedString ARB",
        style: TextStyle(
          color: AppColor.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget publicKeyContainer(BuildContext context, WalletController _) {
    String publicKey = _.storage.read('public_key');
    String displayedText;

    if (publicKey != null && publicKey.length > 8) {
      final firstPart = publicKey.substring(0, 5);
      final lastPart = publicKey.substring(publicKey.length - 8);
      displayedText = '$firstPart.......$lastPart';
    } else {
      displayedText = 'Public key not found';
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: _.storage.read('public_key')));
          ShowToastMessage('Address Copied');
        },
        child: Container(
          width: Get.width / 2.7,
          height: Get.height / 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.white,
            border: Border.all(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              displayedText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ).marginOnly(left: 10, right: 10),
          ),
        ),
      ),
    );
  }

  Widget tradingButtons(BuildContext context, WalletController _) {
    return Container(
      width: Get.width,
      height: Get.height / 8,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                backgroundColor: AppColor.cntrColor,
                context: context,
                builder: (BuildContext context) {
                  return const CommonBottomSheet();
                },
              );
            },
            child: ButtonContainer(
              child: Image.asset(
                AppAssets.reciveLogo,
              ),
            ).marginOnly(top: 4),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => _.handleButtonClick(),
            child: Obx(
              () => Container(
                // color: Colors.blue,
                height: Get.height / 9.9,
                width: Get.width / 2.5,
                child: _.isButtonClicked.value
                    ? Column(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(40))),
                                      backgroundColor: AppColor.cntrColor,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CoinsBottomSheet();
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 109,
                                    height: 59,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.9),
                                            // Shadow color
                                            offset: Offset(3, 0),
                                            // Offset to the right (horizontal)
                                            blurRadius: 3,
                                            // Blur radius of the shadow
                                            spreadRadius:
                                                0, // Spread radius of the shadow
                                          ),
                                        ],
                                        color: Color(0xff62C8A9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  const WalletToSpending());
                                            },
                                            child: Image.asset(
                                              AppAssets.spendingButton,
                                              width: 61,
                                              height: 80,
                                            )),
                                        Image.asset(
                                          AppAssets.toExternalButton,
                                          width: 18,
                                          height: 18,
                                        ).marginOnly(left: 8),
                                      ],
                                    ),
                                  ).marginOnly(top: 2))
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center the text horizontally
                          children: [
                            MyText('Spending   /',
                                fontWeight: FontWeight.w600, fontSize: 9),
                            const SizedBox(width: 2),
                            // Adjust the spacing between texts
                            MyText(
                                'External',
                                fontWeight: FontWeight.w600,
                                fontSize: 9),
                          ],
                        ).marginOnly(left: 5,top: 5),
                      ])
                    : SizedBox(
                        child: ButtonContainer(
                          child: Image.asset(AppAssets.transfer)
                              .marginOnly(left: 40, right: 40),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              // Get.to(() => const TradeScreenOne());
              ShowToastMessage('Coming Soon');
            },
            child: ButtonContainer(
              child: Image.asset(AppAssets.trade).marginOnly(top: 4),
            ),
          ),
        ],
      ),
    );
  }

  Widget arbitrumDropDown(BuildContext context) {
    return Container(
        // alignment: Alignment.center,
        width: Get.width / 4.4,
        height: Get.height / 30,
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(5)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText('ARB',
                fontSize: 10,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.center),
            Icon(Icons.keyboard_arrow_down)
          ],
        ));
  }

  Widget coinsWallet(BuildContext context, WalletController _) {
    return CustomContainer(
        width: Get.width,
        color: AppColor.cntrColor,
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 15, top: 27),
                    child: Text(
                      'Wallet Account',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 27),
                  child: CircleAvatar(
                    maxRadius: 7,
                    backgroundImage: AssetImage(AppAssets.question),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 178, top: 21),
                  child: Container(
                    height: 27,
                    width: 58,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.white),
                    child: Image.asset(AppAssets.buyLogo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: Get.height / 3.5,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
                color: AppColor.white,
              ),
              child: ListView.separated(

                itemCount: _.coinList.length,
                itemBuilder: (c, i) {
                  return ListTile(
                    onTap: () {
                      if (i == 0) {
                        Get.to(() => const ArbCoinScreen());
                      } else if (i == 1) {
                        Get.to(() => const SapCoinScreen());
                      } else if (i == 2) {
                        Get.to(() => const SatCoinScreen());
                      } else if (i == 3) {
                        Get.to(() => const UsdtCoinScreen());
                      }
                    },
                    leading: Image.asset(
                      _.coinList[i]['image'],
                      width: 33,
                      height: 33,
                    ),
                    title: MyText(_.coinList[i]['name'],
                        fontSize: 20, fontWeight: FontWeight.w600),
                    trailing: MyText(_.coinList[i]['value']),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                    indent: 20.0,
                    endIndent: 20.0,
                    height: 6.0,
                  );
                },
              ),
            ).marginOnly(left: 10, right: 10),
            const SizedBox(
              height: 10,
            ),
            ShortContainer(
              height: Get.height / 12.3,
              width: Get.width,
              color: AppColor.white,
              child: GestureDetector(
                onTap: () {
                  // Get.to( ExportScreen(mnemonic: [],));
                },
                child: ListTile(
                  leading: Image.asset(AppAssets.planeLogo, height: 27),
                  title: const MyText('Plane',
                      fontWeight: FontWeight.w600, fontSize: 13),
                  trailing: const Text('0.00'),
                ),
              ),
            ).marginOnly(left: 13, right: 13)
          ],
        ));
  }
}
