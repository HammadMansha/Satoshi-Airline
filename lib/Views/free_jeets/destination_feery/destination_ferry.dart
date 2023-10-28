import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../Model/suggestionairport.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/autocomplete/autocomplete_widget.dart';
import '../../../widget/autocomplete/model/prediction.dart';
import '../total_minting_ferry/total_minting_ferry.dart';
import 'destination_ferry_controlle.dart';

class DestinationFerry extends StatelessWidget {
  const DestinationFerry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<DestinationFerryController>(
      init: DestinationFerryController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                child: CommonAppbar(
                  isNetwork: _.landingPageController.assetImage.value.isEmpty
                      ? false.obs
                      : true.obs,
                  imagePath: _.landingPageController.assetImage.value.isEmpty
                      ? AppConstants.profileImg
                      : _.landingPageController.assetImage.value.obs,
                  isTextOnly: true,
                  body: 'Where are you going ?',
                  travel:
                      _.landingPageController.balanceData['distance'] == null
                          ? '0'
                          : _.landingPageController.balanceData['distance']
                              .toString(),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: GooglePlaceAutoCompleteTextField(
                                      textEditingController: _.from.value,
                                      googleAPIKey: _.apikey,
                                      readOnly: false,

                                      inputDecoration: InputDecoration(
                                        // enabled: false,

                                        // enabled: false,
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Transform.rotate(
                                          angle: 45 * 3.14 / 180,
                                          child: const Icon(
                                            Icons.airplanemode_active,
                                            color: Colors.black,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _.fromCountry = '';
                                            _.from.value.clear();
                                            _.update();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: AppColors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: 'From:',
                                        hintStyle: hintTextStyle,
                                      ),
                                      debounceTime: 800,
                                      // countries: ["in", "fr"],
                                      isLatLngRequired: true,
                                      getPlaceDetailWithLatLng:
                                          (Prediction prediction) async {
                                        _.googleMapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            new CameraPosition(
                                              target: LatLng(
                                                  double.parse(prediction.lat!),
                                                  double.parse(
                                                      prediction.lng!)),
                                              zoom: 13.0,
                                            ),
                                          ),
                                        );
                                        _.update();
                                        _.latfrom =
                                            double.parse(prediction.lat!);
                                        _.longfrom =
                                            double.parse(prediction.lng!);
                                        _.getAddressFrom(
                                          double.parse(prediction.lat!),
                                          double.parse(prediction.lng!),
                                        );
                                        final Uint8List markerIcon =
                                            await _.getBytesFromAsset(
                                                AppConstants.airplane, 100);
                                        _.addMarker(
                                            LatLng(
                                                double.parse(prediction.lat!),
                                                double.parse(prediction.lng!)),
                                            "1",
                                            BitmapDescriptor.fromBytes(
                                                markerIcon));
                                        List<LatLng> listofPloylines = [
                                          LatLng(_.latfrom, _.longfrom),
                                          LatLng(_.latto, _.longto),
                                        ];
                                        _.addPolyLine(listofPloylines);
                                        _.update();
                                        if (_.distance(_.latfrom, _.longfrom,
                                                _.livelat, _.livelong) >=
                                            2) {
                                          CommonToast.getToast(
                                            "Airport out of range",
                                          );
                                        }
                                      },
                                      itmClick: (Prediction prediction) {
                                        _.from.value.text =
                                            prediction.description!;
                                        print(
                                            "check prediction ${prediction.structuredFormatting!.mainText!.split(',').first}");
                                        // _.fromCountry = a[i].countryCode!;

                                        print("check code ${_.fromCountry}");
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: GooglePlaceAutoCompleteTextField(
                                      textEditingController: _.to.value,

                                      googleAPIKey: _.apikey,
                                      inputDecoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _.toCountry = '';
                                            _.to.value.clear();
                                            _.update();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.location_pin,
                                          color: Colors.black,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: AppColors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: 'Where To:',
                                        hintStyle: hintTextStyle,
                                      ),
                                      debounceTime: 800,
                                      // countries: ["in", "fr"],
                                      isLatLngRequired: true,
                                      getPlaceDetailWithLatLng:
                                          (Prediction prediction) async {
                                        print("placeDetails" +
                                            prediction.lng.toString());
                                        print("placeDetails" +
                                            prediction.lat.toString());
                                        _.latto = double.parse(prediction.lat!);
                                        _.longto =
                                            double.parse(prediction.lng!);
                                        _.getAddressFrom(
                                            double.parse(prediction.lat!),
                                            double.parse(prediction.lng!),
                                            isTo: true);
                                        final Uint8List markerIcon =
                                            await _.getBytesFromAsset(
                                                AppConstants.pin, 100);
                                        _.addMarker(
                                            LatLng(
                                                double.parse(prediction.lat!),
                                                double.parse(prediction.lng!)),
                                            "2",
                                            BitmapDescriptor.fromBytes(
                                                markerIcon));
                                        List<LatLng> listofPloylines = [
                                          LatLng(_.latfrom, _.longfrom),
                                          LatLng(_.latto, _.longto),
                                        ];
                                        _.addPolyLine(listofPloylines);
                                        _.update();
                                      },
                                      itmClick: (Prediction prediction) {
                                        print(
                                            "check prediction to ${prediction.structuredFormatting!.secondaryText}");
                                        _.to.value.text =
                                            prediction.description!;
                                        // _.fromCountry = a[i].countryCode!;
                                        _.update();
                                        print("check Code ${_.toCountry}");
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      addLocationDialogueBox();
                                    },
                                    child: Image.asset(AppAssets.addLocation),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    AppAssets.calenderLogo,
                                    width: 30,
                                  ),
                                  MyText(
                                    'DEPARTURE',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  MyText(
                                    '7/12/12',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ).marginOnly(left: 40),
                              Image.asset(
                                AppConstants.departureIconFerry,
                                width: 121,
                                height: 53,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    AppAssets.calenderLogo,
                                    width: 30,
                                  ),
                                  MyText(
                                    'RETURN',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  MyText(
                                    '15/12/12',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ).marginOnly(right: 40),
                            ]),

                        const SizedBox(
                          height: 20,
                        ),
                        // < --------- Google Map ------------>

                        Container(
                            width: Get.width,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Visibility(
                                visible: _.showMap == true,
                                child: GoogleMap(
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    zoom: 3,
                                    target: _.currentLatLng,
                                  ),
                                  markers: Set<Marker>.of(_.markers.values),
                                  polylines:
                                      Set<Polyline>.of(_.polylines.values),
                                  onMapCreated: (controller) async {
                                    _.googleMapController = controller;
                                    _.update();
                                  },
                                  gestureRecognizers: Set()
                                    ..add(Factory<PanGestureRecognizer>(
                                        () => PanGestureRecognizer())),
                                ),
                              ),
                            )
                            // Image.asset(
                            //   AppConstants.mapImg,
                            //   height: 181,
                            // ),
                            ).marginOnly(left: 20, right: 20),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Starting point is automatically proved when you \n are within the airport radius 5 km",
                          textAlign: TextAlign.center,
                          style: tipStyle,
                        ).marginOnly(left: 10, right: 10),
                         SizedBox(
                          height: Get.height/17,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_.from.value.text.isEmpty ||
                                _.to.value.text.isEmpty) {
                              // CommonToast.getToast(
                              //   'Please fill all requirements',
                              // );

                              // CommonSnackbar.getSnackbar(
                              //     "Warning", "Please fill all requirements", Colors.blue);
                            } else {
                              if (_.distance(_.latfrom, _.longfrom, _.livelat,
                                      _.livelong) <=
                                  20000000000) {
                                CommonToast.getToast(
                                    'Location verification is in progress.');
                                await Future.delayed(const Duration(seconds: 2),
                                    () {
                                  var distances = _.distance(
                                    _.latfrom,
                                    _.longfrom,
                                    _.latto,
                                    _.longto,
                                  );
                                  _.storage.write("session_lat", _.latfrom);
                                  _.storage.write("session_lng", _.longfrom);
                                  _.storage.write("session_tolat", _.latto);
                                  _.storage.write("session_tolng", _.longto);
                                  _.storage.write(
                                      "session_fromCountry", _.fromCountry);
                                  _.storage
                                      .write("session_toCountry", _.toCountry);
                                  _.storage.write(
                                      "session_totalDistance", distances);
                                  _.landingPageController.isStopped = true;
                                  _.landingPageController.update();
                                  _.showMap = false;
                                  _.update();
                                  Get.to(() => TotalMintingFerryScreen(),
                                      arguments: {
                                        "lat": _.latfrom,
                                        "lng": _.longfrom,
                                        "fromCountry": _.fromCountry,
                                        "toCountry": _.toCountry,
                                        "totalDistance": distances,
                                      });

                                });
                              } else {
                                CommonToast.getToast(
                                  " Airport out of range",
                                );
                              }
                            }
                          },
                          child: Image.asset(
                            AppConstants.nextBtnS,
                            height: 42,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildEmail(DestinationFerryController _) {
    return Form(
      key: _.formKey2,
      child: TextFormField(
        enabled: false,

        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.emailAddress,
        controller: _.from.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Transform.rotate(
            angle: 45 * 3.14 / 180,
            child: const Icon(
              Icons.airplanemode_active,
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          hintText: 'From:',
          hintStyle: hintTextStyle,
        ),
        readOnly: true,
        onTap: () {
          // _.suggestionList.clear();
          // _.search.value.clear();
          suggestionBox(_, isTo: false);
        },
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildEmail2(DestinationFerryController _) {
    return Form(
      key: _.formKey,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _.to.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.location_pin,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          hintText: 'To:',
          hintStyle: hintTextStyle,
        ),
        readOnly: true,
        onTap: () {
          // _.suggestionList.clear();
          // _.search.value.clear();
          suggestionBox(_, isTo: true);
        },
        textAlign: TextAlign.center,
      ),
    );
  }

  suggestionBox(DestinationFerryController _, {bool isTo = false}) {
    return Get.bottomSheet(
        Container(
          width: Get.width,
          height: Get.height / 1.1,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 100,
                    height: 5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GooglePlaceAutoCompleteTextField(
                    textEditingController: _.search.value,
                    googleAPIKey: _.apikey,
                    inputDecoration:
                        InputDecoration(hintText: "Search your location"),
                    debounceTime: 800,
                    // countries: ["in", "fr"],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      print("placeDetails" + prediction.lng.toString());
                    },
                    itmClick: (Prediction prediction) {
                      // print("check prediction ${prediction.}");
                      // controller.text = prediction.description;
                      //
                      print(
                          "check ${TextSelection.fromPosition(TextPosition(offset: prediction.description!.length))}");
                    }
                    // default 600 ms ,
                    ),

                const SizedBox(
                  height: 20,
                ),
                _.isSearchLoading.value
                    ? const Loading()
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _.suggestionList.length,
                          itemBuilder: (c, i) {
                            return listData(_.suggestionList[i].nearby!, _,
                                isToLocation: isTo);
                          },
                        ),
                      ),
              ],
            ).marginOnly(left: 20, right: 20),
          ),
        ),
        isScrollControlled: true);
  }

  Widget listData(List<Nearby> a, DestinationFerryController _,
      {bool isToLocation = false}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: a.length,
      itemBuilder: (c, i) {
        return ListTile(
          onTap: () async {
            if (isToLocation) {
              _.to.value.clear();
              _.to.value.text = a[i].name!;
              _.latto = a[i].lat!;
              _.longto = a[i].lon!;
              _.toCountry = a[i].countryCode!;
              _.isSearchLoading.value = true;
              // await _.getAddressTo(a[i].lat!, a[i].lon!);
              _.isSearchLoading.value = false;
              _.addMarker(LatLng(_.latto, _.longto), "2",
                  BitmapDescriptor.defaultMarker);
              List<LatLng> listofPloylines = [
                LatLng(_.latfrom, _.longfrom),
                LatLng(_.latto, _.longto),
              ];
              _.addPolyLine(listofPloylines);
              _.googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  new CameraPosition(
                    target: LatLng(_.latto, _.longto),
                    zoom: 5.0,
                  ),
                ),
              );
              _.update();
              Get.back();
            } else {
              _.from.value.clear();
              _.from.value.text = a[i].name!;
              _.latfrom = a[i].lat!;
              _.longfrom = a[i].lon!;
              _.fromCountry = a[i].countryCode!;
              // await _.getAddressFrom(a[i].lat!, a[i].lon!);
              _.isSearchLoading.value = false;

              _.addMarker(LatLng(_.latfrom, _.longfrom), "1",
                  BitmapDescriptor.defaultMarker);
              List<LatLng> listofPloylines = [
                LatLng(_.latfrom, _.longfrom),
                LatLng(_.latto, _.longto),
              ];
              _.addPolyLine(listofPloylines);
              _.update();
              Get.back();
            }
          },
          leading: Text(
            "${a[i].name}",
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          trailing: Text(
            "${a[i].countryCode}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }

  void addLocationDialogueBox() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width, // Set the width of the dialog
          height: 290, // Set the height of the dialog
          decoration: BoxDecoration(
            color: const Color(0xffDDFFF4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      child: Image.asset(AppAssets.crossIcon, width: 42),
                    ).marginOnly(top: 30, right: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: MyText(
                      'Current location',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).marginOnly(left: 20, right: 21),
              const SizedBox(height: 10,),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: MyText(
                      'Add a route',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).marginOnly(left: 20, right: 21),
              const SizedBox(height: 10,),
              Container(
                width: Get.width,
                height: Get.height / 19,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: MyText(
                      'Add a route',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).marginOnly(left: 20, right: 21),



            ],
          ),
        ),
      ),
    );
  }
}
