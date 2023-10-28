import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Views/AuthScreens/signup.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/fly_to_earn.dart';
import '../../../Controllers/basicTab_controller.dart';
import '../../../Utils/utils.dart';

class BasicTabScreen extends StatelessWidget {
  const BasicTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<BasicTabController>(
      init: BasicTabController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text('0.0', style: noOfSAPStyle),
                        InkWell(
                          onTap: () {
                            Get.to(() => FlyToEarn());
                          },
                          child: Text(
                            'SAP',
                            style: sAPStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3.8,
                              height: Get.height / 6.5,
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width / 3.8,
                                    height: Get.height / 8,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppConstants.travelKM,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "0,00",
                                        style: GoogleFonts.sora(
                                          textStyle: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ).marginOnly(top: 35),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "TRAVEL KM",
                                    style: GoogleFonts.sora(
                                      textStyle: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: Get.width / 3.8,
                              height: Get.height / 6.5,
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width / 3.8,
                                    height: Get.height / 8,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppConstants.redeemKM,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "0,00",
                                        style: GoogleFonts.sora(
                                          textStyle: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ).marginOnly(top: 35),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "REDEEM KM",
                                    style: GoogleFonts.sora(
                                      textStyle: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: Get.width / 3.8,
                              height: Get.height / 6.5,
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width / 3.8,
                                    height: Get.height / 8,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppConstants.burnSAP,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "0,00",
                                        style: GoogleFonts.sora(
                                          textStyle: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ).marginOnly(top: 35),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "SAP BURNED",
                                    style: GoogleFonts.sora(
                                      textStyle: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildEmail(_),
                        const SizedBox(
                          height: 20,
                        ),
                        buildEmail2(_),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: checkinBtn(_),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () async {},
                                child: Image.asset(
                                  AppConstants.googleicom,
                                  height: 50,
                                ).marginOnly(right: 20, top: 50),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).marginOnly(left: 20, right: 20),
                  )
                ],
              ),
            ).marginOnly(left: 10, right: 10),
          ),
        );
      },
    );
  }

  Widget checkinBtn(BasicTabController _) {
    return GestureDetector(
      onLongPress: () async {
        await _.storage.erase();
        Get.offAll(() => const SignUp());
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Color(0xff62C8A9),
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            const Spacer(),
            Text(
              "CHECK IN",
              style: GoogleFonts.sora(
                textStyle: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmail(BasicTabController _) {
    return SizedBox(
      width: Get.width / 2.5,
      child: TextFormField(
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.emailAddress,
        // controller: _.from.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Transform.rotate(
            angle: 45 * 3.14 / 180,
            child: const Icon(
              Icons.airplanemode_active,
              color: Colors.black,
            ),
          ),
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
          hintText: 'From:',
          hintStyle: hintTextStyle,
        ),
        readOnly: true,
        onTap: () {},
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildEmail2(BasicTabController _) {
    return SizedBox(
      width: Get.width / 2.5,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        // controller: _.to.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.location_pin,
            color: Colors.black,
          ),
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
          hintText: 'To:',
          hintStyle: hintTextStyle,
        ),
        readOnly: true,
        onTap: () {},
        textAlign: TextAlign.center,
      ),
    );
  }
}
