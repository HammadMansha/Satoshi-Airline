// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Color? fillcolor;
  final Color bordercolor;
  final Color? hinttextColor;
  final Color? prefixIconColor;
  final bool isTextHidden;
  final String? hintText;
  final IconData? buttonIcon;
  final IconData? prefixIcon;
  final bool? togglePassword;
  final int maxlines;
  final int? maxlength;
  final int? maxLength;
  final Function()? toggleFunction;
  final IconData? toggleIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;
  final Function()? prefixIconTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final Widget? suffixicon;
  final double? radius;
  final changeObscureStatus;
  final void Function(String)? onFieldSubmitted;

  const CommonTextField({
    Key? key,
    @required this.controller,
    this.validator,
    this.radius,
    this.bordercolor = const Color(0xffD8D8D8),
    this.hinttextColor,
    this.labelText,
    this.fillcolor,
    this.maxLength,
    this.maxlines = 1,
    this.hintText,
    this.isTextHidden = false,
    this.buttonIcon,
    this.prefixIcon,
    this.prefixIconColor,
    this.onChanged,
    this.togglePassword = false,
    this.toggleFunction,
    this.toggleIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.prefixIconTap,
    this.changeObscureStatus,
    this.focus,
    this.suffixicon,
    this.onFieldSubmitted,
    this.maxlength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      obscureText: isTextHidden,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly == null ? false : true,
      onTap: onTap,
      maxLength: maxLength,
      focusNode: focus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        //suffix:suffixicon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 11.0,
          horizontal: 18.0,
        ),
        prefixIcon: prefixIcon != null
            ? GestureDetector(
                onTap: prefixIconTap,
                child: Icon(
                  prefixIcon,
                  color: prefixIconColor ?? Colors.black,
                  size: 20.0,
                ),
              )
            : null,
        suffixIcon: suffixicon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20.0),
          ),
        ),
        hintText: hintText,
        fillColor: fillcolor,
        filled: true,
        hintStyle: TextStyle(
            color: hinttextColor ?? const Color(0xffB7BCCA), fontSize: 12),
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xffB7BCCA), fontSize: 10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 20.0)),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 15),
      controller: controller,
      validator: validator,
    );
  }
}
