import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:satoshi/Utils/app_constants.dart';
// import 'package:satoshi/widget/appbar/commonAppbar.dart';
// import 'package:shimmer/shimmer.dart';

class RewardToRedeemEffect extends StatelessWidget {
  const RewardToRedeemEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Color(0xff62c8a9),
      ),
    );
    // Shimmer.fromColors(
    //   baseColor: Colors.grey.shade300,
    //   highlightColor: Colors.grey.shade100,
    //   enabled: true,
    //   child: Column(
    //     children: [
    //       commmonContainer(
    //         height: 50,
    //         width: Get.width,
    //       ).marginOnly(left: 20, right: 20,top: 20),
    //       SizedBox(height: 30,),

    //       commmonContainer(
    //         height: 25,
    //         width: Get.width,
    //       ).marginOnly(left: 99, right: 98),
    //       const SizedBox(
    //         height: 29,
    //       ),
    //       commmonContainer(
    //         height: 80,
    //         width: Get.width,
    //       ).marginOnly(left: 130, right: 130),
    //       SizedBox(height: 20,),
    //       commmonContainer(
    //         height: 35,
    //         width: Get.width,
    //       ).marginOnly(left: 150, right: 150),
    //       SizedBox(height: 16,),

    //       Row(
    //         children: [
    //           CircularContainer(
    //             height: 105,
    //             width: 105
    //           ).marginOnly(left: 20),
    //           CircularContainer(
    //               height: 105,
    //               width: 105
    //           ).marginOnly(left: 20),
    //           CircularContainer(
    //               height: 105,
    //               width: 105
    //           ).marginOnly(left: 20),
    //         ],
    //       ),
    //       SizedBox(height: 20,),
    //       Row(
    //         children: [
    //           commmonContainer(height: 20,
    //           width: 90,
    //           ).marginOnly(left: 30),
    //           commmonContainer(height: 20,
    //             width: 90,
    //           ).marginOnly(left: 30),
    //           commmonContainer(height: 20,
    //             width: 90,
    //           ).marginOnly(left: 30),
    //         ],
    //       ),
    //       commmonContainer(height: 20,
    //         width: 90,
    //       ).marginOnly(left: 165,right: 165,top: 30),

    //       commmonContainer(
    //         height: 70,
    //         width: 60,

    //       ).marginOnly(top: 8),
    //       commmonContainer(
    //         height: 45,
    //         width: 121,

    //       ).marginOnly(top: 33)

    //     ],
    //   ),
    // );
  }

  Widget commmonContainer({double? height, double? width, double? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 10)),
    );
  }

  Widget CircularContainer({double? height, double? width, double? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
