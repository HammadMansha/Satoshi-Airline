import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';



class TopWidgetButton extends StatelessWidget{
  TopWidgetButton(



      );

  // final String Text;

  @override
  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.only(left: 12),
      child: Container(
        width: Get.width,
        height: Get.height/9,
        color: Colors.red,
        // color: Colors.red,
        child:  Row(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(onTap: () {
                  Get.back();
                  // Get.off(const WalletScreenOne());
                },
                  child: Container(
                    height: 42,
                    width: 42,
                    child: Image.asset(AppAssets.backButton),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6,left: 5),
                  child: Container(
                      height: MediaQuery.of(context).size.height/17,
                      width: Get.width/1.5,
                      color: Colors.pink,
                      child: Stack(
                        children: [
                          Positioned(
                            // top: 33,
                            left: 3,
                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                width: 252,
                                height: 39,
                                decoration: BoxDecoration(
                                    color: const Color(0xff62C8A9),
                                    border: Border.all(
                                      color: Colors.black,
                                      // width: 1.5, // <-- set border width here
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 30,
                            // right: ,

                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                  width: 252,
                                  height: 39,
                                  decoration: BoxDecoration(
                                    // color: const Color(0xffFFFDFD),
                                      color: AppColor.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        // width: 1.5, // <-- set border width here
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: TabBar(
                                        labelColor: Colors.black,
                                        indicator: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.cntrColor,
                                        ),
                                        tabs: const [
                                          Tab(
                                            text: 'Spending',
                                          ),
                                          Tab(
                                            text: 'Wallet',
                                          )
                                        ],
                                      ))),
                            ),
                          )
                        ],

                      )),
                ),

                Icon(
                  Icons.settings,
                  size: 38,
                )
              ],
            ),


          ],

        ),

      ),
    );

  }




}
