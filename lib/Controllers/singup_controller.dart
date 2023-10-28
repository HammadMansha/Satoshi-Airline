import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import '../Utils/app_asset_wallet.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_text_styles.dart';
import '../Views/Landing/landing.dart';
import '../widget/wallet_widgets/text_widget/text_widget.dart';

class SignupController extends GetxController {
  RxBool isLoading = true.obs;
  bool isClock = false;
  bool isChecked = false;
  bool isGoogleAuthVerified = false;
  TextEditingController userReferralCode = TextEditingController();
  final storage = GetStorage();
  TextEditingController googleAuthCode = TextEditingController();

  int seconds = 180;
  Timer? countdownTimer;

  var regExp;
  // String email = '';

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();

  bool googleAuthEnabled = false;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initDynamicLinks();
    isLoading.value = false;
    update();
    super.onReady();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print("Dynmaic Link ${dynamicLinkData.link.path}");
      //<------- function triger when user open app with invite url ----->
      String c =
          dynamicLinkData.link.query.toString().split('invitecode=').last;
      String code = c.split('%').first;
      print("Code is $code");
      storage.write('invite_code', code);
      print("Storage is ${storage.read('invite_code')}");
      //<-------- Add Your Funcationality -------->
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> getOTP() async {
    try {
      print("FUnction OTP Call");
      isLoading.value = true;
      update();
      var res = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(ApiData.baseUrl + ApiData.loginSignupCode),
        body: json.encode({
          "email": email.text,
          "reason": "loginSignup",
        }),
      );
      var data = await json.decode(res.body);
      print("check data otp $data");
      startTimer(); // Start the countdown timer
      isLoading.value = false;
      if (data['message'].toString() == 'Email code sent') {
        isClock = true;
        update();
        CommonToast.getToast(
          ' Please check your email',
        );
      } else {
        isLoading.value = false;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      isLoading.value = false;
      update();
      ShowToastMessage("Server not responding");
      print("Error  throw ${e.toString()}");
    }
  }

  Future<void> getSignupWithCode() async {
    try {
      isLoading.value = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.loginSignup),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email.text, "emailCode": code.text}),
      );
      var data = json.decode(res.body);
      print("check data otp sign up$data");
      if (res.statusCode >= 200 || res.statusCode <= 300) {
        await storage.write("userId", data['data']['userId']);
        // await storage.write("token", data['data']['token']);
        bool googleAuthEnabled = data['data']['googleAuthenticator'];
        print("google auth value for this user---------$googleAuthEnabled");

        isLoading.value = false;
        update();

        if (googleAuthEnabled) {
          // Show the Google Authenticator settings dialog
          showGoogleAuthBox();
        } else {
          if (!googleAuthEnabled) {
            if (userReferralCode.text.isNotEmpty) {
              storage.write('invite_code', userReferralCode.text);
              print("Storage is ${storage.read('invite_code')}");
            }
            await storage.write("token", data['data']['token']);
            // Navigate to the next screen only if Google Authenticator is not enabled
            Get.offAll(() => const LandingPage());
          }
        }
      } else {
        isLoading.value = true;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  Future<void> verify2FaAuth() async {
    try {
      isLoading.value = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.verify2FA),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": storage.read('userId'),
          "twoFactorCode": googleAuthCode.text,
        }),
      );
      var data = json.decode(res.body);
      print("check verify google auth up$data");
      if (res.statusCode >= 200 || res.statusCode <= 300) {
        await storage.write("token", data['data']['token']);

        isLoading.value = false;
        update();
        ShowToastMessage('Logged In');

        Get.offAll(() => const LandingPage());
      } else {
        ShowToastMessage('Invalid Code');
        isLoading.value = true;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      ShowToastMessage('Invalid Code');
      isLoading.value = false;
      update();
    }
  }

  // Call this function to mark Google Authenticator as verified
  void markGoogleAuthVerified() {
    isGoogleAuthVerified = true;
  }

  startTimer() {
    seconds = 180;
    isClock = true;
    update();

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        stopTimer();
      }
    });
  }

  stopTimer() {
    countdownTimer?.cancel();
    isClock = false;
    update();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  //<----------- Goolge SignIn --------->

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error is ${e.toString()}");
      isLoading.value = false;
      update();
      CommonToast.getToast('Failed to sign In with google');
    }
  }

  void showGoogleAuthBox() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width, // Set the width of the dialog
          height: 290, // Set the height of the dialog
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Spacer(),
                  MyText(
                    'GOOGLE AUTHENTICATOR',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ).marginOnly(top: 30),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      code.clear();

                      Get.back();
                      Get.back();
                    },
                    child: CircleAvatar(
                      child: Image.asset(AppAssets.crossIcon, width: 42),
                    ).marginOnly(top: 30, right: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                child: Form(
                    key: formKey3,
                    child: TextFormField(
                      controller: googleAuthCode,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'verify Please';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: MyText(
                          'Paste',
                          color: Colors.yellow,
                        ).marginOnly(top: 15, right: 12),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        // prefixIcon: const Icon(Icons.lock_outline),

                        hintStyle: hintTextStyle,
                      ),
                    )).marginOnly(left: 20, right: 21),
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                'Enter the 6-digit code from Google 2 Factor Authentication    ',
                fontSize: 11,
              ).marginOnly(left: 25),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey3.currentState!.validate()) {
                    await verify2FaAuth();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffDDFFF4),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: Get.height / 18,
                  width: Get.width,
                  child: const Center(
                      child: MyText(
                    'CONFIRM',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ).marginOnly(left: 20, right: 21),
            ],
          ),
        ),
      ),
    );
  }
}
