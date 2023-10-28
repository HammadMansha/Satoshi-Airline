import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import '../../../Controllers/landing/basic_controller.dart';
import '../../../Utils/commonSnackbar.dart';
import '../../../Utils/utils.dart';
import '../../Wallet/tabbarView/tabarview_screen.dart';


class BasicAccount extends StatelessWidget {
  const BasicAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<BasicController>(
        init: BasicController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              body: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Text('0.0', style: noOfSAPStyle),
                          InkWell(
                            onTap: () {
                              // ferryDialogBox();
                            },

                            child: Text(
                              'SAP',
                              style: sAPStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 3.8,
                                height: Get.height / 6.5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width / 3.8,
                                      height: Get.height / 8,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppConstants.travelKM,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "0,00",
                                          style: GoogleFonts.sora(
                                            textStyle: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ).marginOnly(top: 35),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "TRAVEL KM",
                                      style: GoogleFonts.sora(
                                        textStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: Get.width / 3.8,
                                height: Get.height / 6.5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width / 3.8,
                                      height: Get.height / 8,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppConstants.redeemKM,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "0,00",
                                          style: GoogleFonts.sora(
                                            textStyle: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ).marginOnly(top: 35),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "REDEEM KM",
                                      style: GoogleFonts.sora(
                                        textStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: Get.width / 3.8,
                                height: Get.height / 6.5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width / 3.8,
                                      height: Get.height / 8,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppConstants.burnSAP,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "0,00",
                                          style: GoogleFonts.sora(
                                            textStyle: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ).marginOnly(top: 35),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "SAP BURNED",
                                      style: GoogleFonts.sora(
                                        textStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                      GestureDetector(
                        onTap: () {
                          if (_.publicKey == null) {
                            Get.to(()=>TababarView());
                            // Add your navigation logic here when 'Connect Here' is tapped.
                          } else {
                            Clipboard.setData(ClipboardData(text: _.storage.read('public_key')))
                                .then(
                                    (value) => {
                                  CommonToast.getToast('Address copy successfully'),
                                }
                            );
                          }
                        },
                        child: Container(
                          height: 52,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFBB42),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              _.publicKey == null ? 'CONNECT' : _.addressChange(_.storage.read('public_key')),
                              style: GoogleFonts.sora(
                                textStyle: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ).marginOnly(left: 20, right: 20),
                        ),
                      ),

                      const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if( _.publicKey != null ){
                                Get.toNamed(Routes.mintingRoutes);
                              }
                              else{
                                ShowToastMessage('Connect Wallet Please');
                                print('$ShowToastMessage');
                              }

                              // Get.to(() => const Minting());
                              },
                            child: Container(
                              height: 52,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: const Color(0xffDDFFF4),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "MINT",
                                  style: GoogleFonts.sora(
                                    textStyle: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {

                              // Get.to(()=>FreeJetSetStartScreen());
                            },
                            child: Text(
                              "If you want to get faucet, please click on the wallet",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ).marginOnly(left: 20, right: 20),
                    )
                  ],
                ),
              ).marginOnly(left: 10, right: 10),


            ),
          );
        });
  }
  // void ferryDialogBox() {
  //   Get.dialog(
  //     AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius:
  //         BorderRadius.circular(10), // Adjust the border radius as needed
  //       ),
  //       backgroundColor: Colors.white,
  //       contentPadding: EdgeInsets.zero,
  //       content: Container(
  //         width: Get.width, // Set the width of the dialog
  //         height: 128, // Set the height of the dialog
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Column(
  //           children: [
  //            Row(
  //
  //
  //              children: [
  //
  //                Image.asset(AppAssets.telephoneLogo,height: 19,).marginOnly(left: 55),
  //                MyText('6/25/23',fontWeight: FontWeight.w600,fontSize: 13,),
  //                Spacer(),
  //
  //
  //                Image.asset(AppAssets.daysLogo,height: 19,),
  //                MyText('58 Days',fontWeight: FontWeight.w600,fontSize: 13,).marginOnly(right: 55),
  //
  //              ],
  //            ),
  //             Row(
  //
  //
  //               children: [
  //
  //
  //                 MyText('Checked in Date', fontSize: 13,).marginOnly(left: 55),
  //                 Spacer(),
  //
  //
  //
  //                 MyText('D Day',fontSize: 13,).marginOnly(right: 65),
  //
  //               ],
  //             ),
  //             Row(children: [
  //               Image.asset(AppAssets.heartLogo,width: 38,).marginOnly(left: 55,top: 12),
  //               Column(
  //                 children: [
  //                   Row(
  //                       children:[
  //                         SizedBox(width: 5,),
  //                         MyText('Advance check in', fontSize: 13,),
  //                         SizedBox(width: 5,),
  //                     MyText('10 Sap',fontWeight: FontWeight.w600,fontSize: 13,)
  //
  //     ]),
  //                   SizedBox(width: 5,),
  //                   Row(
  //                       children:[
  //                         SizedBox(width: 10,),
  //                         MyText('Flight Book Reward', fontSize: 13,),
  //                         SizedBox(width: 5,),
  //                         MyText('10 Sap',fontWeight: FontWeight.w600,fontSize: 13,)
  //                       ]),
  //                 ],
  //               )
  //
  //             ])
  //
  //           ],
  //         ).marginOnly(top: 15),
  //       ),
  //     ),
  //   );
  // }
}
