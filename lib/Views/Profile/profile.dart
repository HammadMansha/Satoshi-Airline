import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Views/Profile/invitecode_screen.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../Controllers/profile_controller.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Utils/utils.dart';
import '../AuthScreens/2factor_auth/disable_auth.dart';
import '../Holders/NonNftHolder/LeadingBoard/leading_tab_view.dart';
import '../AuthScreens/2factor_auth/link_google.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            resizeToAvoidBottomInset: false,
            body:_.isLoading==true?Loading():

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color(0xffCDFCEA),
                      border: Border.all(color: AppColors.black, width: 1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 43.5,
                                      width: 43.5,
                                      decoration: BoxDecoration(
                                        color: Color(0xff62C8A9),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => const EditProfile());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 52,
                                      width: 65,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 63,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff62c8a9),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Obx(
                                                () => _.landingPageController
                                                        .assetImage.isEmpty
                                                    ? Image.asset(
                                                        AppConstants
                                                            .profileImg.value,
                                                        height: 40,
                                                        width: 40,
                                                      )
                                                    : Image.network(
                                                        _.landingPageController
                                                            .assetImage.value,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 112,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff62c8a9),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ).marginOnly(left: 5, top: 6),
                                          Container(
                                            height: 27,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _.landingPageController
                                                                .balanceData[
                                                            'distance'] ==
                                                        null
                                                    ? '0.00 km'
                                                    : '${_.myFormat.format(double.parse(double.parse(_.landingPageController.balanceData['distance'].toString()).toStringAsFixed(2)))} Km',
                                                maxLines: 1,
                                                style: GoogleFonts.sora(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ).marginOnly(left: 5, right: 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).marginOnly(top: 10),
                              )
                            ],
                          ),
                        ).marginOnly(top: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          // height: Get.height / 4,
                          // width: Get.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  _.landingPageController.username.value,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _.landingPageController.user['email'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff525252)),
                              ),
                            ],
                          ).marginOnly(top: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () =>
                                  Get.toNamed(Routes.editprofileRoutes),
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 43.5,
                                      width: 43.5,
                                      decoration: BoxDecoration(
                                        color: Color(0xff62C8A9),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // RotatedBox(
                              //   quarterTurns: 2,
                              //   child: Image.asset(
                              //     AppConstants.backBtn.value,
                              //     height: 42,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Fly Distance',
                              style: TextStyle(color: Color(0xff525252)),
                            ),
                            Row(
                              children: [
                                Text(
                                  _.distance.toString(),
                                  style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(child: buildSwitch(context, _)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // const SizedBox(
                        //   height: 35,
                        // ),
                        InkWell(
                          onTap: () {
                            Get.to(()=>DisableAuth());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Flight Stone',
                                style: TextStyle(color: Color(0xff525252)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  '20.00 KG',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.toNamed(Routes.termsandconditionRoutes);
                            Get.to(() => const LeadingTabView());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Travel History',
                                style: TextStyle(color: Color(0xff525252)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  '>',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sound',
                              style: TextStyle(
                                color: Color(
                                  0xff525252,
                                ),
                              ),
                            ),
                            SizedBox(height: 33, child: buildSwitchSound(_)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Google Authenticator',
                              style: TextStyle(
                                color: Color(
                                  0xff525252,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 33, child: buildSwitchGoogleAuth(_)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Invite Code',
                              style: TextStyle(color: Color(0xff525252)),
                            ),

                            Container(
                              height: 24,
                              width: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                child: InkWell(
                                    onTap: () {
                                      Get.to(() => InvitationCodeScreen());
                                    },
                                    child: MyText(
                                      'STATUS',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                            // SizedBox(
                            //   width: 29,
                            // ),
                            GestureDetector(
                              onTap: () {
                                final invitationCode = _.landingPageController
                                    .user['invitationCode'];
                                Clipboard.setData(
                                    ClipboardData(text: invitationCode));
                                ShowToastMessage('Code Copied');
                              },
                              child: Container(
                                height: 24,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Center(
                                  child: MyText(
                                    '${_.landingPageController.user['invitationCode']}',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.termsandconditionRoutes);
                            // Get.to(() => const TermsOfServiceScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Terms of use',
                                style: TextStyle(color: Color(0xff525252)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  '>',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.privacyPolicyRoutes),
                          // Get.to(() => const PrivacyPolicyScreen()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Privacy policy',
                                style: TextStyle(color: Color(0xff525252)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  '>',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            await launchUrlString(
                              'https://youtu.be/V4A4cklChnU',
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'How to play',
                                style: TextStyle(color: Color(0xff525252)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  '>',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Version',
                              style: TextStyle(color: Color(0xff525252)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: const Text(
                                '0.2.10 Release',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 33,),
                        Center(
                          child: Image.asset(AppConstants.statusButton,width: 152,height: 39,),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 60, left: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await launchUrlString(
                                        'https://discord.com/invite/7pVTcHYHn7',
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Image.asset(AppConstants.discordBtn,
                                      height: 48)),
                              GestureDetector(
                                  onTap: () async {
                                    await launchUrlString(
                                        'https://t.me/satoshiairlines',
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Image.asset(AppConstants.telegramBtn,
                                      height: 48)),
                              GestureDetector(
                                  onTap: () async {
                                    await launchUrlString(
                                        'https://twitter.com/Satoshiairlines',
                                        mode: LaunchMode.externalApplication);
                                    // _.launchUrl(
                                    //     'https://twitter.com/Satoshiairlines');
                                  },
                                  child: Image.asset(AppConstants.twitterBtn,
                                      height: 48)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 30),
                          child: GestureDetector(
                            onTap: () async {
                              await _.storage.erase();
                              Get.offAllNamed(Routes.signupRoutes);
                              // Get.offAll(() => const SignUp());
                              CommonToast.getToast(
                                'Logout Success !',
                              );
                              // CommonSnackbar.getSnackbar(
                              //   "Success",
                              //   "account logout successfully",
                              //   Colors.green,
                              // );
                            },
                            child:
                                Image.asset(AppConstants.logoutBtn, height: 42),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSwitch(BuildContext context, ProfileController _) {
    return GestureDetector(
      onTap: () {
        _.isKm = !_.isKm;
        _.update();
        if (_.isKm == false) {
          _.distance = _.myFormat.format(double.parse(double.parse(
                  _.landingPageController.balanceData['distance'].toString())
              .toStringAsFixed(2)));
        } else {
          var d = double.parse(
              _.landingPageController.balanceData['distance'].toString());
          double mile = d * 0.6214;
          _.distance = _.myFormat.format(
              double.parse(double.parse(mile.toString()).toStringAsFixed(2)));
          // _.distance = double.parse(mile.toDouble().toStringAsFixed(2));
          _.update();
        }
      },
      child: Container(
        width: 72,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xffddfff4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 30,
              decoration: BoxDecoration(
                color: _.isKm == false ? Color(0xff62C8A9) : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: _.isKm == false ? Colors.black : Colors.transparent),
              ),
              child: Center(
                child: Text('Km'),
              ),
            ),
            const Spacer(),
            // _.isKm ? Spacer(),
            Container(
              width: 35,
              height: 30,
              decoration: BoxDecoration(
                color: _.isKm ? Color(0xff62C8A9) : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: _.isKm ? Colors.black : Colors.transparent),
              ),
              child: Center(
                child: Text('Mile'),
              ),
            )
          ],
        ),
      ),
    );
    // FlutterSwitch(
    //   width: 60,
    //   height: 30,
    //   showOnOff: false,
    //   value: _.isKm,
    //   activeIcon: Text(
    //     _.result,
    //     style: const TextStyle(
    //       color: Color(0xff525252),
    //       fontWeight: FontWeight.w800,
    //       fontSize: 20,
    //     ),
    //   ),
    //   activeText: _.result,
    //   valueFontSize: 20,
    //   inactiveIcon: Text(
    //     _.result2,
    //     style: const TextStyle(
    //       color: Color(0xff525252),
    //       fontWeight: FontWeight.w800,
    //       fontSize: 20,
    //     ),
    //   ),
    //   inactiveText: _.result2,
    //   activeColor: const Color(0xff62C8A9),
    //   inactiveColor: Color(0xFF324259),
    //   activeTextFontWeight: FontWeight.w800,
    //   inactiveTextFontWeight: FontWeight.w800,
    //   onToggle: (val) {
    //     if (val) {
    //       _.distance = _.myFormat.format(double.parse(double.parse(
    //               _.landingPageController.balanceData['distance'].toString())
    //           .toStringAsFixed(2)));
    //     } else {
    //       _.isKm = val;
    //       _.selected = 'Mile';
    //       _.update();
    //       var d = double.parse(
    //           _.landingPageController.balanceData['distance'].toString());
    //       double mile = d * 0.6214;
    //       _.distance = _.myFormat.format(
    //           double.parse(double.parse(mile.toString()).toStringAsFixed(2)));
    //       // _.distance = double.parse(mile.toDouble().toStringAsFixed(2));
    //       _.update();
    //     }
    //     _.isKm = val;
    //     _.update();
    //   },
    // );
  }

  Widget buildSwitchSound(ProfileController _) {
    return GestureDetector(
      onTap: () {
        _.landingPageController.isSound = !_.landingPageController.isSound;
        _.landingPageController.update();
        _.update();
        if (_.landingPageController.isSound) {
          _.storage.write("sound", true);
          _.playSoundEffect();
        } else {
          _.landingPageController.isSound = false;
          _.storage.write("sound", false);
          _.landingPageController.update();
        }
      },
      child: Container(
        width: 62,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xffddfff4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _.landingPageController.isSound == false
                    ? Color(0xffE0E0E0)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: _.landingPageController.isSound == false
                        ? Colors.black
                        : Colors.transparent),
              ),
              child: Center(
                child: Text('Off'),
              ),
            ),
            const Spacer(),
            // _.isKm ? Spacer(),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _.landingPageController.isSound
                    ? Color(0xff62C8A9)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: _.landingPageController.isSound
                        ? Colors.black
                        : Colors.transparent),
              ),
              child: Center(
                child: Text('On'),
              ),
            )
          ],
        ),
      ),
    );

    // Switch.adaptive(
    //   activeColor: const Color(0xff62C8A9),
    //   inactiveTrackColor: const Color(0xFF324259),
    //   inactiveThumbColor: const Color(0xff62C8A9),
    //   activeTrackColor: const Color(0xff62C8A9),
    //   value: _.landingPageController.isSound,
    //   onChanged: (checkBool2) {
    //     _.landingPageController.isSound = !_.landingPageController.isSound;
    //     _.landingPageController.update();
    //     _.update();
    //     if (_.landingPageController.isSound) {
    //       _.playSoundEffect();
    //     } else {
    //       _.landingPageController.isSound = checkBool2;
    //       _.landingPageController.update();
    //     }
    //   },
    // );
  }


  Widget buildSwitchGoogleAuth(ProfileController _) {
    return GestureDetector(
      onTap: () {
        if(_.googleAuthValue==true){
          Get.to(DisableAuth());
        }
        else {
          Get.to(GoogleLink());
        }
      },
      child: Container(
        width: 62,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xffddfff4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _.googleAuthValue == false
                    ? Color(0xffE0E0E0)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: _.googleAuthValue == false
                        ? Colors.black
                        : Colors.transparent),
              ),
              child: Center(
                child: Text('Off'),
              ),
            ),
            const Spacer(),
            // _.isKm ? Spacer(),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _.googleAuthValue
                    ? Color(0xff62C8A9)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color:_.googleAuthValue
                        ? Colors.black
                        : Colors.transparent),
              ),
              child: Center(
                child: Text('On'),
              ),
            )
          ],
        ),
      ),
    );

    // Switch.adaptive(
    //   activeColor: const Color(0xff62C8A9),
    //   inactiveTrackColor: const Color(0xFF324259),
    //   inactiveThumbColor: const Color(0xff62C8A9),
    //   activeTrackColor: const Color(0xff62C8A9),
    //   value: _.landingPageController.isSound,
    //   onChanged: (checkBool2) {
    //     _.landingPageController.isSound = !_.landingPageController.isSound;
    //     _.landingPageController.update();
    //     _.update();
    //     if (_.landingPageController.isSound) {
    //       _.playSoundEffect();
    //     } else {
    //       _.landingPageController.isSound = checkBool2;
    //       _.landingPageController.update();
    //     }
    //   },
    // );
  }



  Widget buildSwitchAuth(ProfileController _) {
    return Switch.adaptive(
      activeColor: const Color(0xFFDDFFF4),
      inactiveTrackColor: const Color(0xFF324259),
      inactiveThumbColor: const Color(0xff62C8A9),
      activeTrackColor: const Color(0xff62C8A9),
      value: _.googleAuthValue,
      onChanged: (value) {
         print('kkk: $value');
         _.googleAuthValue=value;
         _.update();

         if(_.googleAuthValue==false){
           Get.to(DisableAuth());
         }
         else {
           Get.to(GoogleLink());
         }
        // _.checkForAuth = checkBool2;
        // if (checkBool2) {
        //   alertDialogAuth();
        // }

      },
    );
  }

 void alertDialogAuth() {
    Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 40,
            ),
            const Text(
              AppConstants.alertTitleGoogleAuth,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppConstants.cancelBtn,
                height: 42,
              ),
            )
          ],
        ),
        content: const Text(
          'You must have Google AUTHENTICATION turned on in order to perform this action',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xff858585),
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(()=>GoogleLink());
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Image.asset(
                AppConstants.googleAuthBtn,
                height: 54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
