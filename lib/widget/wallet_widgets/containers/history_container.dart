import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HistoryContainer extends StatelessWidget {
  HistoryContainer(
      {required this.child,  required this.height, required this.width,  required this.color,});

  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: height ?? 39,
        width:   width ?? 252,
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(


            color: color, borderRadius: BorderRadius.all( Radius.circular(5))),

        child: child,
      );

  }
}