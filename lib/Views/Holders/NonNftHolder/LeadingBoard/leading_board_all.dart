import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/leadingBoardAll_controller.dart';

import '../../../../Utils/utils.dart';
import '../../../../widget/appbar/commonAppbar.dart';

class LeadingBoardAll extends StatelessWidget {
  final String selectedValue;
  LeadingBoardAll({
    super.key,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<LeadingBoardAllController>(
      init: LeadingBoardAllController(dropdownvalue: selectedValue),
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
                        bnb: 0,
                        isDialog: true,
                        travel: '0',
                      )
                    : CommonAppbar(
                        isNetwork: false.obs,
                        isDialog: true,
                        imagePath: AppConstants.backBtn,
                        totalsap: _.landingPageController
                                    .balanceData['totalSap'] ==
                                null
                            ? ''
                            : _.landingPageController.balanceData['totalSap']
                                .toString(),
                        bnb:
                            _.landingPageController.balanceData['bnbBalance'] ==
                                    null
                                ? 0.0
                                : double.parse(_.landingPageController
                                    .balanceData['bnbBalance']
                                    .toString()),
                        travel:
                            _.landingPageController.balanceData['distance'] ==
                                    null
                                ? '0'
                                : double.parse(_.landingPageController
                                        .balanceData['distance']
                                        .toString())
                                    .round()
                                    .toString(),
                      ),
              ),
            ),
            body: topUsersList(context, _),
          ),
        );
      },
    );
  }

  Widget topUsersList(BuildContext context, LeadingBoardAllController _) {
    return _.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff62c8a9),
            ),
          )
        : Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.94,
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text('Top 100'),
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.94,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 130,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.black, //color of border
                                width: 1, //width of border
                              ),
                            ),
                            child: Center(
                              child: menu(_, selectedValue),
                            )),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('#RANK'),
                              Text('ID'),
                              Text('SAP REWARD'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: _.ranklist.length,
                                itemBuilder: (c, i) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: _.ranklist[i]['rank'] == 1
                                            ? Image.asset(
                                                AppConstants.first,
                                                height: 43,
                                              )
                                            : _.ranklist[i]['rank'] == 2
                                                ? Image.asset(
                                                    AppConstants.second,
                                                    height: 32,
                                                  )
                                                : _.ranklist[i]['rank'] == 3
                                                    ? Image.asset(
                                                        AppConstants.third,
                                                        height: 32,
                                                      )
                                                    : Text('$i')
                                                        .marginOnly(left: 10),
                                        title: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            _.ranklist[i]['avatar']
                                                        .toString() ==
                                                    'Null'
                                                ? Image.asset(
                                                    AppConstants
                                                        .profileImg.value,
                                                    height: 30,
                                                    width: 30,
                                                  )
                                                : Image.network(
                                                    _.ranklist[i]['avatar'],
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: Get.width / 3,
                                              child: Text(
                                                  '${_.ranklist[i]['name']}'),
                                            ),
                                          ],
                                        ),
                                        trailing: Container(
                                          // child: Text('${_.ranklist[i]['reward']}'),
                                          child: Text(_.myFormat.format(
                                              double.parse(double.parse(_
                                                      .ranklist[i]['reward']
                                                      .toString())
                                                  .toStringAsFixed(2)))),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        endIndent: 10,
                                        indent: 10,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget menu(LeadingBoardAllController _, String selectedMenu) {
    var items = [
      {'id': 'all', 'name': ' All '},
      {'id': 'day', 'name': ' Last 24 Hour '},
      {'id': 'week', 'name': ' Last 7 days '},
      {'id': 'month', 'name': ' Last 30 days '},
    ];

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: items.map((items) {
          return DropdownMenuItem(
            value: items['id'].toString(),
            child: Text(
              items['name']!,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        value: selectedValue, // Set the default value here
        onChanged: (String? newValue) {
          _.dropdownvalue = newValue!;
          _.update();
          _.getRecord();
        },
        icon: Icon(Icons.arrow_drop_down_outlined),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: AppColors.black),
        underline: Container(
          height: 2,
          color: AppColors.black,
        ),
      ),
    );
  }
}
