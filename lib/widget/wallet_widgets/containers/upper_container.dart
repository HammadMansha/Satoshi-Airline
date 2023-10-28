import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpperContainer extends StatelessWidget {
  UpperContainer(
      {required this.child,  required this.height, required this.width,  required this.color, this.text,});

  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  final Text? text;


  @override
  Widget build(BuildContext context) {
    return
      Container(
        height:  39,
        width:    252,
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5),
                blurStyle: BlurStyle.inner,


                spreadRadius: 0,

                blurRadius: 1,
                offset:
                Offset(3, 5),
                // changes position of shadow
              ),
            ],


            border: Border.all(),

            color: color, borderRadius: BorderRadius.all( Radius.circular(5))),

        child: child,

      );

  }
}