import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/landing/leadingboard_controller.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/leading_board_all.dart';

import '../../../../Utils/utils.dart';

class LeadingBoard extends StatelessWidget {
  const LeadingBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: GetBuilder<LeadingBoardController>(
        init: LeadingBoardController(),
        builder: (_) {
          return Scaffold(body: topUsersList(_));
        },
      ),
    );
  }

  Widget topUsersList(LeadingBoardController _) {
    return _.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff62c8a9),
            ),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Get.height,
              width: Get.width * 0.94,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              child: menu(_),
                            )),
                        // Inside the GestureDetector in topUsersList method of LeadingBoard widget
                        GestureDetector(
                          onTap: () => Get.to(() => LeadingBoardAll(selectedValue : _.dropdownvalue,)),
                          child: Text(
                            "View more",
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                        )

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    height: Get.height * 0.05,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        border: Border.all(color: AppColors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('#RANK'),
                        ),
                        Container(
                          child: Text('ID'),
                        ),
                        Container(
                          child: Text('SAP REWARD'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: Get.height * 0.66,
                      // width: Get.width * 0.94,
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
                                            : Text('$i').marginOnly(left: 10),
                                title: Row(
                                  children: [
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    _.ranklist[i]['avatar'].toString() == 'Null'
                                        ? Image.asset(
                                            AppConstants.profileImg.value,
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
                                      child: Text('${_.ranklist[i]['name']}'),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  // child: Text('${_.ranklist[i]['reward']}'),
                                  child: Text(_.myFormat.format(double.parse(
                                      double.parse(_.ranklist[i]['reward']
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
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget menu(LeadingBoardController _) {
// List of items in our dropdown menu
    var itemss = [
      {'id': 'all', 'name': ' All '},
      {'id': 'day', 'name': ' Last 24 Hour '},
      {'id': 'week', 'name': ' Last 7 days '},
      {'id': 'month', 'name': ' Last 30 days '},
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: itemss.map((items) {
          return DropdownMenuItem(
            value: items['id'].toString(),
            child: Text(
              items['name']!,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        value: _.dropdownvalue,
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
