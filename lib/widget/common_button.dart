// ignore_for_file: deprecated_member_use
import 'package:button_animations/button_animations.dart';
import 'package:flutter/material.dart';
import 'package:satoshi/Utils/utils.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? width;
  final double? height;
  final Color color;
  final Color? shadowColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.shadowColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onTap: onPressed,
      type: null,
      shadowColor: shadowColor ?? Colors.black,
      height: height ?? 52,
      width: width ?? 330,
      isOutline: true,
      darkShadow: true,
      shadowHeightBottom: 3,
      shadowHeightLeft: 2,
      borderRadius: 8,
      borderColor: Colors.black,
      blurColor: Colors.black,
      color: color,
      child: Text(
        text,
        style: toStyle,
      ),
    );
  }
}
