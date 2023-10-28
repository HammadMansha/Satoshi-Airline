import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextControllers extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  // Rx<TextEditingController> updatePasswordController = TextEditingController().obs;
  Rx<TextEditingController> arriveController = TextEditingController().obs;
  Rx<TextEditingController> destController = TextEditingController().obs;
  Rx<TextEditingController> transferController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  static TextControllers fieldControllers = Get.find();
  void showSnackbar(title, message) {
    Get.snackbar(
      title, // title
      message, // message
      snackPosition: SnackPosition.BOTTOM, // position
      duration: Duration(seconds: 3), // duration
      backgroundColor: Colors.grey[600], // background color
      colorText: Colors.white, // text color
      borderRadius: 10, // border radius
      margin: EdgeInsets.all(15), // margin
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // padding
      // You can customize the animation using the following properties
      animationDuration: Duration(milliseconds: 500),
      // animationCurve: Curves.easeInOut,
      // You can add an action button to the SnackBar using the following property
      // action: SnackAction(label: 'Action', onPressed: () {}),
    );
  }
}
