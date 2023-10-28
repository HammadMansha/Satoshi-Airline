import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/appcolor_wallet.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    required this.color,
    this.height,
    this.width,
  });

  final Widget? child;
  final double? height;
  final double? width;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height / 1.9,
          height: height ?? Get.height / 1.85,
          width: width ?? Get.width,
          // padding: EdgeInsets.all(12),
          // height: Get.height,
          decoration: BoxDecoration(
            border: Border.all(),
            color: color ?? AppColor.cntrColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
