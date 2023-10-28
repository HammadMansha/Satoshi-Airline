import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../text_widget/text_widget.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: Get.height / 11,
      width: Get.width ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[

          Stack(
          children: [
            Positioned(
              top: 4,
              left: 5,
              child: Container(
                width: 137,
                height: 48,
                decoration: BoxDecoration(
                    color: const Color(0xff000000),
                    border: Border.all(
                      color: Colors.black,
                      width: 1, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            Positioned(
              // top: 50,
              // left: 110,
              child: Container(
                  width: 137,
                  height: 48,
                  decoration: BoxDecoration(
                      // color: const Color(0xffFFFDFD),
                      color: Color(0xffFFBB42),
                      border: Border.all(
                        color: Colors.black,
                        width: 1, // <-- set border width here
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: MyText(
                    'CONFIRM',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
          ],
        ),
    ]
      ),
    );
  }
}


