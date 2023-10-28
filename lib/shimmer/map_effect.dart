import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class MapShimmer extends StatelessWidget {
  const MapShimmer({super.key});

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
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               commmonContainer(height: 20, width: 70),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   commmonContainer(height: 20, width: 100),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const Spacer(),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               commmonContainer(height: 20, width: 50),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               commmonContainer(height: 20, width: 100),
    //             ],
    //           )
    //         ],
    //       ).marginOnly(top: 20, left: 10, right: 10),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Container(
    //         height: Get.height / 3,
    //         width: Get.width,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //       ).marginOnly(left: 20, right: 20),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(height: 20, width: 70),
    //         ],
    //       ).marginOnly(left: 20, right: 20),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(height: 20, width: 70),
    //           const Spacer(),
    //           commmonContainer(height: 20, width: 40),
    //           const Spacer(),
    //           commmonContainer(height: 20, width: 100),
    //         ],
    //       ).marginOnly(left: 20, right: 20),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(height: 20, width: 70),
    //           const Spacer(),
    //           commmonContainer(height: 20, width: 40),
    //           const Spacer(),
    //           commmonContainer(height: 20, width: 100),
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
