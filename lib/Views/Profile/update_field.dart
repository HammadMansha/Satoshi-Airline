import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/shimmer/updatename_effect.dart';
import '../../Controllers/updatefield_controller.dart';
import '../../Utils/utils.dart';

class UpdateField extends StatelessWidget {
  const UpdateField({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<UpdateFieldController>(
      init: UpdateFieldController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            body: _.isLoading
                ? UpdateProfileShimmer()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: height * 0.35,
                            width: width,
                            decoration: BoxDecoration(
                              color: const Color(0xffCDFCEA),
                              border:
                                  Border.all(color: AppColors.black, width: 1),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 50, left: 10),
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
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      // showAvatarDialog(_);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 92,
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
                                                        color: const Color(
                                                            0xff62c8a9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Obx(
                                                          () => _
                                                                  .landingPageController
                                                                  .assetImage
                                                                  .value
                                                                  .isEmpty
                                                              ? Image.asset(
                                                                  AppConstants
                                                                      .profileImg
                                                                      .value,
                                                                  height: 40,
                                                                  width: 40,
                                                                )
                                                              : Image.network(
                                                                  _
                                                                      .landingPageController
                                                                      .assetImage
                                                                      .value,
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
                                                        color: const Color(
                                                            0xff62c8a9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ).marginOnly(
                                                        left: 5, top: 6),
                                                    Container(
                                                      height: 27,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                                          style:
                                                              GoogleFonts.sora(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ).marginOnly(
                                                          left: 5, right: 5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ).marginOnly(top: 10),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Obx(
                                          () => Text(
                                            _.landingPageController.username
                                                .value,
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
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 50, left: 20, right: 20),
                          child: buildEmail(_),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 157,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _.updateName();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFFF7AF)),
                              child: Text('UPDATE', style: updateTxtStyle),
                            ),
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

  Widget buildEmail(UpdateFieldController _) {
    return Form(
      key: _.formKey2,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _.username,
            // validator: (value) {},
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
              hintText: AppConstants.hintTextName,
              hintStyle: hintTextStyle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
