import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class CommonSnackbar {
//   static getSnackbar(String title, String message, Color snackbarColor) {
//     Get.snackbar(
//       title,
//       message,
//       colorText: Colors.white,
//       backgroundColor: snackbarColor,
//     );
//   }
// }

class CommonToast {
  static getToast(String body) {
    Fluttertoast.showToast(
      msg: body,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}