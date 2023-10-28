import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/leadingtabview_controller.dart';
// import '../../../../Utils/commonSnackbar.dart';
import '../../../../Utils/utils.dart';
import '../../../../widget/appbar/commonAppbar.dart';
import 'Record/record_tab_view.dart';
import 'leading_board.dart';

class LeadingTabView extends StatelessWidget {
  const LeadingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<LeadingTabViewController>(
      init: LeadingTabViewController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                child: _.landingPageController.internetConnection
                    ? CommonAppbar(
                        isNetwork: false.obs,
                        imagePath: AppConstants.profileImg,
                        totalsap: '0',
                        bnb: 0.00,
                        travel: '0',
                      )
                    : CommonAppbar(
                        isNetwork:
                            _.landingPageController.assetImage.value.isEmpty
                                ? false.obs
                                : true.obs,
                        imagePath:
                            _.landingPageController.assetImage.value.isEmpty
                                ? AppConstants.profileImg
                                : _.landingPageController.assetImage.value.obs,
                        totalsap: _.landingPageController.tokenBalance == null
                            ? '0.00'
                            : _.landingPageController.tokenBalance
                                .toStringAsFixed(2),
                        bnb: _.landingPageController.balanceInBNB == null
                            ? 0.0
                            : double.parse(_.landingPageController.balanceInBNB
                                .toString()),
                        travel: _.landingPageController
                                    .balanceData['distance'] ==
                                null
                            ? '0'
                            : _.landingPageController.balanceData['distance']
                                .toString(),
                      ),
              ),
            ),
            body: DefaultTabController(
              length: _.myTabs.length,
              initialIndex: 1,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black, width: 1)),
                      // padding: EdgeInsets.only(top: 100),
                      child: TabBar(
                        onTap: (index) {
                          if (index == 0) {
                            _.indexing = index;
                            _.update();
                            print("INDEX: ${_.indexing}");
                            // if (_.landingPageController.isSound) {
                            //   _.landingPageController.playSoundEffect();
                            // }
                            // CommonToast.getToast(
                            //   'Coming Soon',
                            // );
                          } else {
                            _.indexing = index;
                            _.update();
                            print("INDEX: ${_.indexing}");
                          }
                        },
                        labelColor: AppColors.black,
                        unselectedLabelColor: AppColors.black,
                        indicator: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          color: const Color(0xff62C8A9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // controller: _tabController,
                        tabs: _.myTabs,
                      ),
                    ),
                  ),
                  Expanded(child: bodyPages()[_.indexing])
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> bodyPages() {
    return <Widget>[
      const LeadingBoard(),
      const RecordTabView(),
    ];
  }
}
