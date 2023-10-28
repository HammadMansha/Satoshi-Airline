import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class AssetsPageEffect extends StatelessWidget {
  const AssetsPageEffect({super.key});

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
    //         height: 10,
    //       ),
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               Container(
    //                 height: Get.height / 5.5,
    //                 width: Get.width / 2.5,
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(10)),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           const Spacer(),
    //           Column(
    //             children: [
    //               Container(
    //                 height: Get.height / 5.5,
    //                 width: Get.width / 2.5,
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(10)),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               Container(
    //                 height: Get.height / 5.5,
    //                 width: Get.width / 2.5,
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(10)),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             width: 20,
    //           ),
    //           const Spacer(),
    //           Column(
    //             children: [
    //               Container(
    //                 height: Get.height / 5.5,
    //                 width: Get.width / 2.5,
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(10)),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Row(
    //                 children: [
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Container(
    //                     height: 30,
    //                     width: Get.width / 6.5,
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ],
    //       )
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
