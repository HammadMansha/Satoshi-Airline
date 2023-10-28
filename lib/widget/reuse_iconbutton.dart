import 'package:flutter/material.dart';

class ReusableIconButton extends StatelessWidget {
  final Widget? icon;
  final void Function()? onPressed;
  final Text? btntxt;
  const ReusableIconButton(
      {super.key,
      @required this.icon,
      @required this.onPressed,
      @required this.btntxt});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          icon!,
          btntxt!,
        ],
      ),
    );
  }
}
