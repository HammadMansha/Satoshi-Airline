// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:satoshi/Utils/commonSnackbar.dart';
// import 'package:satoshi/widget/loading/loading_screen.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import '../../../../Controllers/landing/startminting_controller.dart';
// import '../../../../Utils/app_colors.dart';
// import '../../../../Utils/app_constants.dart';
// import '../../../../Utils/app_text_styles.dart';
// import '../../../../widget/appbar/commonAppbar.dart';
// import '../../../../widget/bottom_navbar.dart';
// import '../../../../widget/common_button.dart';
// import '../../../qr/qr_screen.dart';
// import '../../HolderCommon/basictab_screen.dart';
// import '../destination.dart';

// class StartMintingScreen extends StatelessWidget {
//   const StartMintingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final mqData = MediaQuery.of(context);
//     final mqDataNew = mqData.copyWith(
//         textScaleFactor:
//             mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
//     return GetBuilder<StartMintingController>(
//       init: StartMintingController(),
//       builder: (_) {
//         return WillPopScope(
//           onWillPop: () async {
//             await _.storage.remove("session_token_id");
//             return true;
//           },
//           child: SafeArea(
//             child: MediaQuery(
//               data: mqDataNew,
//               child: Scaffold(
//                 appBar: PreferredSize(
//                   preferredSize: const Size.fromHeight(90),
//                   child: SafeArea(
//                     child: CommonAppbar(
//                       isNetwork:
//                           _.landingPageController.assetImage.value.isEmpty
//                               ? false.obs
//                               : true.obs,
//                       imagePath:
//                           _.landingPageController.assetImage.value.isEmpty
//                               ? AppConstants.profileImg
//                               : _.landingPageController.assetImage.value.obs,
//                       totalsap:
//                           _.landingPageController.balanceData['totalSap'] ==
//                                   null
//                               ? ''
//                               : _.landingPageController.balanceData['totalSap']
//                                   .toString(),
//                       bnb: _.landingPageController.balanceData['bnbBalance'] ==
//                               null
//                           ? 0.0
//                           : double.parse(_
//                               .landingPageController.balanceData['bnbBalance']
//                               .toString()),
//                       travel: _.landingPageController.balanceData['distance'] ==
//                               null
//                           ? '0'
//                           : _.landingPageController.balanceData['distance']
//                               .toString(),
//                     ),
//                   ),
//                 ),
//                 resizeToAvoidBottomInset: false,
//                 body: _.isLoading ? Loading() : startMinting(_, context),
//                 bottomNavigationBar: const BottomNavbarWidget(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget startMinting(StartMintingController _, BuildContext context) {
//     return DefaultTabController(
//       length: _.myTabs.length,
//       initialIndex: 0,
//       child: Column(
//         children: [
//           tabbarCustom(_, context),
//           Expanded(child: bodyPages(_, context)[_.indexing]),
//         ],
//       ),
//     );
//   }

//   Widget testflight(StartMintingController _, BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: AppColors.black),
//               borderRadius: BorderRadius.circular(
//                 10,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Column(
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // const SizedBox(
//                           //   width: 15,
//                           // ),
//                           Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffffff00),
//                                     border: Border.all(
//                                         color: AppColors.black, width: 1.0),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 height: 31,
//                                 width: 31,
//                                 child: IconButton(
//                                   icon: Image.asset(AppConstants.addIcon),
//                                   onPressed: () {
//                                     _.avalue.value.clear();
//                                     _.update();
//                                     buyAttribute(
//                                       _,
//                                       iconName: AppConstants.fuelIcon,
//                                       maxvalue: _.nftData['attributes']['fuel']
//                                               ['maxValue']
//                                           .toString(),
//                                       attributeName: "FUEL",
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 25,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffFF98BD),
//                                     border: Border.all(
//                                         color: AppColors.black, width: 1.0),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 height: 31,
//                                 width: 31,
//                                 child: IconButton(
//                                   icon: Image.asset(AppConstants.addIcon),
//                                   onPressed: () {
//                                     _.avalue.value.clear();
//                                     _.update();
//                                     buyAttribute(
//                                       _,
//                                       iconName: AppConstants.mineIcon,
//                                       maxvalue: _.nftData['attributes']['mine']
//                                               ['maxValue']
//                                           .toString(),
//                                       attributeName: "MINE",
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 25,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffB1F9E2),
//                                     border: Border.all(
//                                         color: AppColors.black, width: 1.0),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 height: 31,
//                                 width: 31,
//                                 child: IconButton(
//                                   icon: Image.asset(AppConstants.addIcon),
//                                   onPressed: () {
//                                     _.avalue.value.clear();
//                                     _.update();
//                                     buyAttribute(
//                                       _,
//                                       iconName: AppConstants.durabilityIcon,
//                                       maxvalue: _.nftData['attributes']
//                                               ['durability']['maxValue']
//                                           .toString(),
//                                       attributeName: "DURABILITY",
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 25,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffF198FF),
//                                     border: Border.all(
//                                         color: AppColors.black, width: 1.0),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 height: 31,
//                                 width: 31,
//                                 child: IconButton(
//                                   icon: Image.asset(AppConstants.addIcon),
//                                   onPressed: () {
//                                     _.avalue.value.clear();
//                                     _.update();
//                                     buyAttribute(
//                                       _,
//                                       iconName: AppConstants.luckyIcon,
//                                       maxvalue: _.nftData['attributes']['luck']
//                                               ['maxValue']
//                                           .toString(),
//                                       attributeName: "LUCKY",
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.only(left: 10),
//                                     child: const Icon(Icons.arrow_back_ios),
//                                   ),
//                                   SizedBox(
//                                     height: Get.height / 3.5,
//                                     width: Get.width / 1.9,
//                                     child: Stack(
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.topCenter,
//                                           child: Container(
//                                             height: 30,
//                                             width: Get.width / 2.9,
//                                             decoration: BoxDecoration(
//                                               color: const Color(0xffddfff4),
//                                               borderRadius:
//                                                   const BorderRadius.only(
//                                                 topLeft: Radius.circular(10),
//                                                 topRight: Radius.circular(10),
//                                               ),
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 _.nftData['cardType']
//                                                     .toString()
//                                                     .toUpperCase(),
//                                                 style: GoogleFonts.sora(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 13,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Align(
//                                           alignment: Alignment.bottomCenter,
//                                           child: Container(
//                                             height: Get.height / 4,
//                                             width: Get.width / 1.9,
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               image: DecorationImage(
//                                                 image:
//                                                     NetworkImage(_.imagePath),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(left: 10),
//                                     child: const Icon(
//                                       Icons.arrow_forward_ios,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.black,
//                                         ),
//                                         borderRadius: BorderRadius.circular(7)),
//                                     child: Center(
//                                       child: Text(
//                                         "#${_.id.toString()}",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ).marginOnly(left: 15, right: 15),
//                                   ),
//                                   const SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.black,
//                                         ),
//                                         borderRadius: BorderRadius.circular(7)),
//                                     child: const Center(
//                                       child: Text(
//                                         "0/3",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ).marginOnly(left: 15, right: 15),
//                                   ),
//                                   const SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.black,
//                                         ),
//                                         borderRadius: BorderRadius.circular(7)),
//                                     child: Center(
//                                       child: Text(
//                                         "Lv${_.nftData['cardLevel']}",
//                                       ),
//                                     ).marginOnly(left: 15, right: 15),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Text(
//                               AppConstants.attributes,
//                               style: noOfSapStyle,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Row(
//                               children: [
//                                 Container(
//                                     height: 17,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 2,
//                                             color: AppColors.redLight),
//                                         borderRadius: BorderRadius.circular(2)),
//                                     child: Image.asset(
//                                       AppConstants.addIcon,
//                                       color: AppColors.redLight,
//                                       height: 15,
//                                     )
//                                     // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
//                                     )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             AppConstants.fuelIcon,
//                             height: 27,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.only(top: 5, left: 5),
//                               child: Text(
//                                 'FUEL',
//                                 style: attributesTextStyle,
//                               )),
//                           const Spacer(),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.zero,
//                                 margin: EdgeInsets.zero,
//                                 // padding: EdgeInsets.only(top: 5,left: 100),
//                                 child: Text(
//                                   '${double.parse((_.nftData['attributes']['fuel']['value']).toString()).toStringAsFixed(1)}/${double.parse((_.nftData['attributes']['fuel']['maxValue']).toString()).toStringAsFixed(1)}',
//                                   style: attributesValueStyle,
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   child: LinearPercentIndicator(
//                                     lineHeight: 23.0,
//                                     width: Get.width / 1.7,
//                                     // barRadius: const Radius.circular(5.0),
//                                     padding: const EdgeInsets.all(0.0),
//                                     percent: _.nftData['attributes']['fuel']
//                                                 ['value'] <
//                                             0
//                                         ? 0.0
//                                         : double.parse(
//                                             (_.nftData['attributes']['fuel']
//                                                         ['value'] /
//                                                     _.nftData['attributes']
//                                                         ['fuel']['maxValue'])
//                                                 .toString(),
//                                           ),
//                                     center: Text(double.parse(
//                                             (_.nftData['attributes']['fuel']
//                                                     ['value'])
//                                                 .toString())
//                                         .toStringAsFixed(1)),
//                                     animation: true,
//                                     backgroundColor: Colors.transparent,
//                                     progressColor: const Color(0xff62c8a9),
//                                     fillColor: const Color(0xffd3d3d3),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ).marginOnly(right: 20)
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             AppConstants.mineIcon,
//                             height: 17,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.only(top: 5, left: 5),
//                               child: Text(
//                                 'MINE',
//                                 style: attributesTextStyle,
//                               )),
//                           const Spacer(),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '${double.parse((_.nftData['attributes']['mine']['value']).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['mine']['maxValue']).toString()).toStringAsFixed(2)}',
//                                 style: attributesValueStyle,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   child: LinearPercentIndicator(
//                                     lineHeight: 23.0,
//                                     width: Get.width / 1.7,
//                                     // barRadius: const Radius.circular(5.0),
//                                     padding: const EdgeInsets.all(0.0),
//                                     // percent: 0.0,
//                                     percent: _.nftData['attributes']['mine']
//                                                 ['value'] <
//                                             0
//                                         ? 0.0
//                                         : _.nftData['attributes']['mine']
//                                                 ['value'] /
//                                             _.nftData['attributes']['mine']
//                                                 ['maxValue'],
//                                     animation: true,
//                                     center: Text(
//                                       "${double.parse((_.nftData['attributes']['mine']['value']).toString()).toStringAsFixed(2)}%",
//                                     ),
//                                     backgroundColor: Colors.transparent,
//                                     progressColor: const Color(0xff62c8a9),
//                                     fillColor: const Color(0xffd3d3d3),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ).marginOnly(right: 20)
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             AppConstants.durabilityIcon,
//                             height: 19,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.only(top: 5, left: 0),
//                               child: Text(
//                                 'Durability',
//                                 style: attributesTextStyle,
//                               )),
//                           const Spacer(),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '${double.parse((_.nftData['attributes']['durability']['value']).toString()).toStringAsFixed(1)}/${double.parse((_.nftData['attributes']['durability']['maxValue']).toString()).toStringAsFixed(1)}',
//                                 style: attributesValueStyle,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   child: LinearPercentIndicator(
//                                     lineHeight: 23.0,
//                                     width: Get.width / 1.7,
//                                     // barRadius: const Radius.circular(5.0),
//                                     padding: const EdgeInsets.all(0.0),
//                                     // percent: 0.0,
//                                     percent: _.nftData['attributes']
//                                                 ['durability']['value'] <
//                                             0
//                                         ? 0.0
//                                         : _.nftData['attributes']['durability']
//                                                 ['value'] /
//                                             _.nftData['attributes']
//                                                 ['durability']['maxValue'],
//                                     animation: true,
//                                     center: Text(
//                                       double.parse((_.nftData['attributes']
//                                                   ['durability']['value'])
//                                               .toString())
//                                           .toStringAsFixed(1),
//                                     ),
//                                     backgroundColor: Colors.transparent,
//                                     progressColor: const Color(0xff62c8a9),
//                                     fillColor: const Color(0xffd3d3d3),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ).marginOnly(right: 20)
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             AppConstants.luckyIcon,
//                             height: 20,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.only(top: 5, left: 5),
//                               child: Text(
//                                 'Lucky',
//                                 style: attributesTextStyle,
//                               )),
//                           const Spacer(),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '${double.parse((_.nftData['attributes']['luck']['value']).toString()).toStringAsFixed(1)}/${double.parse((_.nftData['attributes']['luck']['maxValue']).toString()).toStringAsFixed(1)}',
//                                 style: attributesValueStyle,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(5)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   child: LinearPercentIndicator(
//                                     lineHeight: 23.0,
//                                     width: Get.width / 1.7,
//                                     padding: const EdgeInsets.all(0.0),
//                                     // percent: 0.0,
//                                     percent: _.nftData['attributes']['luck']
//                                                 ['value'] <
//                                             0
//                                         ? 0.0
//                                         : _.nftData['attributes']['luck']
//                                                 ['value'] /
//                                             _.nftData['attributes']['luck']
//                                                 ['maxValue'],
//                                     center: Text(double.parse(
//                                             (_.nftData['attributes']['luck']
//                                                     ['value'])
//                                                 .toString())
//                                         .toStringAsFixed(1)),
//                                     animation: true,
//                                     backgroundColor: Colors.transparent,
//                                     progressColor: const Color(0xff62c8a9),
//                                     fillColor: const Color(0xffd3d3d3),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ).marginOnly(right: 20)
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       btnStack(AppConstants.start, false, context, _),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         AppConstants.tutTextBtn,
//                         style: attributesValueStyle,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ).marginOnly(left: 20, right: 20),
//                 ],
//               ),
//             ),
//           ).marginOnly(left: 10, right: 10),
//         ),
//       ],
//     );
//   }

//   List<Widget> bodyPages(StartMintingController _, BuildContext context) {
//     return [testflight(_, context), const BasicTabScreen(), QrScreen()];
//   }

//   Widget tabbarCustom(StartMintingController _, BuildContext context) {
//     return Container(
//       height: 50,
//       width: Get.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: AppColors.black,
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               _.indexing = 0;
//               _.update();
//             },
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   bottomLeft: Radius.circular(10)),
//               child: Container(
//                 height: 50,
//                 width: Get.width / 2.8,
//                 decoration: BoxDecoration(
//                     color: _.indexing == 0
//                         ? const Color(0xff62C8A9)
//                         : const Color(0xffCDCDCD),
//                     border: const Border(
//                       right: BorderSide(
//                         color: Colors.black,
//                       ),
//                     )),
//                 child: const Center(
//                   child: Text("Test Flight"),
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               _.indexing = 1;
//               _.update();

//               CommonToast.getToast(
//                 'Coming soon',
//               );
//               if (_.landingPageController.isSound) {
//                 _.landingPageController.playSoundEffect();
//               }
//               // _.indexing = 1;
//               // _.update();
//             },
//             child: Container(
//               height: 50,
//               width: Get.width / 2.8,
//               decoration: BoxDecoration(
//                   color: _.indexing == 1
//                       ? const Color(0xff62C8A9)
//                       : const Color(0xffCDCDCD),
//                   // borderRadius: BorderRadius.circular(5),
//                   border: const Border(
//                     right: BorderSide(
//                       color: Colors.black,
//                     ),
//                   )
//                   // border: Border.all(
//                   //   color: AppColors.black,
//                   //   width: 1,
//                   // ),
//                   ),
//               child: const Center(
//                 child: Text("Basic"),
//               ),
//             ),
//           ),
//           Flexible(
//             child: GestureDetector(
//               onTap: () {
//                 Get.dialog(
//                   Dialog(
//                     insetPadding: const EdgeInsets.all(0),
//                     backgroundColor: Colors.transparent,
//                     child: SizedBox(
//                       height: Get.height / 1.4,
//                       width: Get.width,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CommonButton(
//                               text: "HOW TO PLAY",
//                               onPressed: () async {
//                                 await launchUrlString(
//                                     'https://www.youtube.com/watch?v=V4A4cklChnU&t=34s',
//                                     mode: LaunchMode.externalApplication);
//                               },
//                               color: const Color(0xffFFF7AF)),
//                           CommonButton(
//                                   text: "WHITEPAPER",
//                                   onPressed: () async {
//                                     await launchUrlString(
//                                         'https://satoshiair.gitbook.io/docs/',
//                                         mode: LaunchMode.externalApplication);
//                                   },
//                                   color: const Color(0xffFFFFFF))
//                               .marginSymmetric(vertical: 25),
//                           CommonButton(
//                               text: "LINKTREE",
//                               onPressed: () async {
//                                 await launchUrlString(
//                                     'https://linktr.ee/satoshiairline',
//                                     mode: LaunchMode.externalApplication);
//                               },
//                               color: const Color(0xffFFFFFF)),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           QrScreen(),
//                         ],
//                       ).marginSymmetric(horizontal: 32),
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: 50,
//                 width: Get.width / 4.0,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                     child: Image.asset(
//                   AppConstants.helpIcon,
//                   height: 17,
//                 )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).marginOnly(left: 10, right: 10);
//   }

//   Widget btnStack(
//       btnText, boolean, BuildContext context, StartMintingController _) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => const Destination());
//         // takeBool ? returnDialog(context, _) : Container();
//       },
//       child: Container(
//         height: 50,
//         width: 125,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AppConstants.startBtn),
//             // fit: BoxFit.fill,
//             // alignment: Alignment.topLeft
//           ),
//         ),
//         child: Center(
//           child: Text(
//             btnText,
//             style: congratulateTextStyle,
//           ),
//         ),
//       ),
//     );
//   }

//   buyAttribute(StartMintingController _,
//       {String? iconName, String? maxvalue, String? attributeName}) {
//     Get.defaultDialog(
//       backgroundColor: const Color(0xffddfff4),
//       radius: 10,
//       content: Column(
//         children: [
//           Container(
//             height: 160,
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Attribute",
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       height: 40,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             iconName!,
//                             height: 27,
//                           ),
//                           const SizedBox(
//                             width: 2,
//                           ),
//                           Text("$attributeName"),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           const Icon(Icons.keyboard_arrow_down)
//                         ],
//                       ).marginOnly(top: 5, bottom: 5, left: 10, right: 10),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Max. Value",
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       height: 40,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 2,
//                           ),
//                           Text("$maxvalue"),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           const Icon(Icons.keyboard_arrow_down)
//                         ],
//                       ).marginOnly(top: 5, bottom: 5, left: 10, right: 10),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Upgrade Value",
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                       width: Get.width / 2.8,
//                       height: 40,
//                       child: TextFormField(
//                         keyboardType: TextInputType.emailAddress,
//                         controller: _.avalue.value,
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: AppColors.black,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Colors.black,
//                             ),
//                           ),
//                           hintText: "value",
//                           hintStyle: hintTextStyle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 )
//               ],
//             ).marginOnly(left: 10, right: 10),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             width: Get.width,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 color: Colors.black,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               children: [
//                 const Text(
//                   "COST",
//                   style: TextStyle(
//                     color: Color(0xff858585),
//                     fontSize: 12,
//                   ),
//                 ),
//                 const Spacer(),
//                 Obx(
//                   () => Text(
//                     "${_.avalue.value.text} SAP",
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               ],
//             ).marginOnly(left: 15, right: 15),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               btn(
//                 color: Colors.white,
//                 title: "NEXT TIME",
//                 onTap: () {
//                   Get.back();
//                 },
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               btn(
//                 color: const Color(0xffffbb42),
//                 title: "CONFIRM",
//                 onTap: () async {
//                   if (double.parse(maxvalue!).round() <
//                       int.parse(_.avalue.value.text).toDouble().round()) {
//                     CommonToast.getToast(
//                       'Please enter smaller value',
//                     );
//                     // CommonSnackbar.getSnackbar(
//                     //     "Warning", "Please enter smaller value", Colors.blue);
//                   } else {
//                     Get.back();
//                     await _.updateAttribute(attributeName!);
//                   }
//                 },
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget btn({Color? color, String? title, void Function()? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 50,
//         width: 120,
//         decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.black)),
//         child: Center(
//           child: Text(
//             title!,
//             style: const TextStyle(
//               fontSize: 15,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
