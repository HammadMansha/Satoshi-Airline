

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../text_widget/text_widget.dart';

class ConfirmTransfer extends StatelessWidget {
  const ConfirmTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: Get.height / 10,
      width: Get.width,
      child: Stack(
        children: [
          Positioned(
            top: 4,
            left: 60,
            child: Container(
              width: 258,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xff000000),
                border: Border.all(
                  color: Colors.black,
                  width: 1, // <-- set border width here
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: 56,
            child: Container(
              width: 258,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xffFFBB42),
                border: Border.all(
                  color: Colors.black,
                  width: 1, // <-- set border width here
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child:  Center(
                child: MyText(
                  'CONFIRM TRANSFER',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
