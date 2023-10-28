import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';

class ProfileLink extends StatefulWidget {
  const ProfileLink({Key? key}) : super(key: key);

  @override
  State<ProfileLink> createState() => _ProfileLinkState();
}

class _ProfileLinkState extends State<ProfileLink> {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 74,
              left: 10,
              child: GestureDetector(
                onTap: ()=>Get.back(),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(AppConstants.backBtn.value, height: 42,)),
              ),
            ),
            Positioned(
              top: 74,
              left: 83,
              // right: 36,
              child: Transform(
                transform: Matrix4.identity(),
                // ..setEntry(3, 2, 0.001)
                // ..rotateX(0.5),
                child: Container(
                  width: 272,
                  height: 42,
                  decoration: BoxDecoration(
                      color: AppColors.btnBgColor,
                      border: Border.all(
                        color: AppColors.black,
                        width: 1.5, // <-- set border width here
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 80,
              // right: 40,
              child: Transform(
                transform: Matrix4.identity(),
                // ..setEntry(3, 2, 0.001)
                // ..rotateX(0.5),
                child: Container(
                    width: 272,
                    height: 42,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFDFD),
                        border: Border.all(
                          color: AppColors.black,
                          width: 1.5, // <-- set border width here
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: Center(
                      child: Text(AppConstants.updatePass, style: invStatusTitleStyle,),
                    )
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 20,right: 20, top:150),
              child:  Column(

                children: [
                  const SizedBox(height: 82,),
                  Container(
                    child: Image.asset(AppConstants.cloud, height: 68,),
                  ),
                  const SizedBox(height: 13,),

                  Container(
                    child: Text('Please download and install Google Authenticator. Then, top\nLINK to link it to your Satoshi Ailine\'s account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.primaryColor2, fontSize: 9, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 44,),

                  Container(
                    child: Image.asset(AppConstants.proLink),
                  ),
                  const SizedBox(height: 20,),

                  Container(
                    child: Image.asset(AppConstants.googleAuthDown),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
