import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Utils/utils.dart';
import 'package:satoshi/Views/my_total_nfts/total_nftscreen_controller.dart';
import 'package:satoshi/widget/common_textfield.dart';
import '../../Utils/commonSnackbar.dart';
import '../../shimmer/assetpage_effect.dart';
import '../../widget/cached_networkImage.dart';
import '../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../Wallet/creat_and_import/import_wallet/import_wallet_screen.dart';
import '../Wallet/tabbarView/tabarview_screen.dart';

class MyTotalNftsScreen extends StatelessWidget {
  const MyTotalNftsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<MyNftsScreenController>(
      init: MyNftsScreenController(),
      builder: (_) {
        return SafeArea(
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              body: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppConstants.nftBg), fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.black, width: 1)),
                        // padding: EdgeInsets.only(top: 100),
                      ),
                    ),
                    Expanded(
                        child: _.landingPageController.minitingGlobleController
                                .isLoading
                            ? const AssetsPageEffect()
                            : bodyData(_)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bodyData(MyNftsScreenController _) {
    return planeWidget(_);
  }

  Widget planeWidget(MyNftsScreenController _) {
    return Obx(
      () => _.landingPageController.minitingGlobleController.isLoading
          ? const AssetsPageEffect()
          : _.landingPageController.minitingGlobleController.assetsData.isEmpty
              ? ListView(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppConstants.cancelBtn,
                          height: 48,
                          width: 48,
                        ).marginSymmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                    Center(
                      child: Text(
                        "MY NFT",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    noDataFoundImage(_),
                  ],
                )
              : ListView(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppConstants.cancelBtn,
                          height: 48,
                          width: 48,
                        ).marginSymmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                    Center(
                      child: Text(
                        "MY NFT",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: _.landingPageController
                                  .minitingGlobleController.assetsData.length ==
                              1
                          ? WrapAlignment.start
                          : WrapAlignment.start,
                      children: [
                        for (int i = 0;
                            i <
                                _.landingPageController.minitingGlobleController
                                    .assetsData.length;
                            i++)
                          _.landingPageController.minitingGlobleController
                                      .assetsData[i]['id']
                                      .toString() !=
                                  _.storage.read('tokenId').toString()
                              ? Container(
                                  height: Get.height / 3.6,
                                  width: Get.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: Get.height / 6.5,
                                        width: Get.width / 2.3,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width / 2.5,
                                                height: 24,
                                                color: const Color(0xffddfff4),
                                                child: Center(
                                                  child: Text(
                                                    "Jest Set",
                                                    style: GoogleFonts.sora(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: const Color(
                                                            0xff000000)),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child:
                                                    CircularCachedNetworkImage(
                                                  width: Get.width / 2.5,
                                                  imageURL: _
                                                                  .landingPageController
                                                                  .minitingGlobleController
                                                                  .assetsData[i]
                                                              ['token_uri'] ==
                                                          null
                                                      ? ''
                                                      : _
                                                          .landingPageController
                                                          .minitingGlobleController
                                                          .assetsData[i]['token_uri'],
                                                  radius: 0.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Center(
                                              child: Text(
                                                "#${BigInt.parse(_.landingPageController.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.sora(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ).marginOnly(
                                                left: 15,
                                                right: 15,
                                                top: 7,
                                                bottom: 7),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Center(
                                              child: Text(
                                                "Lv ${_.landingPageController.minitingGlobleController.assetsData[i]['cardLevel']}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.sora(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ).marginOnly(
                                                left: 15,
                                                right: 15,
                                                top: 7,
                                                bottom: 7),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _.nftId = BigInt.parse(_
                                                  .landingPageController
                                                  .minitingGlobleController
                                                  .assetsData[i]['id']
                                                  .toString())
                                              .toString();
                                          tansferMIntDialog(_);
                                        },
                                        child: Image.asset(
                                          AppAssets.nftTransfer,
                                          width: 131,
                                          height: 36,
                                        ),
                                      ),
                                    ],
                                  ).marginAll(10),
                                ).marginOnly(left: 20, top: 20)
                              : Card(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  child: ClipPath(
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      height: Get.height / 4.4,
                                      width: Get.width / 2.3,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: Get.height / 6.5,
                                            width: Get.width / 2.5,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width / 2.5,
                                                    height: 24,
                                                    color:
                                                        const Color(0xffddfff4),
                                                    child: Center(
                                                      child: Text(
                                                        "COMMON",
                                                        style: GoogleFonts.sora(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: const Color(
                                                                0xff000000)),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        CircularCachedNetworkImage(
                                                      width: Get.width / 2.5,
                                                      imageURL: _
                                                                      .landingPageController
                                                                      .minitingGlobleController
                                                                      .assetsData[i]
                                                                  [
                                                                  'token_uri'] ==
                                                              null
                                                          ? ''
                                                          : _
                                                                  .landingPageController
                                                                  .minitingGlobleController
                                                                  .assetsData[i]
                                                              ['token_uri'],
                                                      radius: 0.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  // height: Get.height / 30,
                                                  // width: Get.width / 5.7,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "#${BigInt.parse(_.landingPageController.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.sora(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                  ).marginOnly(
                                                      left: 15,
                                                      right: 15,
                                                      top: 7,
                                                      bottom: 7),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  // height: Get.height / 30,
                                                  // width: Get.width / 5.7,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Lv ${_.landingPageController.minitingGlobleController.assetsData[i]['cardLevel']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.sora(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                  ).marginOnly(
                                                      left: 15,
                                                      right: 15,
                                                      top: 7,
                                                      bottom: 7),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ).marginAll(10),
                                    ),
                                  ),
                                ),
                      ],
                    )
                  ],
                  // child:
                ),
    );
  }

  Widget noDataFoundImage(MyNftsScreenController _) {
    return Container(
      height: Get.size.height * 0.73,
      width: Get.size.width * 0.94,
      // padding: EdgeInsets.only(top:150),
      decoration: BoxDecoration(
          // border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          AppConstants.noItems,
          height: 150,
        ),
      ),
    );
  }

  void tansferMIntDialog(MyNftsScreenController _) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Container(
            width: Get.width, // Set the width of the dialog
            height: Get.height / 1.4, // Set the height of the dialog
            decoration: BoxDecoration(
              color: const Color(0xffDDFFF4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      AppConstants.cancelBtn,
                      height: 48,
                      width: 48,
                    ).marginOnly(right: 12, top: 12),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: MyText(
                  'NFT TRANSFER',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                )),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  AppAssets.commonCard,
                  width: Get.width / 2.3,
                  height: Get.height / 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child:
                        MyText('T0:', fontSize: 16, fontWeight: FontWeight.w500)
                            .marginOnly(left: 40, bottom: 5)),
                mintTransferAddress(_),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    // _.transferMint();
                    await _.transferNFT(
                        _.privateKey,
                        _.contractAddress,
                        _.publicKey,
                        _.transferController.text,
                        int.parse(_.nftId));
                  },
                  child: Container(
                    height: 40,
                    width: Get.width / 1.6,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFBB42),
                      borderRadius: BorderRadius.circular(10),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).marginOnly(
                      left: 30,
                      right: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mintTransferAddress(MyNftsScreenController _) {
    return Form(
      key: _.formKey2,
      child: CommonTextField(
        controller: _.transferController,
        radius: 10,
        // hintText: "Email Address",
        bordercolor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        fillcolor: Colors.white,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
          _.update();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Address ';
          }
          return null;
        },
      ).marginOnly(left: 30, right: 30),
    );
  }
}
