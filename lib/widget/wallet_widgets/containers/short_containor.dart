import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShortContainer extends StatelessWidget {
  ShortContainer(
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
        height:  height,
        width:    width,
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(

          border: Border.all(),

            color: color, borderRadius: BorderRadius.all( Radius.circular(7))),

        child: child,

      );

  }
}