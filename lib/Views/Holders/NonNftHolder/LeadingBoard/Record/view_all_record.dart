import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Controllers/view_all_record_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_constants.dart';
import '../../../../../widget/appbar/commonAppbar.dart';

class ViewAllRecord extends StatelessWidget {
  const ViewAllRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ViewAllRecordController>(
      init: ViewAllRecordController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                child: CommonAppbar(
                  isNetwork: false.obs,
                  isDialog: true,
                  imagePath: AppConstants.backBtn,
                  totalsap:
                      _.landingPageController.balanceData['totalSap'] == null
                          ? ''
                          : _.landingPageController.balanceData['totalSap']
                              .toString(),
                  bnb: _.landingPageController.balanceData['bnbBalance'] == null
                      ? 0.0
                      : double.parse(_
                          .landingPageController.balanceData['bnbBalance']
                          .toString()),
                  travel:
                      _.landingPageController.balanceData['distance'] == null
                          ? '0'
                          : double.parse(_
                                  .landingPageController.balanceData['distance']
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

  Widget topUsersList(BuildContext context, ViewAllRecordController _) {
    return _.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff62c8a9),
            ),
          )
        : SingleChildScrollView(
            child: Column(
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
                      child: Text('Travel History',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    )),
                Align(
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
                            children: [
                              Text('Date').marginOnly(left: 25),
                              Text('Reward').marginOnly(left: 16),
                              Text('City').marginOnly(right: 30),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.72,
                            width: MediaQuery.of(context).size.width * 0.94,

                            // padding: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: _.historyList.length,
                                itemBuilder: (c, i) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${_.returnDate(_.historyList[i]['date'])}",
                                            style: GoogleFonts.sora(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${double.parse(_.historyList[i]['sap_reward']['\u0024numberDecimal'].toString()).toStringAsFixed(2)} SAP",
                                            style: GoogleFonts.sora(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10),
                                          ).marginOnly(right: 15),
                                          const Spacer(),
                                          SizedBox(
                                              width: Get.width / 5,
                                              child: Text(
                                                "${_.historyList[i]['travel_from']}/ ${_.historyList[i]['travel_to']}",
                                                // maxLines: 1,
                                                // overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.sora(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10),
                                              ).marginOnly(left: 8))
                                        ],
                                      ).marginOnly(bottom: 10),
                                      Divider(
                                        thickness: 1,
                                        endIndent: 10,
                                        indent: 10,
                                      )
                                    ],
                                  ).marginOnly(left: 10, right: 5);
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget menu(ViewAllRecordController _) {
// List of items in our dropdown menu
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
        value: _.dropdownvalue,
        onChanged: (String? newValue) {
          _.dropdownvalue = newValue!;
          _.update();
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

// class LeadingBoardAll extends StatefulWidget {
//   const LeadingBoardAll({Key? key}) : super(key: key);

//   @override
//   State<LeadingBoardAll> createState() => _LeadingBoardAllState();
// }

// class _LeadingBoardAllState extends State<LeadingBoardAll> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: topUsersList());
//   }

//   var assetImage;
//   getUserInfo() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       assetImage = pref.getString('assetImage');
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserInfo();
//   }

//   Widget topUsersList() {
//     return Column(
//       children: [
//         BalanceTopBar(
//             assetImage == null ? AppConstants.profileImg : assetImage),
//         Container(
//             padding: const EdgeInsets.only(right: 10, left: 10),
//             height: MediaQuery.of(context).size.height * 0.05,
//             width: MediaQuery.of(context).size.width * 0.94,
//             decoration: BoxDecoration(
//                 color: const Color(0xffF2F2F2),
//                 border: Border.all(color: AppColors.black),
//                 borderRadius: BorderRadius.circular(10)),
//             child: const Center(
//               child: Text('Top 100'),
//             )),
//         Expanded(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width * 0.94,
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.black),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.only(right: 10, left: 10),
//                     height: MediaQuery.of(context).size.height * 0.05,
//                     decoration: BoxDecoration(
//                         color: const Color(0xffF2F2F2),
//                         border: Border.all(color: AppColors.black),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           child: const Text('#RANK'),
//                         ),
//                         Container(
//                           child: const Text('USER'),
//                         ),
//                         Container(
//                           child: const Text('SAP REWARD'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.72,
//                     width: MediaQuery.of(context).size.width * 0.94,

//                     // padding: EdgeInsets.only(left: 10,right: 10),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.black),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: ListView.builder(
//                         padding: EdgeInsets.zero,
//                         itemCount: 20,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             // padding: EdgeInsets.only(left: 10, right: 10),
//                             child: userList(index + 1),
//                           );
//                         }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget userList(indexOf) {
//     return Column(
//       children: [
//         ListTile(
//           leading: indexOf == 1
//               ? Image.asset(
//                   AppConstants.first,
//                   height: 43,
//                 )
//               : indexOf == 2
//                   ? Image.asset(
//                       AppConstants.second,
//                       height: 32,
//                     )
//                   : indexOf == 3
//                       ? Image.asset(
//                           AppConstants.third,
//                           height: 32,
//                         )
//                       : Text('$indexOf'),
//           title: Row(
//             children: [
//               const SizedBox(
//                 width: 30,
//               ),
//               Image.asset(
//                 AppConstants.profileDel,
//                 height: 32,
//               ),
//               Container(
//                 child: const Text(' Natalie'),
//               ),
//             ],
//           ),
//           trailing: Container(
//             child: const Text('3000'),
//           ),
//         ),
//         const Divider(
//           thickness: 1,
//           endIndent: 10,
//           indent: 10,
//         )
//       ],
//     );
//     //   Row(
//     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //   children: [
//     //     Container(
//     //       padding: EdgeInsets.only(top: 10),
//     //       child: Text('${indexOf+1}'),
//     //     ),
//     //     Row(
//     //       children: [
//     //         Image.asset(AppConstants.profileDel,height: 32,),
//     //         Container(
//     //           child: Text('Natalie'),
//     //         ),
//     //         ],
//     //     ),
//     //     Container(
//     //       child: Text('3000'),
//     //     ),
//     //   ],
//     // );
//   }
// }
