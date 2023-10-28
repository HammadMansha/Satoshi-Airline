import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../../Controllers/landing/disable_auth_controller.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';

class DisableAuth extends StatelessWidget {
  const DisableAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);


    return GetBuilder<DisableAuthController>(
      init: DisableAuthController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            body: _.isLoading
                ? Loading()
                : Stack(
              children: [
                Positioned(
                  top: 74,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      _.controller.onInit();
                      Get.back();
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          AppConstants.backBtn.value,
                          height: 42,
                        )),
                  ),
                ),
                Positioned(
                  top: 74,
                  left: 83,
                  // right: 36,
                  child: Transform(
                    transform: Matrix4.identity(),
                    child: Container(
                      width: 272,
                      height: 42,
                      decoration: BoxDecoration(
                          color: AppColors.btnBgColor,
                          border: Border.all(
                            color: AppColors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 80,
                  // right: 40,
                  child: Transform(
                    transform: Matrix4.identity(),
                    child: Container(
                        width: 272,
                        height: 42,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFDFD),
                            border: Border.all(
                              color: AppColors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'VERIFICATION',
                            style: invStatusTitleStyle,
                          ),
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 150, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppConstants.hintTextVerify,
                              style: TextStyle(
                                  color: AppColors.primaryColor2,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: buildVerify(_),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          // height: 150,
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () async {
                            _.isLoading = true;
                            if (_.formKey1.currentState!.validate()) {
                             await _.delete2FA();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffDDFFF4),
                                border: Border.all(),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15))),
                            height: Get.height / 15,
                            width: Get.width,
                            child: const Center(
                                child: MyText(
                                  'SUBMIT',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Form buildVerify(DisableAuthController _) {
    return Form(
      key: _.formKey1,
      child: TextFormField(
        controller: _.emailVerifyCode,
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.number,

        onChanged: (value) {
          // _.formKey.currentState!.validate();
          // _.update();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter Code';
          }
          return null;
        },
        decoration: InputDecoration(
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
          hintText: 'Verification Code',
          hintStyle: hintTextStyle,
          suffixIcon: TextButton(
            onPressed: _.isClock == false
                ? () async {
              await _.sendEmailCode();
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
        // hintText: AppConstants.hintTextVerify,
        // hintStyle: hintTextStyle,
      ),
    );
  }
}