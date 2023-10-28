import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/wallet/sending_coins/send_sat_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/buttons/confirm_button.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widget_trannsfer.dart';


class SendSatCoins extends StatelessWidget {
  const SendSatCoins({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SendSatCoinController>(
        init: SendSatCoinController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(

              backgroundColor: AppColor.primary,
              body: Column(
                  children:[
                    SingleChildScrollView(
                      child: Column(

                        children: [
                          const SizedBox(height: 40,),
                          const TopTransfer('SEND TO'),
                          ///////////////////////////////////////////////////////////////////////

                          Center(
                            child:
                            SizedBox
                              (
                              height: Get.height/10,
                              width: Get.width,
                              // color: Colors.red,
                              child: Image.asset(AppAssets.satLogo),
                            ),
                          ).marginOnly(left: 100,right: 100),
                          //////////////////////////////////////////////////////////////////////
                          const SizedBox(height: 23,),
                          Align(
                              alignment: Alignment.topLeft,
                              child: const MyText('To Address',fontSize: 9,fontWeight: FontWeight.w400,color: Color(0xff858585),).marginOnly(left: 15)
                          ),
                          /////////////////////////////////////////////////////////////////////
                          const SizedBox(height: 15,),
                          TextFormField(

                            controller: _.qrContentEditingController,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.white,


                              // suffixIcon:  IconButton(
                              //   icon: const Icon(Icons.qr_code_scanner),
                              //   onPressed: _.scanQR ,
                              // ).marginOnly(left: 12, right: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.text,
                          ).marginOnly(left: 12,right: 12),
                          //////////////////////////////////////////////////////////////////////
                          const SizedBox(height: 15,),
                          Align(
                              alignment: Alignment.topLeft,
                              child: const MyText('Amount',fontSize: 9,fontWeight: FontWeight.w400,color: Color(0xff858585),).marginOnly(left: 15)
                          ),
                          //////////////////////////////////////////////////////////////////////
                          const SizedBox(height: 15,),

                          TextFormField(

                            controller: _.qrContentEditingController,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.white,


                              suffixIcon:   const Padding(
                                padding: EdgeInsets.only(left: 4,top: 20),
                                child: MyText('All',    fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0EA375),),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.text,
                          ).marginOnly(left: 12,right: 12),
                          ////////////////////////////////////////////////////////////////////

                          const SizedBox(height: 10,),







                        ],
                      ),
                    ),
                    lastPart()
                  ]
              ),
            ),
          );
        }
    );
  }
}

Widget lastPart(){
  return  Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height/2.05,



        // height: MediaQuery.of(context).size.height / 1.9,

        // padding: EdgeInsets.all(12),
        decoration:const BoxDecoration(
          // color: Colors.red,

            borderRadius: BorderRadius.only( topLeft: Radius.circular(40),topRight: Radius.circular(40))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
                padding: EdgeInsets.only(left: 12),
                child: MyText('Balance: 0.00  SAP',fontSize: 9,fontWeight: FontWeight.w400,color: Color(0xff858585),)),
            const SizedBox(height: 30,),
            Container(
                height: 90 ,
                width: Get.width,
                // color: Colors.red,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,

                  text:const TextSpan(text: 'The network you have selected is ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Arbirtum .',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFF5C5C)),
                      ),
                      TextSpan(
                        text: 'Please ensure that the withdrawal adress supports the ',
                        style: TextStyle(fontWeight: FontWeight.bold, ),
                      ),
                      TextSpan(
                        text: 'Arbirtum',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFF5C5C)),
                      ),
                      TextSpan(
                        text: 'network.',
                        style: TextStyle(fontWeight: FontWeight.bold, ),
                      ),
                      TextSpan(
                        text: 'You will lose your assets',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffFF5C5C) ),
                      ),
                      TextSpan(
                        text: ' if the chosen platform does not support retrievals.',
                        style: TextStyle(fontWeight: FontWeight.bold, ),
                      ),

                    ],
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'Sora',color: Colors.black),

                  )

                  ,)

            ).marginOnly(left: 45,right: 45),
            SizedBox(height: Get.height/4.5,),


            const ConfirmButton()
          ],
        ),
      ),
    ),
  );
}