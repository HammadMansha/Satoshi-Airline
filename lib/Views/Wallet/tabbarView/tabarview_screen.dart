import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/WalletCommon/wallet_tab_view.dart';
import 'package:satoshi/Views/Wallet/creat_and_import/import_wallet/import_wallet_screen.dart';
import 'package:satoshi/Views/Wallet/creat_and_import/new_wallet_create.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../Controllers/wallet/tabarview_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../SpenderView/SpenderCommon/spender_tab_view.dart';

class TababarView extends StatelessWidget {
  const TababarView({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<TabbarViewController>(
      init: TabbarViewController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: AppColor.primary,
            body: _.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            tabBarView(context, _),
                          ],
                        ),
                        Expanded(
                          
                          child: TabBarView(
                            controller: _.tabController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              SpendingTabView(),
                              WalletTabView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
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
          height: 247, // Set the height of the dialog
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ).marginOnly(left: 12, right: 12),
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
                        .marginOnly(top: 20, right: 12),
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
                child: Row(children: [
                  const MyText(
                    'Arbitrum',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ).marginOnly(left: 12, top: 5),
                  Spacer(),
                  Image.asset(
                    AppAssets.blueTick,
                    width: 32,
                  ).marginOnly(right: 12)
                ]),
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
                height: 30,
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

  Widget tabBarView(BuildContext context, TabbarViewController _) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppAssets.backButton,
              width: 42,
              height: 42,
            ).marginOnly(left: 12, right: 17, top: 10)),
        Container(
          height: MediaQuery.of(context).size.height / 17,
          width: Get.width / 1.57,
          child: Stack(
            children: [
              Positioned(
                top: 3,
                left: 3,
                child: Container(
                  width: Get.width / 1.6,
                  height: Get.height / 20,
                  decoration: BoxDecoration(
                      color: const Color(0xff62C8A9),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Container(
                width: Get.width / 1.6,
                height: Get.height / 20,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: TabBar(
                    controller: _.tabController,
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.cntrColor,
                    ),
                    onTap: (index) {
                      if (index == 1) {
                        if (_.storage.hasData('public_key')) {
                        } else {
                          _.tabController!.index =
                              _.tabController!.previousIndex;
                          _.update();
                          showSettingBox();
                        }
                      }
                    },
                    tabs: [
                      InkWell(
                        child: const Tab(
                          text: 'Spending',
                        ),
                      ),
                      const Tab(
                        text: 'Wallet',
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ).marginOnly(top: 15),
        InkWell(
          onTap: () {
            // Get.to(()=>SettingScreenMain());
            if (_.storage.hasData('public_key')) {
              _.checkPassword();
            } else {
              showSettingBox();
            }
          },
          child: const Icon(
            Icons.settings,
            size: 38,
          ).marginOnly(top: 10),
        )
      ],
    );
  }
}
