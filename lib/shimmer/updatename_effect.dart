import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class UpdateProfileShimmer extends StatelessWidget {
  const UpdateProfileShimmer({super.key});

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
    //         height: 50,
    //       ),
    //       commmonContainer(
    //         height: 70,
    //         width: Get.width,
    //       ).marginOnly(left: 20, right: 20),
    //       const SizedBox(
    //         height: 50,
    //       ),
    //       commmonContainer(width: 157, height: 42, radius: 5)
    //           .marginOnly(left: 20, right: 20),
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
}
