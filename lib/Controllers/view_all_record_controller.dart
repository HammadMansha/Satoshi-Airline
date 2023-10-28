
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:intl/intl.dart';

class ViewAllRecordController extends GetxController {
  bool isLoading = true;

  String assetImage = '';

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final storage = GetStorage();

  List historyList = [];
  String dropdownvalue = 'all';


  @override
  void onInit() {
    if(Get.arguments != null)
      {
        Get.arguments['historyList'].forEach((e){
          historyList.add(e);
        });
        update();
      }
    historyList.forEach((element) {
      print("Check Data $element");
    });
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  String returnDate(String d) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(d);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

}
