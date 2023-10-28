import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key, this.heading});

  final String? heading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: Get.width / 1.5,
      child: Stack(
        children: [
          Container(
            height: 44,
            width: Get.width / 1.6,
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ).marginOnly(top: 3, left: 3),
          Container(
            height: 44,
            width: Get.width / 1.6,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                heading!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
