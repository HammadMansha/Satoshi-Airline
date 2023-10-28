import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Views/Minting/my_nfts.dart';
import 'package:satoshi/Views/my_total_nfts/my_total_nfts.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import '../../Controllers/landing/minitng_controller.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Utils/utils.dart';
import '../Wallet/tabbarView/tabarview_screen.dart';

class Minting extends StatelessWidget {
  const Minting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<MintingController>(
      init: MintingController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                controller: _.scrollController,
                child: Column(
                  children: [
                    Image.asset(AppConstants.mintHeadImg),
                    Image.asset(
                      AppConstants.logo,
                      height: 43,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: mint(_),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        _.scrollController.animateTo(
                          _.scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Image.asset(
                        AppConstants.dropDownVector,
                        height: 21,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset(
                        AppConstants.planeImg,
                        height: 833,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget mint(MintingController _) {
    return Container(
      height: Get.height * 0.54,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: AppColors.black)),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            AppConstants.pricesTxtTitle,
            textAlign: TextAlign.center,
            style: mintHeadTxtStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Price per Plane - 90 ARB Each',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '0/3,333',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ).copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1 // Adjust the width of the text border
                ..color =
                    Colors.black54, // Set the outline (border) color to black
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _.nftIncrement();
                },
                child: Image.asset(
                  AppConstants.addNftBtn,
                  height: 48,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  height: 47,
                  width: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text('${_.counter}', style: counterTxtStyle))),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_.counter != 0) {
                    _.nftDecrement();
                  }
                },
                child: Image.asset(
                  AppConstants.subNftBtn,
                  height: 48,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Total: 90 ARB',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
          ),
          MyText(
            '5 max',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (_.storage.read('public_key') == null) {
                Get.to(() => TababarView());
                // Add your navigation logic here when 'Connect Here' is tapped.
              } else {
                Clipboard.setData(
                        ClipboardData(text: _.storage.read('public_key')))
                    .then((value) => {
                          CommonToast.getToast('Address copy successfully'),
                        });
              }
            },
            child: Center(
              child: Container(
                height: 47,
                width: 266,
                decoration: BoxDecoration(
                  color: const Color(0xffFFBB42),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    _.storage.read('public_key') == null
                        ? 'CONNECT WALLET'
                        : _.addressChange(_.storage.read('public_key')),
                    style: GoogleFonts.sora(
                      textStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).marginOnly(left: 20, right: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () async {
                    if (_.isLoading == false) {
                      await _.mintNFT();
                    }
                  },
                  child: Container(
                    height: 46,
                    width: 118,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF7AF),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: _.isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SpinKitThreeBounce(
                                  color: AppColors.primaryColor1,
                                  size: 10.0,
                                ),
                                Text(
                                  "PROCESSING",
                                  style: GoogleFonts.sora(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : Text(
                              "MINT",
                              style: GoogleFonts.sora(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                  )).marginOnly(left: 0),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => MyTotalNftsScreen());
                },
                child: Container(
                  height: 46,
                  width: 118,
                  decoration: BoxDecoration(
                      color: const Color(0xffFFF7AF),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Text(
                      "MY NFT",
                      style: GoogleFonts.sora(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ).marginOnly(right: 0),
              )
            ],
          ),
        ],
      ),
    );
  }
}
