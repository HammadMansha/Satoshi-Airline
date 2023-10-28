import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';

class FlyRecord extends StatefulWidget {
  const FlyRecord({Key? key}) : super(key: key);

  @override
  State<FlyRecord> createState() => _FlyRecordState();
}

class _FlyRecordState extends State<FlyRecord> {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        body: Container(
          height: 300,
          decoration: BoxDecoration(
            color: const Color(0xffCDFCEA),
            border: Border.all(color: AppColors.black,width: 1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Stack(
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
                        child: Text(AppConstants.flyingRecord, style: invStatusTitleStyle,),
                      )
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 110, top: 150),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text('0', style: congratulateTextStyle,),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 8, left: 3),
                                  child: Text('km', style: dstStyle,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3,),
                            Container(
                              child: Text('Total km', style: dstStyle,),
                            ),
                          ],
                        )
                      ),
                      SizedBox(height: 20,),
                      Container(
                        // padding: EdgeInsets.only(left: 20, right: 20, top: 200),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text('0', style: congratulateTextStyle,),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 8, left: 3),
                                          child: Text('km', style: dstStyle,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3,),
                                    Container(
                                      child: Text('Total km', style: dstStyle,),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 56,),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text('0', style: congratulateTextStyle,),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 8, left: 3),
                                          child: Text('km', style: dstStyle,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3,),
                                    Container(
                                      child: Text('Total km', style: dstStyle,),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 140, left: 50),
                        child: Image.asset(AppConstants.silver, height: 128,),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
