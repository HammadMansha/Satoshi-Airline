import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    Key? key,
    this.sizedboxheight,
    this.color,
    this.sizedboxwidth, this.containerwidth, this.containerheight, this.child, this.icon,
  }) : super(key: key);

  final double? sizedboxheight;
  final double? sizedboxwidth;
  final Color? color;
  final double? containerwidth;
  final double? containerheight;
  final Widget ? child;
  final Widget ? icon;
  // final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width:  61,

      decoration: const BoxDecoration(
        // shape: BoxShape.circle,
        // color: Colors.pink

      ),

      child: child,
    );
  }
}
