import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/send_coins_screens/send_sap.dart';
import 'package:satoshi/Views/Wallet/wallet_to_spending/wallet_to_spending.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../../Controllers/wallet/sending_coins/all_coins_controller/sapcoin_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/bottom_sheet/bottom_sheet.dart';
import '../../../widget/wallet_widgets/buttons/recive_trade_buttons.dart';
import '../../../widget/wallet_widgets/common_toast_message.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widgets_full.dart';

class SapCoinScreen extends StatelessWidget {
  const SapCoinScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SapCoinController>(
        init: SapCoinController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,


            child: Scaffold(
              backgroundColor: AppColor.primary,
              body: _.isLoading ? Loading() :
              Column(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const TopWidget('SAP'),
                      coin(context, _),
                      const SizedBox(
                        height: 20,
                      ),
                      ////////////////////////////////////////////
                      buttonPart(context, _),
                      const SizedBox(
                        height: 15,
                      ),
                      ////////////////////////////////////////////
                    ],
                  ),
                ),
                lastContainer(context,_),
              ]),
            ),
          );
        });
  }

  Widget buttonPart(BuildContext context, SapCoinController _) {
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
              child: Image.asset(AppAssets.reciveLogo,),
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
                             Get.to(()=>SendSapCoins());
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

  ////////////////////////////////////////////////////////////////////////
  Widget coin(BuildContext context, SapCoinController _) {
    final myTextValue = _.storage.read('sapBalance') ?? 0.0; // Ensure myText is parsed as a double
    String formattedString;

    if (myTextValue >= 0.000001) {
      formattedString = myTextValue.toStringAsFixed(6);
    } else {
      formattedString = "0.00";
    }

    return Column(
      children: [
        ButtonContainer(
          containerheight: 68,
          sizedboxwidth: 69,
          child: Image.asset(AppAssets.sapLogo),
        ),
        MyText(
          "$formattedString SAP", // Display formattedString with 6 decimal places or "0.00"
          fontWeight: FontWeight.w600,
          fontSize: 20,
        )
      ],
    );
  }


  Widget lastContainer(BuildContext context, SapCoinController _) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cntrColor,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: DefaultTabController(
          length: 2, // Specify the number of tabs
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.only(
                    left: Get.width / 3.7, right: Get.width / 3.7),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                  // insets: EdgeInsets.only(left: 22, right: 22),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                tabs: const <Widget>[
                  Tab(text: 'Pending'),
                  Tab(text: 'History'),
                ],
              ),
              Expanded(
                  child: TabBarView(children: <Widget>[
                    //Tab 1
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.tranSection,
                            height: 130,
                            width: 130,
                          ).marginOnly(top: 50),
                          Center(
                            child: Image.asset(AppAssets.transferButton,width: 105,height: 42,),
                          ).marginOnly(top: 80),
                        ],
                      ),
                    ),
                    //////TAB 2
                    historyTab(context, _),
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyTab(BuildContext context, SapCoinController _) {
    final reversedTransactionList = List.from(_.transactionList.reversed);
    return Column(
      children: [
        if (reversedTransactionList.isEmpty)
          Center(
            child: Image.asset(
              AppAssets.tranSection,
              height: 130,
              width: 130,
            ),
          ).marginOnly(top: 50)
        else
          Expanded(
            child: ListView.separated(
              itemCount: reversedTransactionList.length,
              shrinkWrap: true,
              separatorBuilder: (c, i) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (c, i) {
                final amount = reversedTransactionList[i]['amount'];
                Color amountColor = amount.startsWith('-') ? Colors.red : Colors.green; // Set color based on amount sign
               final assetImage=  amount.startsWith('-') ? AppAssets.historyCoinLogo : AppAssets.reciveCoinHistory;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  width: Get.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            assetImage  ,
                            width: 25,
                          ).marginOnly(top: 36, left: 21),
                          MyText(
                            'Confirmed',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0EA375),
                          ).marginOnly(left: 10),
                          Text(
                            amount,
                            style: TextStyle(
                              color: amountColor, // Use the determined color here
                            ),
                          ).marginOnly(left: 130),
                        ],
                      ),
                      Row(
                        children: [

                          Text(
                            '${_.formatDate(
                              reversedTransactionList[i]['date_time'],
                            )}',
                          ).marginOnly(left: 55),
                          Spacer(),
                          Text(
                            _.shortenAddress(
                              reversedTransactionList[i]['receiver_address'],
                              20,
                            ),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ).marginOnly(right: 40)


                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ).marginOnly(left: 12, right: 12, bottom: 10, top: 10);
              },
            ),
          ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

}
