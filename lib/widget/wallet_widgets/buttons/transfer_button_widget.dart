import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/appcolor_wallet.dart';

class TransferButton extends StatelessWidget {
  TransferButton();

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Get.height / 10,
      width: Get.width,
      color: Colors.red,
      child: Center( // Center the Stack
        child: Stack(
          children: [
            Positioned(
              top: 6,
              left: 4,
              child: Container(
                width: 102,
                height: 39,
                decoration: BoxDecoration(
                  color: const Color(0xff62C8A9),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5, // <-- set border width here
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              top: 1,
              child: Container(
                width: 102,
                height: 39,
                decoration: BoxDecoration(
                  color: AppColor.buttonColor,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5, // <-- set border width here
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'Transfer',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

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
