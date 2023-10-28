import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../Controllers/landing/myNft_controller.dart';
import '../../Utils/utils.dart';

class MyNft extends StatelessWidget {
  const MyNft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<MyNftController>(
      init: MyNftController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
              body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AppConstants.mintConBg),
              fit: BoxFit.cover,
            )),
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 7, right: 7),
              child: _.isLoading
                  ? Loading()
                  : Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              AppConstants.myNft,
                              style: mintCongratulateTextStyle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              AppConstants.cancelBtn,
                              height: 42,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 40, left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.85,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: AppColors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              _.minitingGlobleController.assetsData.isEmpty
                                  ? Center(
                                      child: Image.asset(
                                        AppConstants.noItems,
                                        height: 150,
                                      ),
                                    )
                                  : Container(
                                      child: nftBuilder(_),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )),
        );
      },
    );
  }

  dialogBox(MyNftController _, {String? url, var id}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: AppColors.black, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 80),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppConstants.cancelBtn,
                    height: 42,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.nftTransfer,
                  style: mintCongratulateTextStyle,
                ),
              ],
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 3,
                    left: 3,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      color: AppColors.btnBgColor,
                      child: const SizedBox(
                        height: 255,
                        width: 210,
                      ),
                    ),
                  ),
                  Positioned(
                      child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          // height: 255,
                          width: 210,
                          child: Image.network(url!),
                        ),
                        const SizedBox(height: 17.5),
                        Text(
                          'COMMON',
                          style: conAlertStyle2,
                        ),
                        Text(
                          '#${BigInt.parse(id.toString()).toString()}',
                          style: conAlertStyle2,
                        ),
                        const SizedBox(height: 17.5),
                      ],
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "To:",
                    style: toStyle,
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: buildVerify(_),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              Get.back();
              // await _.transferMint();
              // await _.transferMint(id);
              // _.formKey.currentState!.validate();
              // if (_.validator) {}
              // // _.walletConnect();
              // _.validator = false;
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
              child: Image.asset(
                AppConstants.connectBtnL,
                height: 54,
              ),
            ),
          )
        ],
      ),
    );
  }

  Form buildVerify(MyNftController _) {
    return Form(
      key: _.formKey,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _.transferController,
        onChanged: (value) {
          _.formKey.currentState!.validate();
        },
        validator: (value) {
          const pattern = r'(^0x[a-fA-F0-9]{40}$)';
          _.regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Enter wallet address';
          } else if (!_.regExp.hasMatch(value)) {
            return 'Enter valid address';
          } else if (_.regExp.hasMatch(value)) {
            _.validator = true;
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderRadius: BorderRadius.circular(50),
          ),
          // hintText: 'To:',
          // hintStyle: hintTextStyle,
        ),
      ),
    );
  }

  Widget nftBuilder(MyNftController _) {
    return GridView.builder(
      itemCount: _.minitingGlobleController.assetsData.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 7.8 / 10,
      ),
      itemBuilder: (BuildContext ctx, i) {
        return GestureDetector(
          onTap: () {
            // Get.to(() => MyNft());
          },
          child: Column(
            children: [
              Container(
                height: 200,
                width: Get.width / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: _.minitingGlobleController.assetsData[i]
                            ['jsonData']['image'],
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: Get.width / 3,
                        height: 130,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "#${BigInt.parse(_.minitingGlobleController.assetsData[i]['id'].toString()).toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: 'Sora',
                          ),
                        ),
                      ).marginOnly(left: 10, right: 10),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Common",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: 'Sora',
                            color: Color(
                              0xff000000,
                            ),
                          ),
                        ).marginOnly(left: 10, right: 10),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // const Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     // dialogBox(_,
                      //     //     url: _.minitingGlobleController.assetsData[i]
                      //     //         ['jsonData']['image'],
                      //     //     id: _.minitingGlobleController.assetsData[i]
                      //     //         ['id']);
                      //   },
                      //   child: Container(
                      //     height: 25,
                      //     width: Get.width / 3,
                      //     decoration: BoxDecoration(
                      //         color: const Color(0xfffe88e4),
                      //         border: Border.all(color: Colors.black),
                      //         borderRadius: BorderRadius.circular(5)),
                      //     child: const Center(
                      //       child: Text(
                      //         "Transfer",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 14,
                      //           color: Colors.black,
                      //           fontFamily: 'Sora',
                      //         ),
                      //       ),
                      //     ),
                      //   ).marginOnly(left: 20, right: 20, bottom: 10),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ).marginAll(10),
        );
      },
    );
  }
}
