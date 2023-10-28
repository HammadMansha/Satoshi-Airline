
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CopyAddress extends StatelessWidget {
  const CopyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        height: Get.height / 14,
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
              top: 3,
              left: 50,
              child: Container(
                width: Get.width / 3.2,
                height: Get.height / 20,
                decoration: BoxDecoration(
                    color: const Color(0xff62C8A9),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Positioned(
              left: 47,
              child: Container(
                  width: Get.width / 3.2,
                  height: Get.height / 20,
                  decoration: BoxDecoration(
                      // color: const Color(0xffFFFDFD),
                      //   color: AppColor.buttonColor,
                      color: const Color(0xffFFF7AF),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5, // <-- set border width here
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'Copy address',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          fontFamily: 'Sora'),
                    ),
                  )),
            ),
          ],
        )).marginOnly(left: 80, right: 80);
  }
}

// Container(
// height: MediaQuery.of(context).size.height/21,
// width:  MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// border: Border.all(),
// borderRadius: BorderRadius.circular(5),
// color: const Color(0xFFFFF7AF),
// boxShadow: [
// BoxShadow(
// color: Colors.green.withOpacity(0.5),
// blurStyle: BlurStyle.inner,
//
//
// spreadRadius: 0,
//
// blurRadius: 1,
// offset:
// Offset(3, 5),
// // changes position of shadow
// ),
// ],
// ),
// child:  Center(
// child:MyText('Transfer',
// style: TextStyle(
// color: Colors.black,
// fontSize: 12,
// fontWeight: FontWeight.w600,
// ),
// )),
// ).marginOnly(left: 140,right:140 );
