import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/AuthScreens/2factor_auth/confirm_key.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../../Controllers/landing/backup_key_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../widget/wallet_widgets/common_toast_message.dart';
import '../../../widget/wallet_widgets/qr_code/qr_code.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';

class BacKUpKey extends StatelessWidget {
  const BacKUpKey({super.key});
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<BacKUpKeyController>(
      init: BacKUpKeyController(),
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
                          onTap: () => Get.back(),
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
                                  'BACKUP KEY',
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
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: buildVerify(_),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyText("Please save the backup key in a secure location."
                                      " This key will allow you to recover your authenticator"
                                      " if you lose your phone. It will be difficult to reset if you lose your key.")
                                  .marginOnly(left: 30, right: 33),
                              const SizedBox(
                                height: 70,
                              ),
                              Container(
                                child: buildSecureKey(_),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _.isKeyArrived == true
                                  ? GestureDetector(
                                      onTap: () async {
                                        // _.isLoading = true;
                                        // if (_.formKey.currentState!.validate() &&
                                        //     _.formKey1.currentState!.validate()) {}
                                        Get.to(() => ConfirmKey());
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
                                          'LINK',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        )),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffDDFFF4),
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      height: Get.height / 15,
                                      width: Get.width,
                                      child: const Center(
                                          child: MyText(
                                        'LINK',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      )),
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

  QRCodeWidget buildVerify(BacKUpKeyController _) {
    return QRCodeWidget(
      qrSize: 220,
      qrData: _.googleAuthKey,
    );
  }

  Form buildSecureKey(BacKUpKeyController _) {
    return Form(
        key: _.formKey1,
        child: TextFormField(
          readOnly: true,
          controller: _.backupKey,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Can not be Null';
            }
            return null;
          },
          onChanged: (value) {
            _.update();
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: _.googleAuthKey));
                ShowToastMessage('Backup KEY Copied');
              },
              child: MyText(
                "Copy",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ).marginOnly(top: 15, right: 15),
            ),
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
        ));
  }
}
