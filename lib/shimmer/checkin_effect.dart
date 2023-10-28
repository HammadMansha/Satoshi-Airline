import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class CheckinEffect extends StatelessWidget {
  const CheckinEffect({super.key});

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
    //       Container(
    //         height: 50,
    //         width: Get.width,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Container(
    //         height: Get.height / 2.5,
    //         width: Get.width,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               commmonContainer(height: 8, width: 15),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               commmonContainer(height: 10, width: 20),
    //             ],
    //           ),
    //           const Spacer(),
    //           commmonContainer(height: 15, width: Get.width / 2.5),
    //           const Spacer(),
    //           Column(
    //             children: [
    //               commmonContainer(height: 8, width: 15),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               commmonContainer(height: 10, width: 20),
    //             ],
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           Flexible(
    //             child: commmonContainer(height: 40),
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           Flexible(
    //             child: commmonContainer(height: 40),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             height: 43,
    //             width: 43,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               shape: BoxShape.circle,
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           commmonContainer(height: 20, width: 60)
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       commmonContainer(
    //         height: 50,
    //         width: 125,
    //       ),
    //     ],
    //   ).marginOnly(left: 15, right: 15),
    // );
  }

  Widget commmonContainer({double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      color: Colors.white,
    );
  }
}
