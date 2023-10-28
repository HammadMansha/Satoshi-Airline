import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/utils.dart';

import '../../../../Controllers/spender_balance_controller.dart';

class SpenderBalance extends StatelessWidget {
  const SpenderBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SpenderBalanceController>(
      init: SpenderBalanceController(),
        builder: (_){
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              body: Container(
                // padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  children: [
                    SizedBox(height: height*0.05,),
                    Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 20,
                          ),

                          Container(
                            child: Text(AppConstants.spenderTitle, style: senderTitleStyle,),
                          ),
                          Container(
                            child: Image.asset(AppConstants.walletHelp, height: 17,)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: balanceCard(height, width)),
                    SizedBox(height: height*0.02,),

                    Container(
                      height: height*0.46,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  Widget balanceCard(height, width){
    return Container(
      // width: 260,
      height: height*0.22,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.black,
            width: 1.0, // <-- set border width here
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 29.0, left: 23.0, right: 23.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Image.asset(AppConstants.sapIcon, height: 33,),
                    ),
                    SizedBox(width: width*0.058,),
                    Container(
                        child: Text(AppConstants.sapTxt, style: sAPStyle,)
                    ),
                  ],
                ),
                Container(
                  child: Text('0.00', style: earnedWallet,),
                )
              ],),
          ),
          const Divider(
            color: AppColors.grey86,
            indent: 23,
            endIndent: 23,
            thickness: 1,
          ),

          Container(
            padding: const EdgeInsets.only(left: 23.0, right: 23.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Image.asset(AppConstants.usdIcon, height: 33,),
                    ),
                    SizedBox(width: width*0.058,),
                    Container(
                        child: Text(AppConstants.satTxt, style: sAPStyle,)
                    ),
                  ],
                ),
                Container(
                  child: Text('0.00', style: earnedWallet,),
                )
              ],),
          ),
          const Divider(
            color: AppColors.grey86,
            indent: 23,
            endIndent: 23,
            thickness: 1,
          ),

          Container(
            padding: const EdgeInsets.only(left: 23.0, right: 23.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Image.asset(AppConstants.binanceIcon, height: 33,),
                    ),
                    SizedBox(width: width*0.058,),
                    Container(
                        child: Text(AppConstants.arbTxt, style: sAPStyle,)
                    ),
                  ],
                ),
                Container(
                  child: Text('--    ', style: earnedWallet,),
                )
              ],),
          ),
          const Divider(
            color: AppColors.grey86,
            indent: 23,
            endIndent: 23,
            thickness: 1,
          ),

        ],
      ),
    );
  }
}
