import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text_widget/text_widget.dart';




class TradeButton extends StatelessWidget {
  const TradeButton({super.key}
      );





  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 55,
            left: 134,
            child: Transform(
              transform: Matrix4.identity(),
              child: Container(
                width: 121,
                height: 45.5,
                decoration: BoxDecoration(
                    color: const Color(0xff000000),
                    border: Border.all(
                      color: Colors.black,
                      width: 1, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 130,
            child: Transform(
              transform: Matrix4.identity(),
              child: Container(
                  width: 121,
                  height: 45.5,
                  decoration: BoxDecoration(
                    // color: const Color(0xffFFFDFD),
                      color: Color(0xffFFBB42),
                      border: Border.all(
                        color: Colors.black,
                        width: 1, // <-- set border width here
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: MyText('TRADE',fontSize: 20,fontWeight: FontWeight.w600,)
                  )),
            ),
          ),
        ],
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