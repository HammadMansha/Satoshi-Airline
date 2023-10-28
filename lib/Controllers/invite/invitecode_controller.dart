import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class InvitationCodeScreenController extends GetxController {
  bool isLoading = true;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final storage = GetStorage();
  List friendsList = [];

  int rewardTotal = 0;

  @override
  void onReady() async {
    await getReferalHistory();
    isLoading = false;
    update();
    super.onReady();
  }

  //<--------------- Flutter Dynamic Links ------------>

  Future<void> createDynamicLink(bool short) async {
    print("Check INvite Code ${landingPageController.user['invitationCode']}");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://satoshiairline.page.link',
      link: Uri.parse(
          'https://satoshiairline.page.link/code?invitecode=${landingPageController.user['invitationCode']}}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.satoshi',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'satoshiairline.apples.com',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
      Share.share(
          'Please click on link and get 5 SAP Reward on your first travel $url');
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
  }

  Future<void> getReferalHistory() async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(
          ApiData.baseUrl + ApiData.getReferalHistory + storage.read('userId'),
        ),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        print("Res Data $data");
        friendsList = data['result'];
        isLoading = false;
        update();
        print("List $friendsList");
        friendsList.forEach((element) {
          rewardTotal =
              rewardTotal + int.parse(element['sapReward'].toString());
        });
        update();
      } else {
        isLoading = true;
        update();
        print("Res Data $data");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error ${e.toString()}");
    }
  }
}
