import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/assetsScreen_controller.dart';
import 'package:satoshi/Views/Holders/HolderCommon/tab_view.dart';
import '../../../AppCommons/balance_top_bar.dart';
import '../../../Utils/utils.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<AssetsScreenController>(
      init: AssetsScreenController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: DefaultTabController(
              length: _.myTabs.length,
              initialIndex: 0,
              child: Column(
                children: [
                  BalanceTopBar(
                      _.assetImage.isEmpty ? AppConstants.profileImg : _.assetImage),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black, width: 1)),
                      // padding: EdgeInsets.only(top: 100),
                      child: TabBar(
                        labelColor: AppColors.white,
                        unselectedLabelColor: AppColors.black,
                        indicator: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          color: const Color(0xff62C8A9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // controller: _.tabController,
                        tabs: _.myTabs,
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.94,
                      // padding: EdgeInsets.only(top:150),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const TabView());
                                },
                                child: SizedBox(
                                    // height: MediaQuery.of(context).size.height*0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Image.asset(AppConstants.levelOneNft)),
                              )
                            ],
                          ),
                        ),
                      )
                      // child: Container(
                      //   child: Image.asset(AppConstants.noItems))
                      )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
