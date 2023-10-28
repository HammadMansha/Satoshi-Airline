import 'package:flutter/material.dart';

import '../../Utils/utils.dart';

class InvitationStatus extends StatefulWidget {
  const InvitationStatus({Key? key}) : super(key: key);

  @override
  State<InvitationStatus> createState() => _InvitationStatusState();
}

class _InvitationStatusState extends State<InvitationStatus> {
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
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
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
                      child: Text(AppConstants.invStatusTitle, style: invStatusTitleStyle,),
                    )
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 20,
                // right: 40,
                child: Transform(
                  transform: Matrix4.identity(),
                  // ..setEntry(3, 2, 0.001)
                  // ..rotateX(0.5),
                  child:  Image.asset(AppConstants.backBtn.value, height: 42)
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 150, left: 10, right: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                              // color: Color(0xff000000),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                              color: Color(0xffCDFCEA),

                            ),
                            height: 27,
                            child: Center(
                              child: Text(AppConstants.totInvStatusTitle, style: invStatusTitleStyle,),
                            )
                          ),
                          Container(
                              child: Center(
                                child: Text('0', style: invStatusTitleStyle,),
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 23,),
                    Container(
                        child: Text(AppConstants.lengthOfInv, style: lengthInvStyle),
                    ),
                    SizedBox(height: 7),
                    Container(
                      // height: 300,
                      height: MediaQuery.of(context).size.height*0.37,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black)
                        ),
                      child: Container(
                        padding: EdgeInsets.only(top: 35, left: 67, right: 67),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [Image.asset(AppConstants.nextInvImg, height: 56,),],
                                ),
                                Column(
                                  children: [
                                    Text(AppConstants.invDurations, style: invDurationsStyle),
                                    Text(AppConstants.nextInv, style: lengthInvStyle),
                                    Container(
                                        padding:EdgeInsets.only(top: 8),
                                        child: Text('27.03.2023  9:00:00        ', style: nextAviStyle)),
                                  ],
                                ),


                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding:EdgeInsets.only(top: 10),
                                    child: Text(AppConstants.friendInvited, style: invitedFriendStyle)),
                              Container(
                                    padding:EdgeInsets.only(top: 10, left: 4),
                                    child: Text('0/20', style: lengthInvStyle)),

                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 20,
                              // padding:EdgeInsets.only(top: 10, left: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                // color: Color(0xff000000),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xffCFCFCF),),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // height: 70,
                                height: MediaQuery.of(context).size.height*0.08,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.24,
                                      child: const Text('YWL4EC5', textAlign:TextAlign.center, style: TextStyle(color: AppColors.black, fontSize: 12, fontWeight: FontWeight.w400),)
                                    ),
                                    Container(child: Image.asset(AppConstants.inviteBtn, height: 42,)),

                                  ],
                                )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                // width: MediaQuery.of(context).size.width*0.24,
                                child: const Text('SAP INVITATION REWARD COMPLETE!', textAlign:TextAlign.center, style: TextStyle(color: AppColors.black, fontSize: 11, fontWeight: FontWeight.w600),)
                            ),
                          ],
                        ),
                      )

                    ),
                    const SizedBox(height: 24,),

                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              // color: Color(0xff000000),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                                color: Color(0xffCDFCEA),

                              ),
                              height: 27,

                          ),
                          const SizedBox(height: 13,),
                          Container(
                              child: Image.asset(AppConstants.sapIcon, height: 48,)
                          ),
                          const SizedBox(height: 7,),
                          Container(
                              child: Text("0.00 ${AppConstants.sapTxt}", style: inviteEarnedSap,)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),

                    Row(
                     children: [
                       Text("INVITATION LIST", style: inviteEarnedSap2,)
                     ],
                   ),
                    const SizedBox(height: 7,),
                    Container(
                        child: Text("TIP : The invitation is recognized only when the invited friend complete the first mining.", style: tipStyle,)
                    ),
                  ],
                ),
              )

            ],
          ),
        )
      ),
    );
  }
}
