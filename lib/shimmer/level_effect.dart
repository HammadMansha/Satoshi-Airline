import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class LevelEffect extends StatelessWidget {
  const LevelEffect({super.key});

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
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               commmonContainer(
    //                 height: 31,
    //                 width: 31,
    //               ),
    //               const SizedBox(
    //                 height: 25,
    //               ),
    //               commmonContainer(
    //                 height: 31,
    //                 width: 31,
    //               ),
    //               const SizedBox(
    //                 height: 25,
    //               ),
    //               commmonContainer(
    //                 height: 31,
    //                 width: 31,
    //               ),
    //               const SizedBox(
    //                 height: 25,
    //               ),
    //               commmonContainer(
    //                 height: 31,
    //                 width: 31,
    //               ),
    //             ],
    //           ),
    //           Spacer(),
    //           Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   commmonContainer(
    //                     height: 31,
    //                     width: 31,
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   commmonContainer(
    //                     height: Get.height / 3.5,
    //                     width: Get.width / 1.9,
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   commmonContainer(
    //                     height: 31,
    //                     width: 31,
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   commmonContainer(
    //                     height: 20,
    //                     width: 40,
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   commmonContainer(
    //                     height: 20,
    //                     width: 40,
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   commmonContainer(
    //                     height: 20,
    //                     width: 40,
    //                   ),
    //                 ],
    //               )
    //             ],
    //           )
    //         ],
    //       ).marginOnly(left: 15, right: 15),
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(
    //             height: 10,
    //             width: 40,
    //           ),
    //           const Spacer(),
    //           commmonContainer(
    //             height: 15,
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(
    //             height: 15,
    //             width: 40,
    //           ),
    //           const Spacer(),
    //           commmonContainer(
    //             height: 30,
    //             width: Get.width / 1.6,
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(
    //             height: 15,
    //             width: 40,
    //           ),
    //           const Spacer(),
    //           commmonContainer(
    //             height: 30,
    //             width: Get.width / 1.6,
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(
    //             height: 15,
    //             width: 40,
    //           ),
    //           const Spacer(),
    //           commmonContainer(
    //             height: 30,
    //             width: Get.width / 1.6,
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           commmonContainer(
    //             height: 15,
    //             width: 40,
    //           ),
    //           const Spacer(),
    //           commmonContainer(
    //             height: 30,
    //             width: Get.width / 1.6,
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 15,
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
