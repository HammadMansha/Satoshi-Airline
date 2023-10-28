import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Services/wallet_services.dart';


class CreateWalletController extends GetxController {
  final storage = GetStorage();
  final publicKey = RxString('');
  final private = RxString('');
  String mnemonic = '';

  @override
  void onInit() {
    super.onInit();
    generateSeedPhrase();
  }
  TextSpan buildTextSpan(String text, Color color) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  Future<void> generateSeedPhrase() async {
    try {
      WalletAddress service = WalletAddress();
      String mnemonics = service.generateMnemonic();
      Get.log("Words are : $mnemonics");
      mnemonic = mnemonics;

      String privatekey = await service.getPrivateKey(mnemonic);
      final public = await service.getPublicKey(privatekey);

      print("Private Key $privatekey");
      print("Public key $public");
      publicKey.value = public.hex;
      private.value = privatekey;

      storage.write('mnemonics', mnemonic);
    } catch (e) {
      print("Error: $e");
    }
  }
}
