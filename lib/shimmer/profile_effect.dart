import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

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
    //         height: Get.height * 0.35,
    //         width: Get.width,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(30),
    //             bottomRight: Radius.circular(30),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 35,
    //       ),
    //       Column(
    //         children: [
    //           Row(
    //             children: [
    //               commmonContainer(height: 10, width: 30),
    //               const Spacer(),
    //               commmonContainer(height: 10, width: 70),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           Row(
    //             children: [
    //               commmonContainer(height: 10, width: 30),
    //               const Spacer(),
    //               commmonContainer(height: 10, width: 50),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           Row(
    //             children: [
    //               commmonContainer(height: 10, width: 30),
    //               const Spacer(),
    //               commmonContainer(height: 10, width: 30),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           Row(
    //             children: [
    //               commmonContainer(height: 10, width: 50),
    //               const Spacer(),
    //               commmonContainer(height: 10, width: 30),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           Row(
    //             children: [
    //               commmonContainer(height: 10, width: 70),
    //               const Spacer(),
    //               commmonContainer(height: 10, width: 20),
    //             ],
    //           ),
    //         ],
    //       ).marginOnly(left: 20, right: 20),
    //     ],
    //   ),
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
