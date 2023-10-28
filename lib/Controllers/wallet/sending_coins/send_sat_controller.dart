


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../../Utils/appcolor_wallet.dart';

class SendSatCoinController extends GetxController{
  TextEditingController qrContentEditingController = TextEditingController();

  var qrCode = ''.obs;

  String scannedQrcode = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // Future<void> scanQR() async {
  //   try
  //   {
  //     {
  //       scannedQrcode= await FlutterBarcodeScanner.scanBarcode('#ff6666', 'cancel', true, ScanMode.QR);
  //     }
  //     if(scannedQrcode!="-1"){
  //       Get.snackbar("Result", "QR Code"+scannedQrcode,
  //           snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red,colorText: AppColor.white);
  //     }

  //   }
  //   on PlatformException
  //   {


  //   }
  // }
}