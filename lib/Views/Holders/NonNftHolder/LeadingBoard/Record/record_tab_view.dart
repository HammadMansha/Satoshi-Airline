import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/Record/view_all_record.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../Controllers/landing/recordtab_controller.dart';
import '../../../../../Model/chart_model.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../shimmer/map_effect.dart';

class RecordTabView extends StatelessWidget {
  const RecordTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<RecordTabController>(
      init: RecordTabController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: DefaultTabController(
              length: _.myTabs.length,
              initialIndex: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black, width: 1)),
                      // padding: EdgeInsets.only(top: 100),
                      child: TabBar(
                        onTap: (index) async {
                          _.indexing = index;

                          _.filter = index == 0
                              ? 'day'
                              : index == 1
                                  ? 'week'
                                  : index == 2
                                      ? 'month'
                                      : 'year';
                          _.update();
                          _.isLoading = true;
                          _.dataList.clear();
                          _.dataMap.clear();
                          _.update();
                          await _.getGraphData();
                          _.isLoading = false;
                          _.update();
                        },
                        labelColor: AppColors.black,
                        unselectedLabelColor: AppColors.black,
                        indicator: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          color: const Color(0xff62C8A9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: _.myTabs,
                      ),
                    ),
                  ),
                  Expanded(child: bodyPages(_)[_.indexing])
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> bodyPages(RecordTabController _) {
    return <Widget>[
      graphWidget(_),
      graphWidget(_),
      graphWidget(_),
      graphWidget(_),
      // const Day(),
      // const Week(),
      // const Month(),
      // const Year(),
    ];
  }

  Widget graphWidget(RecordTabController _) {
    return SizedBox(
      height: Get.height / 2,
      child: _.isLoading
          ? MapShimmer()
          : _.dataList.isEmpty
              ? Center(
                  child: Text(
                    "Travel history not found",
                    style: GoogleFonts.sora(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TOTAL",
                                style: GoogleFonts.sora(
                                    fontSize: 13, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: _.dataMap['totalDistance'] == null
                                      ? '0'
                                      : _.myFormat.format(
                                          double.parse(
                                            double.parse(_
                                                    .dataMap['totalDistance']
                                                    .toString())
                                                .toStringAsFixed(2),
                                          ),
                                        ),
                                  // double.parse(_.landingPageController
                                  //         .balanceData['distance']
                                  //         .toString())
                                  //     .toStringAsFixed(2),
                                  style: GoogleFonts.sora(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' KM',
                                      style: GoogleFonts.sora(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "REDEEM",
                                style: GoogleFonts.sora(
                                    fontSize: 13, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      "${_.dataMap['totalRedeemSAP'].toStringAsFixed(2)} SAP",
                                  style: GoogleFonts.sora(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ).marginOnly(top: 20, left: 10, right: 10),
                      const SizedBox(
                        height: 20,
                      ),
                      _.filter == 'week'
                          ? _.dataMap['result'][0] == null
                              ? Text('')
                              : Text(
                                  "${_.dataMap['result'][0]['start']} - ${_.dataMap['result'][0]['end']}",
                                  style: GoogleFonts.sora(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )
                          : Text(
                              "${_.dataMap['result']}",
                              style: GoogleFonts.sora(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildDefaultColumnChart(_),
                      Row(
                        children: [
                          Row(children: [
                            Text(
                              "History",
                              style: GoogleFonts.sora(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.viewAllRecordRoutes,
                                    arguments: {
                                      "historyList": _.dataMap['collection']
                                    });
                                // Get.to(() => ViewAllRecord(), arguments: {
                                //   "historyList": _.dataMap['collection']
                                // });
                              },
                              child: Text(
                                "View All",
                                style: GoogleFonts.sora(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ).marginOnly(left: 225),
                            )
                          ]),
                          const Spacer(),
                        ],
                      ).marginOnly(left: 10, right: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).marginOnly(left: 25),
                          Text('Reward',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .marginOnly(left: 27,right: 10),
                          Text('City',
                                  style: TextStyle(fontWeight: FontWeight.bold)).marginOnly(right: 40),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      historyRow(_.dataMap['collection'], _),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ).marginOnly(left: 10, right: 10),
                ),
    );
  }

  Widget historyRow(List h, RecordTabController _) {
    List<Widget> c = [];
    for (int i = 0; i < h.length; i++) {
      c.add(
        Row(
          children: [
            Text(
              "${_.returnDate(h[i]['date'])}",
              style:
                  GoogleFonts.sora(fontWeight: FontWeight.w300, fontSize: 10),
            ),
            const Spacer(),
            Text(
              "${double.parse(h[i]['sap_reward']['\u0024numberDecimal'].toString()).toStringAsFixed(2)} SAP",
              style:
                  GoogleFonts.sora(fontWeight: FontWeight.w300, fontSize: 10),
            ).marginOnly(right: 20),
            const Spacer(),
            SizedBox(
              width: Get.width / 5,
              child: Text(
                "${h[i]['travel_from']}/${h[i]['travel_to']}",
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style:
                    GoogleFonts.sora(fontWeight: FontWeight.w300, fontSize: 10),
              ).marginOnly(left: 5)
            )
          ],
        ).marginOnly(bottom: 10),
      );
    }
    return Column(
      children: c,
    );
  }

  /// Get default column chart
  SfCartesianChart buildDefaultColumnChart(RecordTabController _) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: ''),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: getDefaultColumnSeries(_),
      // tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries(
      RecordTabController _) {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: _.dataList,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        color: const Color(0xff62C8A9),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
