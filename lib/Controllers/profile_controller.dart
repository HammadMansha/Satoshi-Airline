import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:satoshi/Controllers/singup_controller.dart';

import '../Utils/api.dart';
import '../Utils/app_constants.dart';
import 'package:http/http.dart' as http;


class ProfileController extends GetxController {
  bool isLoading = true;
  bool checkForSound = true;
  bool checkForAuth = true;
  bool isKm = false;

  String distance = '';
  String selected = 'km';
  String result = 'km';
  String result2 = 'mile';
  bool googleAuthValue=false;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final storage = GetStorage();

  

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.comingSoonSound));
  }

  void launchUrl(launchUrl) async {
    if (!await launchUrl(launchUrl)) throw 'Could not launch';
  }

  @override
  void onInit()async {
    await getGoogleAuthStatus();

    distance = landingPageController.balanceData['distance'] == null
        ? '0.00'
        : myFormat.format(double.parse(double.parse(
                landingPageController.balanceData['distance'].toString())
            .toStringAsFixed(2)));
    // double.parse(landingPageController.balanceData['distance'].toString())
    //     .toDouble();
    super.onInit();
  }





  @override
  void onReady()async {

    isLoading = false;
    update();
    super.onReady();
  }



  //------------------------------Get google auth status---------------

Future<void> getGoogleAuthStatus()async{
    isLoading=true;
    update();


    var res = await http.post(
    headers: {
      'Content-Type': 'application/json',
      'Authorization': storage.read("token")
    },
    Uri.parse(ApiData.getAuthStatus),
    body: json.encode({
      "userId":storage.read("userId"),
    }),
  );

  var data = await json.decode(res.body);
  print("response body of get auth status-------------${res.body}");


  if(res.statusCode==200){
    googleAuthValue=data["data"]["googleAuthenticator"];
    update();
  }
  isLoading=false;
  update();


  print("google auth value button--------------------$googleAuthValue");

}


}
