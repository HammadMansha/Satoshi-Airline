import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Views/free_jeets/reward_to_redeem/reward_to_redeem_ferry.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../../Utils/commonSnackbar.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/bottom_navbar.dart';
import 'arrival_ferry_jet_controller.dart';

class ArrivalFerryJet extends StatelessWidget {
  const ArrivalFerryJet({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ArrivalFerryJetController>(
      init: ArrivalFerryJetController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                  child: CommonAppbar(
                isNetwork: _.landingPageController.assetImage.value.isEmpty
                    ? false.obs
                    : true.obs,
                imagePath: _.landingPageController.assetImage.value.isEmpty
                    ? AppConstants.profileImg
                    : _.landingPageController.assetImage.value.obs,
                totalsap: _.landingPageController.tokenBalance == null
                    ? '0.00'
                    : _.landingPageController.tokenBalance.toStringAsFixed(2),
                bnb: _.landingPageController.balanceInBNB == null
                    ? 0.0
                    : double.parse(
                        _.landingPageController.balanceInBNB.toString()),
                travel: _.landingPageController.balanceData['distance'] == null
                    ? '0'
                    : _.landingPageController.balanceData['distance']
                        .toString(),
              )),
            ),
            bottomNavigationBar: const BottomNavbarWidget(),
            body: _.isLoading
                ? const Loading()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 43,
                        ),
                        Image.asset(
                          AppConstants.arrivaldes,
                          height: 42,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppConstants.arrival,
                          style: invitedFriendStyle,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        _.isLoadLoaction
                            ? Text(
                                'Location verification is in progress',
                                style: tipStyle,
                              )
                            : Text(
                                'Your arrival point has been confirmed',
                                style: tipStyle,
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: Get.width,
                            height: Get.height / 2.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Visibility(
                                  visible: _.showMap == true,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          27.671332124757402, 85.3125417636781),
                                      zoom: 15,
                                    ),
                                    myLocationButtonEnabled: true,
                                    myLocationEnabled: true,
                                    zoomControlsEnabled: true,
                                    markers: Set<Marker>.of(_.markers.values),
                                    polylines:
                                        Set<Polyline>.of(_.polylines.values),
                                    // markers: Set<Marker>.of(_marker),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _.googleMapController
                                          .complete(controller);
                                    },
                                  ),
                                )
                                // GoogleMap(
                                //     myLocationButtonEnabled: true,
                                //     myLocationEnabled: true,
                                //     zoomControlsEnabled: true,
                                //     initialCameraPosition: CameraPosition(
                                //       zoom: 16,
                                //       target: _.currentLatLng,
                                //     ),
                                //     markers: Set<Marker>.of(_.markers.values),
                                //     polylines:
                                //         Set<Polyline>.of(_.polylines.values),
                                //     onMapCreated: (controller) {
                                //       print("Map is Created ");
                                //       _.googleMapController = controller;
                                //       _.update();
                                //     },
                                //     gestureRecognizers: Set()
                                //       ..add(Factory<PanGestureRecognizer>(
                                //           () => PanGestureRecognizer()))),
                                )
                            // Image.asset(
                            //   AppConstants.mapImg,
                            //   height: 181,
                            // ),
                            ).marginOnly(left: 20, right: 20),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              'Arrival point is automatically proved when you are within the airport radius 5 km',
                              textAlign: TextAlign.center,
                              style: tipStyle,
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_.distance(
                                    _.livelat,
                                    _.livelong,
                                    _.storge.read('session_tolat'),
                                    _.storge.read('session_tolng')) <=
                                20000000000) {
                              _.flyToEarnController.isStopped = true;
                              _.flyToEarnController.update();
                              _.showMap = false;
                              _.update();
                              _.isStopped = true;
                              _.update();
                              // _.playSoundEffect();
                              Get.to((RewardToRedeemFerry()), arguments: {
                                "from": _.storge.read('session_fromCountry'),
                                "to": _.storge.read('session_toCountry'),
                                "distance": _.storge.read('distance'),
                                "tokenId": _.storge.read('tokenId'),
                                "time": _.storge.read('time'),
                              });
                              // Get.to(() => const RewardToRedeem(),
                              //     arguments: {
                              //       "from": _.storge
                              //           .read('session_fromCountry'),
                              //       "to":
                              //           _.storge.read('session_toCountry'),
                              //       "distance": _.storge.read('distance'),
                              //       "tokenId": _.storge.read('tokenId'),
                              //       "time": _.storge.read('time'),
                              //     });
                            } else {
                              CommonToast.getToast(
                                "Location does not matched",
                              );
                            }
                          },
                          child: Center(
                            child: Image.asset(
                              AppAssets.nextButton,
                              width: 105,
                              height: 42,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  // dialogshow(ArrivalFerryJetController _, String title) {
  //   Get.dialog(
  //     AlertDialog(
  //         elevation: 0.0,
  //         scrollable: true,
  //         contentPadding: const EdgeInsets.all(0.0),
  //         backgroundColor: Colors.transparent,
  //         content: StatefulBuilder(
  //           builder: (context, setState) {
  //             return Container(
  //               width: Get.width,
  //               decoration: BoxDecoration(
  //                 color: const Color(0xffDDFFF4),
  //                 borderRadius: BorderRadius.circular(5),
  //                 border: Border.all(color: Colors.black),
  //               ),
  //               child: Column(
  //                 children: [
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       const Spacer(),
  //                       Text(
  //                         "Alert",
  //                         style: GoogleFonts.sora(
  //                           fontWeight: FontWeight.w700,
  //                           fontSize: 13,
  //                         ),
  //                       ).marginOnly(left: 20),
  //                       const Spacer(),
  //                       GestureDetector(
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                         child: Container(
  //                           width: 30,
  //                           height: 30,
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             color: const Color(0xff62C8A9),
  //                             border: Border.all(color: Colors.black),
  //                             boxShadow: const [
  //                               BoxShadow(
  //                                 color: Color.fromRGBO(27, 60, 71, 0.25),
  //                                 blurRadius: 4,
  //                                 spreadRadius: 2,
  //                                 offset: Offset(0, 3), // Shadow position
  //                               ),
  //                             ],
  //                           ),
  //                           child: const Icon(
  //                             Icons.close,
  //                             color: Colors.white,
  //                             size: 18,
  //                           ),
  //                         ).marginOnly(right: 10, top: 10),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                   Text(
  //                     title == 'cancel'
  //                         ? "Are you want to cancel?"
  //                         : 'Are you want to redeem later?',
  //                     style: GoogleFonts.sora(
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 13,
  //                     ),
  //                   ).marginOnly(left: 15, right: 15),
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       btn(
  //                         color: Colors.white,
  //                         title: "Cancel",
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                       ),
  //                       const SizedBox(
  //                         width: 20,
  //                       ),
  //                       btn(
  //                         color: const Color(0xffffbb42),
  //                         title: "CONFIRM",
  //                         onTap: () async {
  //                           // Get.back();
  //
  //                           if (title == 'cancel') {
  //                             Get.back();
  //
  //                             _.flyToEarnController.isStopped = true;
  //                             _.flyToEarnController.update();
  //                             _.isLoading = true;
  //                             _.update();
  //                             _.landingPageController.minitingGlobleController
  //                                 .assetsData
  //                                 .clear();
  //                             _.landingPageController.minitingGlobleController
  //                                 .update();
  //                             await _.landingPageController
  //                                 .minitingGlobleController
  //                                 .getUserNftData();
  //                             await _.storge.remove('from');
  //                             await _.storge.remove('to');
  //                             await _.storge.remove('distance');
  //                             await _.storge.remove('tokenId');
  //                             await _.storge.remove('time');
  //                             await _.storge.remove('session_from');
  //                             await _.storge.remove('session_to');
  //                             await _.storge.remove('session_totalDistance');
  //                             await _.storge.remove('session_tokenId');
  //                             await _.storge.remove('session_time');
  //                             await _.storge.remove('sapReward');
  //                             await _.storge.remove('fromCountry');
  //                             await _.storge.remove('toCountry');
  //                             await _.storge.remove('session_lat');
  //                             await _.storge.remove('session_lng');
  //                             await _.storge.remove('session_tolat');
  //                             await _.storge.remove('session_tolng');
  //                             await _.storge.remove('checkout_complete');
  //                             await _.storge.remove('session_fromCountry');
  //                             await _.storge.remove('session_toCountry');
  //                             Get.back();
  //                             Get.back();
  //                             Get.back();
  //                             Get.back();
  //                             Get.back();
  //                             Get.back();
  //                             _.showMap = false;
  //                             _.update();
  //                             Get.back();
  //                             _.showMap = false;
  //                             _.update();
  //                             _.isLoading = false;
  //                             _.update();
  //                           } else {
  //                             if (_.isLoading == false) {
  //                               _.flyToEarnController.isStopped = true;
  //                               _.flyToEarnController.update();
  //
  //                               Get.back();
  //                               _.isLoading = true;
  //                               _.update();
  //                               _.landingPageController.minitingGlobleController
  //                                   .assetsData
  //                                   .clear();
  //                               _.landingPageController.minitingGlobleController
  //                                   .update();
  //                               await _.landingPageController
  //                                   .minitingGlobleController
  //                                   .getUserNftData();
  //                               // await _.landingPageController
  //                               //     .minitingGlobleController
  //                               //     .getWalletOfOwner(_.storge.read("wallet"));
  //                               _.isLoading = false;
  //                               _.update();
  //                               if (_.storge.hasData('from')) {
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 _.showMap = false;
  //                                 _.update();
  //                               } else {
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 Get.back();
  //                                 _.showMap = false;
  //                                 _.update();
  //                               }
  //                             }
  //                           }
  //                         },
  //                       )
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 25,
  //                   ),
  //                 ],
  //               ).marginOnly(left: 10, right: 10),
  //             );
  //           },
  //         )),
  //   );
  // }

  Widget btn(
      {Color? color,
      String? title,
      void Function()? onTap,
      double? width,
      double? firstwidth,
      double? secondwidth}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: width ?? Get.width / 3.2,
        child: Stack(
          children: [
            Container(
              height: 50,
              width: firstwidth ?? Get.width / 3.4,
              decoration: BoxDecoration(
                  color: const Color(0xff62C8A9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  'NEXT',
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).marginOnly(top: 5, left: 5),
            Container(
              height: 50,
              width: secondwidth ?? Get.width / 3.4,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  'NEXT',
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
