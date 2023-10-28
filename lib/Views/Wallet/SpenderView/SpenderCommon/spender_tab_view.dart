import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/wallet/spending_tab_controller.dart';
import 'package:satoshi/Views/Wallet/wallet_to_spending/wallet_to_spending.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/containers/short_containor.dart';
import '../../../../Utils/app_asset_wallet.dart';
import '../../../../Utils/appcolor_wallet.dart';
import '../../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../creat_and_import/import_wallet/import_wallet_screen.dart';
import '../../creat_and_import/new_wallet_create.dart';

class SpendingTabView extends StatelessWidget {
  const SpendingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SpendingTabController>(
      init: SpendingTabController(),
      autoRemove: false,
      builder: (_) {
        return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: const Color(0xFFFFFAEC),
              body: _.isLoading
                  ? Loading()
                  : Column(children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          _.isLoading = true;
                          _.update();
                          if (GetStorage().hasData('private_key')) {
                            await _.checkBalance();
                            await _.updateTokenBalance();
                            _.update();
                          }
                          _.isLoading = false;
                          _.update();
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(children: [
                            textPart(_),
                            const SizedBox(
                              height: 20,
                            ),
                            coinPart(_),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                      ),
                      tabBarView(context, _),
                    ]),
            ));
      },
    );
  }

  Widget textPart(SpendingTabController _) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 115),
            child: MyText(
              'SPENDING ACCOUNT',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColor.textColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 85),
            child: SizedBox(
              height: 17,
              width: 17,
              child: Image.asset(AppAssets.question),
            ),
          )
        ],
      ),
    );
  }

  ////////////////////////////Coin Part//////////////////////
  Widget coinPart(SpendingTabController _) {
    return Container(
      height: Get.height / 4.5,
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
    ).marginOnly(left: 10, right: 10);
  }

  Widget tabBarView(BuildContext context, SpendingTabController _) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: AppColor.cntrColor,
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
                  child: TabBarView(
                children: <Widget>[
                  ///////////  Tab 1//////////
                  pendingTabBar(context, _),
                  ///////////TAB 2 //////////////
                  historyTab(context, _)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingTabBar(BuildContext context, SpendingTabController _) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            AppAssets.tranSection,
            height: 130,
            width: 130,
          ).marginOnly(top: 100),
          InkWell(
              onTap: () async {
                final publicKey = GetStorage().read('public_key');
                if (publicKey != null) {
                  // Navigate to settings screen
                  Get.to(() => WalletToSpending());
                } else {
                  // Navigate to create and import account tab bar
                  showSettingBox();
                }
              },
              child: Image.asset(
                AppAssets.transferButton,
                width: 105,
                height: 42,
              ).marginOnly(top: 80))
        ],
      ),
    );
  }

  Widget historyTab(BuildContext context, SpendingTabController _) {
    return Column(
      children: [
        if (_.transactionList.isEmpty)
          Center(
            child: Image.asset(
              AppAssets.tranSection,
              height: 130,
              width: 130,
            ),
          ).marginOnly(top: 100)
        else
          Expanded(
              child: ListView.separated(
                itemCount: _.transactionList.length,
                shrinkWrap: true,
                separatorBuilder: (c, i) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (c, i) {
                  final reversedList = _.transactionList.reversed.toList();
                  final amount = reversedList[i]['amount'];

                  final isNegative = amount.startsWith('-'); // Check if the amount is negative

                  final assetImage = isNegative
                      ? AppAssets.historyCoinLogo // Use this image for negative amounts
                      : AppAssets.reciveCoinHistory;
                  final address = isNegative ?
                      _.storage.read('public_key') :

                      _.landingPageController.addressData['publicAddress'];

                  return ShortContainer(
                    height: Get.height / 10,
                    width: Get.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              assetImage, // Use the determined assetImage
                              width: 25,
                            ).marginOnly(left: 20, top: 20),
                            MyText(
                              'Confirmed',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0EA375),
                            ).marginOnly(left: 10),
                            Spacer(),
                            Text(
                              amount,
                              style: TextStyle(
                                color: isNegative ? Colors.orange : Colors.green,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ).marginOnly(right: 15),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${_.formatDate(
                                reversedList[i]['date_time'],
                              )}',
                            ).marginOnly(left: 60),
                            Spacer(),

                         
                            Text(  _.shortenAddress(
                             address,
                              20,
                            ),).marginOnly(right: 17)
                          ],
                        )
                      ],
                    ),
                  ).marginOnly(left: 12, right: 12);
                },
              ),
          ),

            const SizedBox(
          height: 20,
        ),
        // InkWell(
        //   onTap: () async {
        //     final publicKey = GetStorage().read('public_key');
        //     if (publicKey != null) {
        //       // Navigate to settings screen
        //       Get.to(() => WalletToSpending());
        //     } else {
        //       // Navigate to create and import account tab bar
        //       Get.to(() => CreateAndImport());
        //     }
        //   },
        //   child: TransferButton().marginOnly(left: 139, top: 40),
        // )
      ],
    );
  }

  void showSettingBox() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width, // Set the width of the dialog
          height: 290, // Set the height of the dialog
          decoration: BoxDecoration(
            color: const Color(0xffDDFFF4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Spacer(),
                  MyText(
                    'ARBITRUM WALLET',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ).marginOnly(top: 30),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      child: Image.asset(AppAssets.crossIcon, width: 42),
                    ).marginOnly(top: 30, right: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 47,
              ),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      shownewWalletDialog();
                    },
                    child: MyText(
                      'Create a new wallet',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).marginOnly(left: 20, right: 21),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height / 15,
                width: Get.width,
                // color: Colors.red,

                child: Stack(
                  children: [
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const ImportWalletScreen());
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height / 19,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFBB42),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: MyText(
                              'Import a wallet using Seed Phrase',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ).marginOnly(left: 20, right: 21),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void shownewWalletDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        backgroundColor: const Color(0xffDDFFF4),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width, // Set the width of the dialog
          height: 290, // Set the height of the dialog
          decoration: BoxDecoration(
            color: const Color(0xffDDFFF4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  MyText('CREATE WALLET',
                          fontSize: 13, fontWeight: FontWeight.w700)
                      .marginOnly(top: 20),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(child: Image.asset(AppAssets.crossIcon))
                        .marginOnly(top: 30, right: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const MyText(
                  'Arbitrum',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ).marginOnly(left: 12, top: 12),
              ).marginOnly(left: 15, right: 15),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const MyText(
                  'All Chains',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ).marginOnly(left: 12, top: 12),
              ).marginOnly(left: 15, right: 15),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: InkWell(
                      onTap: () {
                        Get.to(() => NewWallet());
                      },
                      child: Image.asset(
                        AppAssets.confirmButton,
                        width: 137,
                        height: 48,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
