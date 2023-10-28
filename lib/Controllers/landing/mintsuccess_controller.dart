import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landing/miniting_globle.dart';

class MintSuccessController extends GetxController {
  bool isLoading = true;

  final storage = GetStorage();

  String walletAddress = '';

  MinitingGlobleController minitingGlobleController =
      Get.find<MinitingGlobleController>();

  @override
  void onInit() async {
    if (storage.hasData("wallet")) {
      walletAddress = await storage.read("wallet");
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async{
    // await getWalletOfOwner();
    isLoading = false;
    update();
    super.onReady();
  }


  // Future<void> getWalletOfOwner() async
  // {
  //   try{
  //     await minitingGlobleController.nftHoldings(walletAddress).then((value)async{
  //       await getResults(value[0][0]);
  //       print("check Value $value");
  //     });
  //   }catch(e){
  //     if (kDebugMode) {
  //       print("Function Error is ${e.toString()}");
  //     }
  //     isLoading = false;
  //     update();
  //   }
  // }

  // Future<void> getResults(var i) async{
  //   try{
  //     print("int value is $i");
  //     await minitingGlobleController.tokenURI(i).then((value){
  //       print("Json Data is $value");
  //     });
  //   }catch(e){
  //     if (kDebugMode) {
  //       print("Function Error is ${e.toString()}");
  //     }
  //     isLoading = false;
  //     update();
  //   }
  // }

}
