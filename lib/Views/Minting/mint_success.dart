import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/landing/mintsuccess_controller.dart';
import '../../Utils/utils.dart';

class MintSuccess extends StatelessWidget {
  const MintSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<MintSuccessController>(
      init: MintSuccessController(),
      builder: (_){
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppConstants.mintConBg),
                      fit: BoxFit.cover,
                    )
                ),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: AppColors.black)
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20, right: 20),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: Image.asset(AppConstants.cancelBtn, height: 48,))),
                            ),
                            Container(
                              child: Text(AppConstants.congratulateText, style:  mintCongratulateTextStyle,),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              child: Text('You got a plane NFT card !', style:  priceTxtTitStyle,),
                            ),
                            const SizedBox(height: 14,),
                            Container(
                                child: Image.asset(AppConstants.nftFrame, height: 317,)
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        );
      },
    );
  }
}


// class MintSuccess extends StatefulWidget {
//   const MintSuccess({Key? key}) : super(key: key);
//
//   @override
//   State<MintSuccess> createState() => _MintSuccessState();
// }
//
// class _MintSuccessState extends State<MintSuccess> {
//   MyNftController  myNftController = MyNftController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AppConstants.mintConBg),
//             fit: BoxFit.cover,
//           )
//         ),
//         child: Container(
//           // width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height*0.6,
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(width: 1, color: AppColors.black)
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(top: 20, right: 20),
//                       child: Align(
//                           alignment: Alignment.topRight,
//                           child: GestureDetector(
//                               onTap: (){Navigator.pop(context);},
//                               child: Image.asset(AppConstants.cancelBtn, height: 48,))),
//                     ),
//                     Container(
//                       child: Text(AppConstants.congratulateText, style:  mintCongratulateTextStyle,),
//                     ),
//                     const SizedBox(height: 5,),
//                     Container(
//                       child: Text('You got a plane NFT card !', style:  priceTxtTitStyle,),
//                     ),
//                     const SizedBox(height: 14,),
//                     Container(
//                       child: Image.asset(AppConstants.nftFrame, height: 317,)
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }
