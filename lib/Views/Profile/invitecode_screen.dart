import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/invite/invitecode_controller.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Views/Profile/viewFriends_screen.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/containers/short_containor.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import 'package:satoshi/widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';

class InvitationCodeScreen extends StatelessWidget {
  const InvitationCodeScreen({Key? key})
      : super(key: key); // Fix the constructor

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<InvitationCodeScreenController>(
      init: InvitationCodeScreenController(),
      builder: (_) {
        // Use the controller parameter
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            body: _.isLoading
                ? Center(
                    child: Loading(),
                  )
                : SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TopTransfer(
                            'STATUS OF INVITATION',
                          ).marginOnly(top: 30),
                          SizedBox(
                            height: 10,
                          ),
                          totalInvitation(context, _),
                          SizedBox(
                            height: 8,
                          ),
                          invitationBox(context, _),
                          SizedBox(
                            height: 10,
                          ),
                          sapInvite(context, _),
                          SizedBox(
                            height: 10,
                          ),
                          inviteBox(),
                          SizedBox(
                            height: 47,
                          ),
                          withdrawButton(_),
                          lastText(),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget totalInvitation(
      BuildContext context, InvitationCodeScreenController _) {
    return Row(children: [
      ShortContainer(
        height: Get.height / 15,
        width: Get.width / 2.6,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xffDDFFF4),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: MyText(
                    'Invitation',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1), // Add some space between the containers
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: MyText(
                    '${_.friendsList.length} Friends',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).marginOnly(left: 25, right: 12),
      ShortContainer(
        height: Get.height / 15,
        width: Get.width / 2.6,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xffDDFFF4),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: MyText(
                    'Reward',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1), // Add some space between the containers
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: MyText(
                    '${_.rewardTotal}.0 SAP',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).marginOnly(left: 25, right: 12),
    ]);
  }

  Widget invitationBox(BuildContext context, InvitationCodeScreenController _) {
    return ShortContainer(
        height: Get.height / 3.5,
        width: Get.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            MyText('REFER YOUR FRIEND AND EARN',
                fontSize: 11, fontWeight: FontWeight.w600),
            SizedBox(
              height: 25,
            ),
            Row(children: [
              Image.asset(
                AppAssets.invitationLogo,
                width: 53,
                height: 56,
              ).marginOnly(left: 101),
              Spacer(),

              // SizedBox(
              //   width: 25.5,
              // ),
              MyText(
                '5.0 SAP',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ).marginOnly(right: 101)
            ]),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 67,
              width: Get.width / 2,
              // color: Colors.red,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Color(0xffCFCFCF)),
              ),
              child: Row(
                children: [
                  MyText(
                    '${_.landingPageController.user['invitationCode']}',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ).marginOnly(left: 15),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _.createDynamicLink(true);
                    },
                    child: Image.asset(
                      AppAssets.InviteButton,
                      width: 90,
                      height: 45,
                    ),
                  )
                ],
              ),
            ),
          ],
        )).marginOnly(left: 12, right: 12);
  }

  Widget sapInvite(BuildContext context, InvitationCodeScreenController _) {
    return ShortContainer(
      height: Get.height / 5.8,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height / 33,
            decoration: const BoxDecoration(
                // color: const Color(0xffFFFDFD),
                color: Color(0xffDDFFF4),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: Get.width,
              height: Get.height / 9,
              decoration: const BoxDecoration(
                  // color: const Color(0xffFFFDFD),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                  child: Column(
                children: [
                  Image.asset(
                    AppAssets.sapLogo,
                    width: 40,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${_.rewardTotal}.0 SAP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ))),
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget withdrawButton(InvitationCodeScreenController _) {
    return Container(
      width: Get.width,
      height: Get.height / 12,
      // color: Colors.red,
      child: Stack(
        children: [
          Positioned(
            top: 6,
            left: 136,
            child: Center(
              child: Container(
                width: 137,
                height: 48,
                decoration: BoxDecoration(
                    color: const Color(0xff000000),
                    border: Border.all(
                      color: Colors.black,
                      width: 1, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Positioned(
            // top: 50,
            left: 130,
            child: Container(
                width: 137,
                height: 48,
                decoration: BoxDecoration(
                    // color: const Color(0xffFFFDFD),
                    color: Color(0xffFFBB42),
                    border: Border.all(
                      color: Colors.black,
                      width: 1, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Text(
                  'WITHDRAWAL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ))),
          ),
        ],
      ),
    );
  }

  Widget inviteBox() {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Get.to(() => ViewFriendsScreen());
        },
        child: Text(
          'Invite list',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ).marginOnly(right: 15),
      ),
    );
  }

  Widget lastText() {
    return MyText(
            '*Rewards depend on downloading and checking out a travel destination *Invitation is based on download, Withdrawals start at 50 sap..')
        .marginOnly(left: 12, top: 8, right: 12);
  }
}
