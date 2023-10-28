import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:satoshi/Views/AuthScreens/login.dart';
import 'package:satoshi/Views/Policies/privacy_policies.dart';
import 'package:satoshi/Views/Policies/terms_of_use.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/common_textfield.dart';
import '../../Controllers/singup_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Utils/app_constants.dart';
import '../../Utils/app_text_styles.dart';
import '../../Utils/commonSnackbar.dart';
import '../../utils/app_colors.dart';
import '../../widget/topbar_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.bgImage),
                    fit: BoxFit.cover,
                    // alignment: Alignment.topLeft
                  ),
                ),
                child: _.isLoading.value
                    ? Center(
                        child: Image.asset(AppConstants.loading),
                        // child: SpinKitThreeBounce(
                        //   color: AppColors.primaryColor1,
                        //   size: 20.0,
                        // ),
                      )
                    : SafeArea(child: bodyData(_))
                // Stack(
                //     children: [topBar(_), cardSection(_)],
                //   ),
                ),
          ),
        );
      },
    );
  }

  Widget bodyData(SignupController _) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const TopBarWidget(
            heading: AppConstants.loginText,
          ),
          cardSection(_).marginOnly(top: 70),
        ],
      ),
    );
  }

  Widget cardSection(SignupController _) {
    return Container(
      height: Get.height / 1.4,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        border: Border.all(
          color: Colors.black,
          width: 1.5, // <-- set border width here
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            AppConstants.welcomeText,
            style: welcomeTextStyle,
          )),
          const SizedBox(
            height: 7,
          ),
          Center(
            child: Image.asset(
              AppConstants.logo,
              height: 55,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: buildEmail(_),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: buildVerify(_),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: buildReferalLink(_),
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Checkbox(
                // title: Text('I agree to the Privacy Policy'),
                value: _.isChecked,
                onChanged: (bool? value) {
                  _.isChecked = value!;
                  _.update();
                },
              ),
              Flexible(
                child: richText(),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 42,
            child: GestureDetector(
              onTap:
                  // _isChecked
                  //     ?
                  () {
                if (kDebugMode) {
                  print(_.formKey.currentState!.validate());
                  print(_.formKey2.currentState!.validate());
                }
                if (_.formKey.currentState!.validate() &&
                    _.formKey2.currentState!.validate()) {
                  // loginApi();
                  agreeDialog(_);
                }
              },
              child: Image.asset(AppConstants.loginBtnImage),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.signinRoutes);
            },
            child: const SizedBox(
              height: 42,
              child: Text(
                AppConstants.accountLogin,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ).marginOnly(left: 25, right: 25);
  }

  Widget buildEmail(SignupController _) {
    return Form(
      key: _.formKey2,
      child: CommonTextField(
        controller: _.email,
        radius: 10,
        hintText: "Email Address",
        bordercolor: Colors.black,
        fillcolor: Colors.white,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
          _.update();
        },
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          _.regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Enter an email';
          }
          return null;
        },
        onFieldSubmitted: _.isClock == false
            ? (String? c) async {
                if (_.formKey2.currentState!.validate()) {
                  if (_.regExp.hasMatch(_.email.text)) {
                    await _.getOTP();
                  }
                }
              }
            : (String? c) {},
      ),
    );
  }

  Widget buildVerify(SignupController _) {
    return Form(
      key: _.formKey,
      child: CommonTextField(
        controller: _.code,
        radius: 10,
        hintText: "Email verification code",
        bordercolor: Colors.black,
        fillcolor: Colors.white,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _.formKey.currentState!.validate();
          _.update();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter code';
          }
          return null;
        },
        suffixicon: TextButton(
          onPressed: _.isClock == false
              ? () async {
                  if (_.formKey2.currentState!.validate()) {
                    if (_.regExp.hasMatch(_.email.text)) {
                      await _.getOTP();
                    }
                  }
                }
              : () {},
          child: _.isClock
              ? Text(
                  '${_.seconds}',
                  style: textButtonStyle,
                )
              : Text(
                  AppConstants.sendCode,
                  style: textButtonStyle,
                ),
        ),
      ),
    );
  }

  Widget richText() {
    return RichText(
      // textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(text: AppConstants.privacyTxt1, style: hintTextStyleAlert),
        TextSpan(
          text: AppConstants.privacyTxt2,
          style: privacyTxtStyleAlert,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(() => TermsOfServiceScreen());
            },
        ),
        TextSpan(text: AppConstants.privacyTxt3, style: hintTextStyleAlert),
        TextSpan(
          text: AppConstants.privacyTxt4,
          style: privacyTxtStyleAlert,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(() => PrivacyPolicyScreen());
            },
        ),
      ]),
    );
  }

  agreeDialog(SignupController _) {
    Get.dialog(
      SizedBox(
        width: 300.0,
        height: 300.0,
        child: AlertDialog(
          title: Center(
            child: Text(AppConstants.alertTitle, style: alertTitleStyle),
          ),
          content: Container(
            child: richTextAlert(),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                if (_.isChecked) {
                  _.isLoading.value = true;
                  _.update();
                  await _.getSignupWithCode();
                } else {
                  CommonToast.getToast(
                    'Please Accept terms and condition',
                  );
                }
              },
              child: SizedBox(
                height: 54,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 54,
                      child: Image.asset(AppConstants.alertBtnImage),
                    ),
                    Obx(
                      () => Center(
                        child: _.isLoading.value == true
                            ? const SpinKitThreeBounce(
                                color: AppColors.primaryColor2,
                                size: 30.0,
                              )
                            : Text(
                                "AGREE TO START",
                                style: alertBtnStyle,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildReferalLink(SignupController _) {
    return Form(
      key: _.formKey3,
      child: CommonTextField(
        controller: _.userReferralCode,
        radius: 10,
        hintText: "Referral code(optional)",
        bordercolor: Colors.black,
        fillcolor: Colors.white,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget richTextAlert() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: "${AppConstants.privacyTxt1}\n", style: hintTextStyleAlert),
        TextSpan(
          text: AppConstants.privacyTxt2,
          style: privacyTxtStyleAlert,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(() => TermsOfServiceScreen());
            },
        ),
        TextSpan(text: AppConstants.privacyTxt3, style: hintTextStyleAlert),
        TextSpan(
          text: AppConstants.privacyTxt4,
          style: privacyTxtStyleAlert,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(() => PrivacyPolicyScreen());
            },
        ),
      ]),
    );
  }
}
