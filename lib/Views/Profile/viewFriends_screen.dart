import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/invite/viewfriends_controller.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/widget/appbar/commonAppbar.dart';
import 'package:satoshi/widget/wallet_widgets/containers/short_containor.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';

class ViewFriendsScreen extends StatelessWidget {
  const ViewFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ViewFreindsController>(
      init: ViewFreindsController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                child: CommonAppbar(
                  isNetwork: _.landingPageController.assetImage.value.isEmpty
                      ? false.obs
                      : true.obs,
                  isDialog: true,
                  imagePath: _.landingPageController.assetImage.value.isEmpty
                      ? AppAssets.backButton.obs
                      : _.landingPageController.assetImage.value.obs,
                  isTextOnly: true,
                  body: 'INVITATION LIST',
                  travel:
                      _.landingPageController.balanceData['distance'] == null
                          ? '0'
                          : _.landingPageController.balanceData['distance']
                              .toString(),
                ),
              ),
            ),
            body: Column(
              children: [
                totalInvitation(context, _),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Color(0xffDDFFF4),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: Get.width / 1,
                                  child: MyText(
                                    'ID',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ).marginOnly(left: 15),
                              ),
                              const Spacer(),
                              Flexible(
                                child: MyText(
                                  'CHECKOUT',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: Get.width / 6,
                                child: MyText(
                                  'SAP Reward',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ).marginOnly(top: 10, bottom: 10, left: 5, right: 5),
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _.friendsList.length,
                            separatorBuilder: (c, i) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (c, i) {
                              return Row(
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: Get.width / 1,
                                      child: MyText(
                                        '${_.friendsList[i]['name']}',
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ).marginOnly(left: 12),
                                  ),
                                  const Spacer(),
                                  MyText(
                                    '${_.returnWeekDaysFormat(_.friendsList[i]['checkout'])}',
                                    fontSize: 8,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    child: SizedBox(
                                      width: Get.width / 9,
                                      child: MyText(
                                        '${_.friendsList[i]['sapReward']}.0 SAP',
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ).marginOnly(
                                  top: 10, bottom: 10, left: 5, right: 5);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ).marginOnly(left: 20, right: 20),
          ),
        );
      },
    );
  }

  Widget totalInvitation(BuildContext context, ViewFreindsController _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => ViewFriendsScreen());
          },
          child: ShortContainer(
            height: Get.height / 15,
            width: Get.width / 2.4,
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
          ),
        ),
        const Spacer(),
        ShortContainer(
          height: Get.height / 15,
          width: Get.width / 2.4,
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
        ),
      ],
    );
  }
}
