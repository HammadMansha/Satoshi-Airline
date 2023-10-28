import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/appcolor_wallet.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final bool upperCase;
  final double letterSpacing;
  final TextDecoration? decoration;
  final TextOverflow? overflow;

  const MyText(
    this.text, {
    this.upperCase = false,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.color,
    this.style,
    this.fontWeight,
    this.letterSpacing = 0,
    this.decoration,
    this.overflow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(upperCase ? text.toUpperCase() : text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.sora(
            letterSpacing: letterSpacing,
            fontSize: fontSize ?? 12,
            color: color ?? AppColor.black,
            decoration: decoration,
            fontWeight: fontWeight ?? FontWeight.normal));
  }
}
