import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/login_controller.dart';
import 'package:satoshi/Views/Policies/privacy_policies.dart';
import 'package:satoshi/Views/Policies/terms_of_use.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Utils/utils.dart';
import '../../widget/common_textfield.dart';
import '../../widget/topbar_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => true,
          child: MediaQuery(
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
                  child: _.isLoading
                      ? Center(
                          child: Image.asset(AppConstants.loading),
                          // child: SpinKitThreeBounce(
                          //   color: AppColors.primaryColor1,
                          //   size: 20.0,
                          // ),
                        )
                      : SafeArea(child: bodydata(_))),
            ),
          ),
        );
      },
    );
  }

  Widget bodydata(LoginController _) {
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

  Widget cardSection(LoginController _) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.offWhite,
          border: Border.all(
            color: Colors.black,
            width: 1.5, // <-- set border width here
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
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
              AppConstants.newLogo,
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
            child: buildPassword(_),
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
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 42,
            child: GestureDetector(
              onTap: _.isChecked
                  ? () {
                      // Do something when the button is pressed
                      if (_.formKey.currentState!.validate() &&
                          _.formKey2.currentState!.validate()) {
                        Get.dialog(
                          SizedBox(
                            width: 300.0,
                            height: 300.0,
                            child: AlertDialog(
                              title: Center(
                                child: Text(AppConstants.alertTitle,
                                    style: alertTitleStyle),
                              ),
                              content: Container(
                                child: richTextAlert(),
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () async {
                                    // setState(() {
                                    //   // isLoading=true;
                                    // });
                                    // loginApi();
                                    Get.back();
                                    await _.login();
                                  },
                                  child: SizedBox(
                                      height: 54,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 54,
                                            child: Image.asset(
                                                AppConstants.alertBtnImage),
                                          ),
                                          Center(
                                            child: Text(
                                              "AGREE TO START",
                                              style: alertBtnStyle,
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  : () {
                      CommonToast.getToast(
                        ' Please Accept terms of condition',
                      );

                      // AppConstants.fieldController.showSnackbar(
                      //   'accessDenied',
                      //   'Kindle accept the privacy policy',
                      // );
                    },
              child: Image.asset(AppConstants.loginBtnImg),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const SizedBox(
              height: 42,
              child: Text(
                "Back",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ).marginOnly(left: 25, right: 25);
  }

  Widget buildEmail(LoginController _) {
    return Form(
      key: _.formKey2,
      child: CommonTextField(
        controller: _.email,
        radius: 10,
        hintText: "Email Address",
        bordercolor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        fillcolor: Colors.white,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
          _.update();
        },
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'enter valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPassword(LoginController _) {
    return Form(
      key: _.formKey,
      child: CommonTextField(
        controller: _.password,
        radius: 10,
        hintText: "Password",
        bordercolor: Colors.black,
        keyboardType: TextInputType.visiblePassword,
        fillcolor: Colors.white,
        togglePassword: true,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
          _.update();
        },
        isTextHidden: _.isPasswordNotVisible,
        maxlines: 1,
        suffixicon: IconButton(
          onPressed: () {
            _.isPasswordNotVisible = !_.isPasswordNotVisible;
            _.update();
          },
          icon: _.isPasswordNotVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'enter password';
          }
          return null;
        },
      ),

      // TextFormField(
      //   controller: _.password,
      //   validator: (value) {
      //     if (value!.isEmpty) {
      //       return 'enter password';
      //     }
      //     return null;
      //   },
      //   obscureText: _.isPasswordNotVisible,
      //   decoration: InputDecoration(
      //       focusedBorder: OutlineInputBorder(
      //         borderSide: const BorderSide(
      //           color: AppColors.black,
      //         ),
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //       enabledBorder: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //         borderSide: const BorderSide(
      //           width: 1,
      //           color: Colors.black,
      //         ),
      //       ),
      //       suffixIcon: IconButton(
      //         onPressed: () {
      //           _.isPasswordNotVisible = !_.isPasswordNotVisible;
      //         },
      //         icon: _.isPasswordNotVisible
      //             ? const Icon(Icons.visibility_off)
      //             : const Icon(Icons.visibility),
      //       ),
      //       hintText: 'Password',
      //       hintStyle: hintTextStyle),
      // ),
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

  Widget richTextAlert() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
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
        ],
      ),
    );
  }
}
