import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Utils/app_colors.dart';
import 'package:satoshi/Utils/app_constants.dart';
import 'package:satoshi/Utils/app_text_styles.dart';
// import 'package:satoshi/Views/Profile/delete_account.dart';
// import 'package:satoshi/Views/Profile/update_field.dart';
// import 'package:satoshi/Views/Profile/update_password.dart';
import 'package:satoshi/routes/app_routes.dart';
import '../../Controllers/editprofile_controller.dart';
import '../../shimmer/profile_effect.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            body: _.isLoading
                ? ProfileShimmer()
                : Column(
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
                                    const EdgeInsets.only(top: 25, left: 10),
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
                                    showAvatarDialog(_);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                          BorderRadius.circular(
                                                              5),
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
                        padding:
                            const EdgeInsets.only(top: 35, left: 20, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(color: Color(0xff525252)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${_.landingPageController.user['email']}',
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      ' >',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.updateNameRoutes);
                                // Get.to(() => const UpdateField());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Name',
                                    style: TextStyle(color: Color(0xff525252)),
                                  ),
                                  Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          _.landingPageController.username
                                              .value,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Text(
                                        ' >',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                alertDialogGender(_);
                                // Get.to(() => const UpdatePassword());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Gender',
                                    style: TextStyle(color: Color(0xff525252)),
                                  ),
                                  Row(
                                    children: [
                                      Obx(
                                        () => _.gender.isEmpty
                                            ? const Text(
                                                'set',
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : Text(
                                                _.gender.value,
                                                style: const TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ),
                                      Obx(
                                        () => Text(
                                          _.gender.isEmpty ? ' >' : '',
                                          style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.updatePasswordRoutes);
                                // Get.to(() => const UpdatePassword());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Password',
                                    style: TextStyle(color: Color(0xff525252)),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'set',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        ' >',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.deleteAccountRoutes);
                                // Get.to(() => const DeleteAccount());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Delete Account ',
                                    style: TextStyle(color: Color(0xffFF5C5C)),
                                  ),
                                  Text(
                                    ' >',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  alertDialogGender(EditProfileController _) => Get.dialog(
        AlertDialog(
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.black, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          titlePadding: EdgeInsets.all(0.0),
          backgroundColor: const Color(0xffddfff4),
          // insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              const Text(
                AppConstants.alertTitleGender,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ).marginOnly(left: 20),
              Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  AppConstants.cancelBtn,
                  height: 42,
                ),
              ).marginOnly(top: 10, right: 10),
            ],
          ),
          content: genderWidget(_),
          actions: [
            GestureDetector(
              onTap: () async {
                Get.back();
                await _.updateGender();
              },
              child: Image.asset(
                AppConstants.conBtnL,
                height: 54,
              ),
            ),
          ],
        ),
      );

  Widget genderWidget(EditProfileController _) {
    List<Widget> c = [];
    for (int i = 0; i < _.genderList.length; i++) {
      c.add(
        GestureDetector(
          onTap: () {
            _.selectedGender.value = _.genderList[i]['name'];
          },
          child: Obx(
            () => Container(
              height: 58,
              // width: 58,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                border: Border.all(
                  color: _.selectedGender.value == _.genderList[i]['name']
                      ? const Color(0xff62C8A9)
                      : Colors.transparent,
                  width: 4.0,
                ),
              ),
              child: Image.asset(
                _.genderList[i]['imagePath'],
                height: 45,
                width: 45,
              ),
            ),
          ),
        ).marginAll(5),
      );
    }
    return Wrap(
      children: c,
    );
  }

  showAvatarDialog(EditProfileController _) {
    Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: AppColors.black, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Text(AppConstants.avatarAlertTitle, style: alertTitleStyle),
          ),
        ),
        backgroundColor: const Color(0xffddfff4),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 250,
          width: Get.width,
          child: avatarWidget(_),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              Get.back();
              await _.setAvatar();
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              height: 54,
              child: Stack(
                children: [
                  SizedBox(
                    height: 54,
                    child: Center(
                        child: Image.asset(AppConstants.avatarAlertBtnImage)),
                  ),
                  Center(
                    child: Text(
                      "SAVE",
                      style: alertBtnStyle,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget avatarWidget(EditProfileController _) {
    List<Widget> c = [];
    for (int i = 0; i < _.avatarList.length; i++) {
      c.add(
        GestureDetector(
          onTap: () {
            _.selectedAvatar.value = _.avatarList[i]['_id'];
          },
          child: Obx(
            () => Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _.selectedAvatar.value == _.avatarList[i]['_id']
                      ? const Color(0xff62C8A9)
                      : Colors.transparent,
                  width: 4.0,
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "${_.avatarList[i]['path']}",
                    // errorListener: () {
                    //   const Text(
                    //     'Loading',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 20,
                    //     ),
                    //   );
                    // },
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ).marginAll(3),
      );
    }
    return Wrap(
      children: c,
    );
  }
}

// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   AuthServices services = AuthServices();

//   final _formKey2 = GlobalKey<FormState>();

//   Form buildEmail() {
//     return Form(
//       key: _formKey2,
//       child: TextFormField(
//         // style: const TextStyle(color: AppColors.descColor),
//         keyboardType: TextInputType.emailAddress,
//         controller: AppConstants.fieldController.emailController.value,
//         validator: (value) {
//           const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
//           final regExp = RegExp(pattern); // uni code form mai reg exp dedi hai

//           if (value!.isEmpty) {
//             return 'enter an email';
//           } else if (!regExp.hasMatch(value)) {
//             return 'enter valid email';
//           }
//         },
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColors.black,
//             ),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(
//               width: 1,
//               color: Colors.black,
//             ),
//           ),
//           // border: OutlineInputBorder(
//           //   borderSide: BorderSide.none,
//           //   // borderRadius: BorderRadius.circular(50),
//           // ),
//           hintText: AppConstants.hintTextEmail,
//           hintStyle: hintTextStyle,
//         ),
//       ),
//     );
//   }
//   var email;
//   var user_name;
//   var assetImage;
//   var token;
//   var userId;

//   getUserInfo() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       userId = pref.getString('userId');
//       token = pref.getString('token');
//       email = pref.getString('email');
//       user_name = pref.getString('name');
//       assetImage = pref.getString('assetImage');
//     });
//   }

//   @override
//   void initState() {
//     getUserInfo();
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(EditProfile oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     getUserInfo();
//   }

//   var getUser;

//   @override
//   Widget build(BuildContext context) {

//     return }

//   double _borderWidth = 0.0;

//   void _handleTap() {
//     setState(() {
//       _borderWidth = 3.0;
//       print('Border width updated to $_borderWidth');
//     });
//   }

//   setAsset(data) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('assetImage', data);
//     updateAvatar(data);
//   }

//   void updateAvatar(String avatar) {
//     setState(() {
//       assetImage = avatar;
//     });
//   }
// }
