import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SeedPhaseController extends GetxController{
  final storage = GetStorage();

  RxBool showMnemonics = false.obs;

  @override
  void onInit() {
    // storedMnemonics;
    update();
    // storedMnemonics = storage.read<List<String>>('mnemonics') ?? [];
    super.onInit();
  }

  void toggleMnemonics(bool value) {
    showMnemonics.value = value;
  }

}
