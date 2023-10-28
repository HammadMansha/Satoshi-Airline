import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/widget/common_button.dart';
import '../../../Controllers/market_place_controller.dart';
import '../../../Utils/commonSnackbar.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<MarketPlaceController>(
      init: MarketPlaceController(),
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
              initialIndex: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.black, width: 1)),
                        // padding: EdgeInsets.only(top: 100),
                        child: TabBar(
                          onTap: (index) {
                            _.indexing = index;
                            if (index == 1) {
                              if (_.landingPageController.isSound) {
                                _.playSoundEffect();
                              }
                              CommonToast.getToast(
                                'Coming Soon',
                              );
                            }
                            if (index == 2) {
                              if (_.landingPageController.isSound) {
                                _.playSoundEffect();
                              }
                              CommonToast.getToast(
                                'Coming Soon',
                              );
                            }
                            if (index == 3) {
                              if (_.landingPageController.isSound) {
                                _.playSoundEffect();
                              }
                              CommonToast.getToast(
                                'Coming Soon',
                              );
                            }
                            _.update();
                            // print("INDEX: $indexing");
                          },
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
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            // padding: EdgeInsets.only(top:150),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: bodyPages(_)[_.indexing]

                            // child: Container(
                            //   child: Image.asset(AppConstants.noItems))
                            )
                        .marginOnly(left: 10, right: 10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget planeTab(MarketPlaceController _) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Get.height / 30,
              width: Get.width / 4,
              // width: Get.width/4,
              // padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _.dropdownValue,
                  icon: Icon(Icons.expand_more_outlined, color: Colors.black),
                  style: TextStyle(color: Colors.black),
                  onChanged: (newValue) {
                    _.dropdownValue = newValue!;
                    _.update();
                  },
                  items: <String>[
                    'Lowest price',
                    'Highest price',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: nextAviStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            Container(
              width: 150,
              height: 30,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _.segmentedControlValue = 0;
                      _.update();
                    },
                    child: buildOption("Buy", 0, _),
                  ),
                  GestureDetector(
                    onTap: () {
                      _.segmentedControlValue = 1;
                      _.update();
                    },
                    child: buildOption("Rent", 1, _),
                  ),
                ],
              ),
            ),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Filter ( 0 )",
                  style: nextAviStyle,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.filter_alt,
                    color: AppColors.darkGrey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Expanded(
          child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, i) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(children: [
                Card(
                  color: i == 0
                      ? const Color(0xffddfff4)
                      : i == 1
                          ? const Color(0xffffbbc0)
                          : i == 2
                              ? const Color(0xfffffbd8)
                              : const Color(0xffc5baf1),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black, width: 1),
                            image: const DecorationImage(
                              image: AssetImage(AppConstants.mintedNftImg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: double.infinity,
                          height: Get.height / 6,
                        ),
                      ),
                      Text(
                        i == 0
                            ? 'COMMON'.toUpperCase()
                            : i == 1
                                ? 'UFO'.toUpperCase()
                                : i == 2
                                    ? 'EPIC'.toUpperCase()
                                    : 'UNCOMMON'.toUpperCase(),
                        style: GoogleFonts.sora(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ).marginSymmetric(vertical: 10),
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '89 ARB',
                                // style: foooterTitleStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonButton(
                  text: "Buy",
                  onPressed: () {},
                  color: const Color(0xffFFBB42),
                  width: 130,
                  height: 35,
                ).marginOnly(top: 5),
              ]),
            );
          },
        ),
      ))
      // GestureDetector(
      //   onTap: () {
      //     Get.to(() => const TabView());
      //   },
      //   child: SizedBox(
      //       // height: MediaQuery.of(context).size.height*0.3,

      //       width: 130,
      //       // MediaQuery.of(context).size.width * 0.3,

      //       child: Image.asset(AppConstants.levelOneNft)),
      // )
    ],
  );
}

Widget buildOption(String text, int index, MarketPlaceController _) {
  bool isSelected = _.segmentedControlValue == index;
  return Container(
    padding: const EdgeInsets.all(0),
    width: 74,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isSelected ? const Color(0xffDDFFF4) : Colors.white,
      border: Border.all(
        color: isSelected ? Colors.black : Colors.transparent,
        width: 1,
      ),
    ),
    child: Center(
      child: Text(text, style: nextAviStyle),
    ),
  );
}

List<Widget> bodyPages(MarketPlaceController _) {
  return <Widget>[
    planeTab(_),
    Container(),
    Container(),
    Container(),
  ];
}
