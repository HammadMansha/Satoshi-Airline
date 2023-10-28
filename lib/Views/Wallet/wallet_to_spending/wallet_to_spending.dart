import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:web3dart/web3dart.dart';
import '../../../Controllers/wallet/wallet_to_spending_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/containers/custom_container.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class WalletToSpending extends StatelessWidget {
  const WalletToSpending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<WalletToSpendingController>(
      init: WalletToSpendingController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: AppColor.primary,
            body: _.isLoading
                ? const Loading()
                : SafeArea(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const TopTransfer('TRANSFER'),
                              const SizedBox(height: 15),
                              transferBox(context, _),
                              const SizedBox(height: 52),
                            ],
                          ),
                        ),
                        assetTransfer(context, _),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget transferBox(BuildContext context, WalletToSpendingController _) {
    return Container(
      height: Get.height / 4.3,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 41.26, left: 37),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(AppAssets.walletIcon),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40, left: 11),
                child: MyText('From', fontSize: 9, fontWeight: FontWeight.w400),
              ),
              Obx(() => MyText(
                    _.currentText.value,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ).marginOnly(left: 30, top: 40)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 34,
              margin: const EdgeInsets.symmetric(horizontal: 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    // Replace with your desired icon
                    // child: Icon(Icons.some_icon),
                  ),
                  InkWell(
                    onTap: _.swapText,
                    child: Image.asset(
                      AppAssets.tradeTransfer,
                      height: 34,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 37),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(AppAssets.spendingIcon),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 11),
                  child: MyText('To', fontSize: 9, fontWeight: FontWeight.w400),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: MyText(
                        _.currentText1.value,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ).marginOnly(left: 30),
                    )),
              ],
            ),
          ),
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget assetTransfer(BuildContext context, WalletToSpendingController _) {
    return CustomContainer(
      color: AppColor.cntrColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 75),
            child: MyText(
              'Asset',
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: Color(0xff858585),
            ),
          ),
          const SizedBox(height: 12),
          ShortContainer(
            height: Get.height / 15,
            width: Get.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 6, top: 15),
              child: SizedBox(
                height: 50,
                width: 155,
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(4),
                  dropdownColor: Colors.white,
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  value: _.selected.text != ''
                      ? _.selected.text
                      : _.dropdownList[3]['name'].toString(),
                  isDense: true,
                  isExpanded: true,
                  items: _.dropdownList.map((list) {
                    return DropdownMenuItem<String>(
                      value: list['name'].toString(),
                      child: list['name'] != ''
                          ? Row(
                              children: [
                                Image.asset(
                                  list['logo'],
                                  height: 32,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: MyText(
                                      '${list['name']}',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text('notfound'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _.selected.text = value!;
                    _.update();
                  },
                ),
              ),
            ),
          ).marginOnly(left: 12, right: 12),
          ////////////////////////////////////////////////////////
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: MyText(
              'Amount',
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: Color(0xff858585),
            ),
          ),
          const SizedBox(height: 14),
          ShortContainer(
            height: Get.height / 15,
            width: Get.width,
            color: Colors.white,
            child: TextFormField(
              controller: _.amount,
              // focusNode: _.amountFocusNode,
              decoration: InputDecoration(
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 18, left: 5),
                    child: InkWell(
                      onTap: () {
                        // Check the currentText and selected values to determine the action
                        if (_.currentText.value == 'Spending') {
                          if (_.selected.text == 'SAP') {
                            // Call getTokenBalancespending() when currentText is 'Spending' and selected is 'SAP'
                            _.getTokenBalancespending();
                          } else if (_.selected.text == 'ARB') {
                            _.sendAllSpendingArbToWallet();

                          }
                        } else if (_.currentText.value == 'Wallet') {
                          if (_.selected.text == 'SAP') {
                            // Call getTokenBalance() when currentText is 'Wallet' and selected is 'SAP'
                            _.getTokenBalance();
                          } else if (_.selected.text == 'ARB') {
                            // Check if shouldPopulateAmount is true, then call setAllAmountForSend()
                            _.sendAllWalletArbToSpending();
                          }
                        }
                      },
                      child: MyText(
                        'All',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0EA375),
                      ),
                    )),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
              onChanged: (value) {
                // Handle the value change here
              },
            ),
          ).marginOnly(left: 12, right: 12),
          SizedBox(height: Get.height / 12),

          //----------------Confirm transfer function---------------
          InkWell(
            onTap: () async {
              // _.isLoading = true;
              // _.update();

              try {
                double? amount = double.tryParse(_.amount.text);
                if (amount == null) {
                  print('Invalid input: ${_.amount.text}');
                  // Handle the case where the input is not a valid double
                  return;
                }

                BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                print(bigIntValue);
                EtherAmount ethAmount =
                    EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                print("Etherium amount is--$ethAmount");

                if (_.selected.text == 'ARB') {
                  if (_.currentText.value == 'Wallet') {
                    // Perform Wallet to ARB transaction
                    _.sendArbWalletToSpending(ethAmount);
                  } else if (_.currentText.value == 'Spending') {
                    // Perform Spending to Wallet transaction
                    _.sendArbSpendingToWallet(ethAmount);
                  }
                  print('ARBSpecificLogic');
                } else if (_.selected.text == 'SAP') {
                  _.isLoading = true;
                  _.update();
                  if (_.currentText.value == 'Wallet') {
                    // Perform Wallet to SAP transaction
                    _.sendSapTokensWithContract();
                  } else if (_.currentText.value == 'Spending') {
                    // Perform Spending to Wallet transaction
                    _.sapSpendingToWallet();
                    _.update();
                  }
                  print('SAPSpecificLogic');
                } else if (_.selected.text == 'SAT' ||
                    _.selected.text == 'USDT') {
                  if (_.currentText.value == 'Wallet') {
                    // Perform Wallet to SAP transaction
                    ShowToastMessage('Please Select Correct');
                  } else if (_.currentText.value == 'Spending') {
                    // Perform Spending to Wallet transaction
                    ShowToastMessage('Please Select Correct');
                    _.update();
                  }

                  _.isLoading = false;
                  _.update();
                }
              } catch (e) {
                print('An error occurred: $e');
                // Handle any other errors that might occur during the conversion or processing
              }
            },
            child: _.isLoading
                ? Loading()
                : Center(
                    child: Image.asset(
                    AppAssets.walletTospendingButton,
                    width: 250,
                    height: 48,
                  )),
          )
        ],
      ),
    );
  }
}
//
