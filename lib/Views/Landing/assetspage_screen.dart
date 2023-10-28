import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/shimmer/assetpage_effect.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import '../../Controllers/landing/assetspage_controller.dart';
import '../../Utils/utils.dart';
import '../../widget/appbar/commonAppbar.dart';
import '../../widget/cached_networkImage.dart';
import '../../widget/loading/loading_screen.dart';
import '../Holders/HolderCommon/tab_view.dart';

class AssetsPageScreen extends StatelessWidget {
  const AssetsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<AssetsPageController>(
      autoRemove: false,
      init: AssetsPageController(),
      builder: (_) {
        return SafeArea(
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: _.landingPageController.internetConnection
                    ? CommonAppbar(
                        isNetwork: false.obs,
                        imagePath: AppConstants.profileImg,
                        totalsap: '0',
                        bnb: 0.00,
                        travel: '0',
                      )
                    : CommonAppbar(
                        isNetwork:
                            _.landingPageController.assetImage.value.isEmpty
                                ? false.obs
                                : true.obs,
                        imagePath:
                            _.landingPageController.assetImage.value.isEmpty
                                ? AppConstants.profileImg
                                : _.landingPageController.assetImage.value.obs,
                        totalsap: _.landingPageController.tokenBalance == null
                            ? '0.00'
                            : _.landingPageController.tokenBalance
                                .toStringAsFixed(2),
                        bnb: _.landingPageController.balanceInBNB == null
                            ? 0.0
                            : double.parse(_.landingPageController.balanceInBNB
                                .toString()),
                        travel: _.landingPageController
                                    .balanceData['distance'] ==
                                null
                            ? '0'
                            : _.landingPageController.balanceData['distance']
                                .toString(),
                      ),
              ),
              body: _.landingPageController.isLoading
                  ? Loading()
                  : DefaultTabController(
                      length: _.myTabs.length,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.black, width: 1)),
                              // padding: EdgeInsets.only(top: 100),
                              child: TabBar(
                                onTap: (value) {
                                  if (value == 1 || value == 2 || value == 3) {
                                    _.indexing = value;
                                    _.update();
                                  } else {
                                    _.indexing = value;
                                    _.update();
                                  }
                                },
                                labelColor: AppColors.white,
                                unselectedLabelColor: AppColors.black,
                                indicator: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  color: const Color(0xff62C8A9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // controller: _.tabController,
                                tabs: _.myTabs,
                              ),
                            ),
                          ),
                          Expanded(
                            child: _.landingPageController
                                    .minitingGlobleController.isLoading
                                ? const AssetsPageEffect()
                                : bodyPages(_, _.indexing)[_.indexing],
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

  List<Widget> bodyPages(AssetsPageController _, int i) {
    return [
      planeWidget(_),
      noDataFoundImage(_),
      noDataFoundImage(_),
      noDataFoundImage(_),
    ];
  }

  Widget planeWidget(AssetsPageController _) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: _.pullRefresh,
        child: _.landingPageController.minitingGlobleController.isLoading
            ? const AssetsPageEffect()
            : _.landingPageController.minitingGlobleController.assetsData
                    .isEmpty
                ? Row(
                    children: [
                      noDataFreeJet(),
                      noDataJetSet(),
                    ],
                  )
                : ListView(
                    children: [
                      Wrap(
                        alignment: _
                                    .landingPageController
                                    .minitingGlobleController
                                    .assetsData
                                    .length ==
                                1
                            ? WrapAlignment.center
                            : WrapAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all()),
                            height: Get.height / 6.5,
                            width: Get.width / 2.7,
                            child: Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      color: Colors.black, // Border color
                                    )),
                                  ),
                                  child: Center(
                                    child: MyText(
                                      'Free Rider',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 75,
                                  width: Get.width,
                                  color: Color(0xffDDFFF4),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.plus,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                      color: Colors.black, // Border color
                                    )),
                                  ),
                                  child: Center(
                                    child: MyText(
                                      'Free Rider',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).marginOnly(top: 10),
                          for (int i = 0;
                              i <
                                  _
                                      .landingPageController
                                      .minitingGlobleController
                                      .assetsData
                                      .length;
                              i++)
                            _.landingPageController.minitingGlobleController
                                        .assetsData[i]['id']
                                        .toString() !=
                                    _.storage.read('tokenId').toString()
                                ? GestureDetector(
                                    onTap: () {
                                      _.storage.write(
                                        "session_token_id",
                                        _
                                            .landingPageController
                                            .minitingGlobleController
                                            .assetsData[i]['id']
                                            .toString(),
                                      );
                                      Get.toNamed(Routes.levelRoutes,
                                          arguments: {
                                            "id": _
                                                .landingPageController
                                                .minitingGlobleController
                                                .assetsData[i]['id'],
                                            "path": _
                                                .landingPageController
                                                .minitingGlobleController
                                                .assetsData[i]['token_uri']
                                          });
                                    },
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
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (_
                                              .landingPageController
                                              .minitingGlobleController
                                              .assetsData[i]['token_uri'] ==
                                          null) {
                                        CommonToast.getToast(
                                            "Please refresh again");
                                      } else {
                                        if (_.storage
                                            .hasData('checkout_complete')) {
                                          Get.toNamed(
                                              Routes.rewardToRedeemRoutes,
                                              arguments: {
                                                "from": _.storage.read(
                                                    'session_fromCountry'),
                                                "to": _.storage
                                                    .read('session_toCountry'),
                                                "distance":
                                                    _.storage.read('distance'),
                                                "tokenId":
                                                    _.storage.read('tokenId'),
                                                "time": _.storage.read('time'),
                                              });
                                        } else {
                                          Get.toNamed(Routes.flytoearnRoutes);
                                          // Get.to(() => FlyToEarn());
                                        }
                                      }
                                    },
                                    child: Card(
                                      elevation: 0.0,
                                      color: Colors.transparent,
                                      child: ClipPath(
                                        clipBehavior: Clip.antiAlias,
                                        child: Banner(
                                          message: _.storage
                                                  .hasData('checkout_complete')
                                              ? 'Redeem'
                                              : 'Boarding',
                                          color: Color(0xffF1DB7D),
                                          textStyle: GoogleFonts.sora(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 8,
                                            color: Colors.black,
                                          ),
                                          location: BannerLocation.topStart,
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
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              Get.width / 2.5,
                                                          height: 24,
                                                          color: const Color(
                                                              0xffddfff4),
                                                          child: Center(
                                                            child: Text(
                                                              "COMMON",
                                                              style: GoogleFonts.sora(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: const Color(
                                                                      0xff000000)),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              CircularCachedNetworkImage(
                                                            width:
                                                                Get.width / 2.5,
                                                            imageURL: _.landingPageController.minitingGlobleController
                                                                            .assetsData[i]
                                                                        [
                                                                        'token_uri'] ==
                                                                    null
                                                                ? ''
                                                                : _
                                                                        .landingPageController
                                                                        .minitingGlobleController
                                                                        .assetsData[i]
                                                                    [
                                                                    'token_uri'],
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
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                        child: Center(
                                                          child: Text(
                                                            "#${BigInt.parse(_.landingPageController.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .sora(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.black,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Lv ${_.landingPageController.minitingGlobleController.assetsData[i]['cardLevel']}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .sora(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                    ),
                                  ),
                        ],
                      ),
                      // Wrap(
                      //   alignment: _
                      //               .landingPageController
                      //               .minitingGlobleController
                      //               .assetsData
                      //               .length ==
                      //           1
                      //       ? WrapAlignment.start
                      //       : WrapAlignment.start,
                      //   children: [
                      //     for (int i = 0;
                      //         i < _.landingPageController
                      //                 .minitingGlobleController
                      //                 .assetsData
                      //                 .length;
                      //         i++)
                      //       _.landingPageController.minitingGlobleController
                      //                   .assetsData[i]['id']
                      //                   .toString() !=
                      //               _.storage.read('tokenId').toString()
                      //           ? GestureDetector(
                      //               onTap: () {
                      //                 _.storage.write(
                      //                   "session_token_id",
                      //                   _
                      //                       .landingPageController
                      //                       .minitingGlobleController
                      //                       .assetsData[i]['id']
                      //                       .toString(),
                      //                 );
                      //                 Get.toNamed(Routes.levelRoutesfree,
                      //                     arguments: {
                      //                       "id": _
                      //                           .landingPageController
                      //                           .minitingGlobleController
                      //                           .assetsData[i]['id'],
                      //                       "path": _
                      //                           .landingPageController
                      //                           .minitingGlobleController
                      //                           .assetsData[i]['token_uri']
                      //                     });
                      //               },
                      //               child: SizedBox(
                      //                 height: Get.height / 4.4,
                      //                 width: Get.width / 2.3,
                      //                 child: Column(
                      //                   children: [
                      //                     Container(
                      //                       height: Get.height / 6.5,
                      //                       width: Get.width / 2.5,
                      //                       decoration: BoxDecoration(
                      //                           color: Colors.white,
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                           border: Border.all(
                      //                               color: Colors.black)),
                      //                       child: ClipRRect(
                      //                         borderRadius:
                      //                             BorderRadius.circular(10),
                      //                         child: Column(
                      //                           children: [
                      //                             Container(
                      //                               width: Get.width / 2.5,
                      //                               height: 24,
                      //                               color:
                      //                                   const Color(0xffddfff4),
                      //                               child: Center(
                      //                                 child: Text(
                      //                                   "Free Rider",
                      //                                   style: GoogleFonts.sora(
                      //                                       fontSize: 10,
                      //                                       fontWeight:
                      //                                           FontWeight.w800,
                      //                                       color: const Color(
                      //                                           0xff000000)),
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             Expanded(
                      //                               child:
                      //                                   CircularCachedNetworkImage(
                      //                                 width: Get.width / 2.5,
                      //                                 imageURL: _
                      //                                                 .landingPageController
                      //                                                 .minitingGlobleController
                      //                                                 .assetsData[i]
                      //                                             [
                      //                                             'token_uri'] ==
                      //                                         null
                      //                                     ? ''
                      //                                     : _
                      //                                             .landingPageController
                      //                                             .minitingGlobleController
                      //                                             .assetsData[i]
                      //                                         ['token_uri'],
                      //                                 radius: 0.0,
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const Spacer(),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Flexible(
                      //                           child: Container(
                      //                             decoration: BoxDecoration(
                      //                                 border: Border.all(
                      //                                   color: Colors.black,
                      //                                 ),
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10)),
                      //                             child: Center(
                      //                               child: Text(
                      //                                 '#0.1',
                      //                                 // "#${BigInt.parse(_.landingPageController.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                      //                                 overflow:
                      //                                     TextOverflow.ellipsis,
                      //                                 style: GoogleFonts.sora(
                      //                                   color: Colors.black,
                      //                                   fontWeight:
                      //                                       FontWeight.w600,
                      //                                   fontSize: 9,
                      //                                 ),
                      //                               ),
                      //                             ).marginOnly(
                      //                                 left: 15,
                      //                                 right: 15,
                      //                                 top: 7,
                      //                                 bottom: 7),
                      //                           ),
                      //                         ),
                      //                         const SizedBox(
                      //                           width: 10,
                      //                         ),
                      //                         Flexible(
                      //                           child: Container(
                      //                             decoration: BoxDecoration(
                      //                               border: Border.all(
                      //                                 color: Colors.black,
                      //                               ),
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                 10,
                      //                               ),
                      //                             ),
                      //                             child: Center(
                      //                               child: Text(
                      //                                 "Lv ${_.landingPageController.minitingGlobleController.assetsData[i]['cardLevel']}",
                      //                                 overflow:
                      //                                     TextOverflow.ellipsis,
                      //                                 style: GoogleFonts.sora(
                      //                                   color: Colors.black,
                      //                                   fontWeight:
                      //                                       FontWeight.w600,
                      //                                   fontSize: 9,
                      //                                 ),
                      //                               ),
                      //                             ).marginOnly(
                      //                                 left: 15,
                      //                                 right: 15,
                      //                                 top: 7,
                      //                                 bottom: 7),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ).marginAll(10),
                      //               ),
                      //             )
                      //           : GestureDetector(
                      //               onTap: () {
                      //                 if (_
                      //                         .landingPageController
                      //                         .minitingGlobleController
                      //                         .assetsData[i]['token_uri'] ==
                      //                     null) {
                      //                   CommonToast.getToast(
                      //                       "Please refresh again");
                      //                 } else {
                      //                   if (_.storage
                      //                       .hasData('checkout_complete')) {
                      //                     Get.toNamed(
                      //                         Routes.rewardToRedeemRoutes,
                      //                         arguments: {
                      //                           "from": _.storage.read(
                      //                               'session_fromCountry'),
                      //                           "to": _.storage
                      //                               .read('session_toCountry'),
                      //                           "distance":
                      //                               _.storage.read('distance'),
                      //                           "tokenId":
                      //                               _.storage.read('tokenId'),
                      //                           "time": _.storage.read('time'),
                      //                         });
                      //                   } else {
                      //                     Get.toNamed(Routes.flytoearnRoutes);
                      //                     // Get.to(() => FlyToEarn());
                      //                   }
                      //                 }
                      //               },
                      //               child: Card(
                      //                 elevation: 0.0,
                      //                 color: Colors.transparent,
                      //                 child: ClipPath(
                      //                   clipBehavior: Clip.antiAlias,
                      //                   child: Banner(
                      //                     message: _.storage
                      //                             .hasData('checkout_complete')
                      //                         ? 'Redeem'
                      //                         : 'Boarding',
                      //                     color: Color(0xffF1DB7D),
                      //                     textStyle: GoogleFonts.sora(
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 8,
                      //                       color: Colors.black,
                      //                     ),
                      //                     location: BannerLocation.topStart,
                      //                     child: SizedBox(
                      //                       height: Get.height / 4.4,
                      //                       width: Get.width / 2.3,
                      //                       child: Column(
                      //                         children: [
                      //                           Container(
                      //                             height: Get.height / 6.5,
                      //                             width: Get.width / 2.5,
                      //                             decoration: BoxDecoration(
                      //                                 color: Colors.white,
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10),
                      //                                 border: Border.all(
                      //                                     color: Colors.black)),
                      //                             child: ClipRRect(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       10),
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     width:
                      //                                         Get.width / 2.5,
                      //                                     height: 24,
                      //                                     color: const Color(
                      //                                         0xffddfff4),
                      //                                     child: Center(
                      //                                       child: Text(
                      //                                         "COMMON",
                      //                                         style: GoogleFonts.sora(
                      //                                             fontSize: 10,
                      //                                             fontWeight:
                      //                                                 FontWeight
                      //                                                     .w800,
                      //                                             color: const Color(
                      //                                                 0xff000000)),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                   Expanded(
                      //                                     child:
                      //                                         CircularCachedNetworkImage(
                      //                                       width:
                      //                                           Get.width / 2.5,
                      //                                       imageURL: _.landingPageController.minitingGlobleController
                      //                                                       .assetsData[i]
                      //                                                   [
                      //                                                   'token_uri'] ==
                      //                                               null
                      //                                           ? ''
                      //                                           : _
                      //                                                   .landingPageController
                      //                                                   .minitingGlobleController
                      //                                                   .assetsData[i]
                      //                                               [
                      //                                               'token_uri'],
                      //                                       radius: 0.0,
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           const Spacer(),
                      //                           Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.center,
                      //                             children: [
                      //                               Flexible(
                      //                                 child: Container(
                      //                                   // height: Get.height / 30,
                      //                                   // width: Get.width / 5.7,
                      //                                   decoration:
                      //                                       BoxDecoration(
                      //                                           border:
                      //                                               Border.all(
                      //                                             color: Colors
                      //                                                 .black,
                      //                                           ),
                      //                                           borderRadius:
                      //                                               BorderRadius
                      //                                                   .circular(
                      //                                                       10)),
                      //                                   child: Center(
                      //                                     child: Text(
                      //                                       "#${BigInt.parse(_.landingPageController.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                      //                                       overflow:
                      //                                           TextOverflow
                      //                                               .ellipsis,
                      //                                       style: GoogleFonts
                      //                                           .sora(
                      //                                         color:
                      //                                             Colors.black,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .w600,
                      //                                         fontSize: 9,
                      //                                       ),
                      //                                     ),
                      //                                   ).marginOnly(
                      //                                       left: 15,
                      //                                       right: 15,
                      //                                       top: 7,
                      //                                       bottom: 7),
                      //                                 ),
                      //                               ),
                      //                               const SizedBox(
                      //                                 width: 10,
                      //                               ),
                      //                               Flexible(
                      //                                 child: Container(
                      //                                   // height: Get.height / 30,
                      //                                   // width: Get.width / 5.7,
                      //                                   decoration:
                      //                                       BoxDecoration(
                      //                                     border: Border.all(
                      //                                       color: Colors.black,
                      //                                     ),
                      //                                     borderRadius:
                      //                                         BorderRadius
                      //                                             .circular(
                      //                                       10,
                      //                                     ),
                      //                                   ),
                      //                                   child: Center(
                      //                                     child: Text(
                      //                                       "Lv ${_.landingPageController.minitingGlobleController.assetsData[i]['cardLevel']}",
                      //                                       overflow:
                      //                                           TextOverflow
                      //                                               .ellipsis,
                      //                                       style: GoogleFonts
                      //                                           .sora(
                      //                                         color:
                      //                                             Colors.black,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .w600,
                      //                                         fontSize: 9,
                      //                                       ),
                      //                                     ),
                      //                                   ).marginOnly(
                      //                                       left: 15,
                      //                                       right: 15,
                      //                                       top: 7,
                      //                                       bottom: 7),
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       ).marginAll(10),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //   ],
                      // ),
                    ],
                    // child:
                  ),
      ),
    );
  }

  Widget button({String? title}) {
    return Container(
      height: 23,
      // width: 62,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 8,
            fontFamily: 'Sora',
          ),
        ),
      ).marginOnly(left: 15, right: 15, top: 7, bottom: 7),
    );
  }

  // Widget noDataFound(AssetsPageController _) {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: Row(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               border: Border.all()),
  //           height: 130,
  //           width: 130,
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: 20,
  //                 width: Get.width,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                       bottom: BorderSide(
  //                     color: Colors.black, // Border color
  //                   )),
  //                 ),
  //                 child: Center(
  //                   child: MyText(
  //                     'Free Rider',
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 height: 85,
  //                 width: Get.width,
  //                 color: Color(0xffDDFFF4),
  //                 child: Center(
  //                   child: Icon(CupertinoIcons.plus),
  //                 ),
  //               ),
  //               Container(
  //                 height: 20,
  //                 width: Get.width,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                       top: BorderSide(
  //                     color: Colors.black, // Border color
  //                   )),
  //                 ),
  //                 child: Center(
  //                   child: MyText(
  //                     'Free Rider',
  //                     fontWeight: FontWeight.w300,
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           width: 33,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             Get.to(TabView());
  //           },
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 border: Border.all()),
  //             height: 130,
  //             width: 130,
  //             child: Column(
  //               children: [
  //                 Container(
  //                   height: 20,
  //                   width: Get.width,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                         bottom: BorderSide(
  //                       color: Colors.black, // Border color
  //                     )),
  //                   ),
  //                   child: Center(
  //                     child: MyText(
  //                       'Jest Set',
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 11,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 85,
  //                   width: Get.width,
  //                   color: Color(0xffDDFFF4),
  //                   child: Center(
  //                     child: Icon(CupertinoIcons.plus),
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 20,
  //                   width: Get.width,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                         top: BorderSide(
  //                       color: Colors.black, // Border color
  //                     )),
  //                   ),
  //                   child: Center(
  //                     child: MyText(
  //                       'NFT Holder',
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 11,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ).marginOnly(left: 45, top: 15),
  //   );
  // }

  Widget noDataFreeJet() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all()),
        height: 130,
        width: 130,
        child: Column(
          children: [
            Container(
              height: 20,
              width: Get.width,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.black, // Border color
                )),
              ),
              child: Center(
                child: MyText(
                  'Free Rider',
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              height: 85,
              width: Get.width,
              color: Color(0xffDDFFF4),
              child: Center(
                child: Icon(CupertinoIcons.plus),
              ),
            ),
            Container(
              height: 20,
              width: Get.width,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: Colors.black, // Border color
                )),
              ),
              child: Center(
                child: MyText(
                  'Free Rider',
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    ).marginOnly(left: 30, top: 22);
  }

  Widget noDataJetSet() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all()),
        height: 130,
        width: 130,
        child: Column(
          children: [
            Container(
              height: 20,
              width: Get.width,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.black, // Border color
                )),
              ),
              child: Center(
                child: MyText(
                  'JET SET',
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              height: 85,
              width: Get.width,
              color: Color(0xffDDFFF4),
              child: InkWell(
                onTap: () {
                  Get.to(TabView());
                },
                child: Center(
                  child: Icon(CupertinoIcons.plus),
                ),
              ),
            ),
            Container(
              height: 20,
              width: Get.width,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: Colors.black, // Border color
                )),
              ),
              child: Center(
                child: MyText(
                  'NFT HOLDER',
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    ).marginOnly(left: 30, top: 22);
  }

  Widget noDataFoundImage(AssetsPageController _) {
    return Container(
      height: Get.size.height * 0.73,
      width: Get.size.width * 0.94,
      // padding: EdgeInsets.only(top:150),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
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
}
