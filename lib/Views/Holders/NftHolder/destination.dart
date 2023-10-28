import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Controllers/landing/destination_controller.dart';
import '../../../Model/suggestionairport.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/autocomplete/autocomplete_widget.dart';
import '../../../widget/autocomplete/model/prediction.dart';
import '../../../widget/bottom_navbar.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';

class Destination extends StatelessWidget {
  const Destination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<DestinationController>(
      init: DestinationController(),
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
            bottomNavigationBar: const BottomNavbarWidget(),
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
                          padding: const EdgeInsets.only(left: 40, right: 40),
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
                                  // const SizedBox(
                                  //   width: 15.0,
                                  // ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     Get.to(
                                  //       () => PlacePicker(
                                  //         resizeToAvoidBottomInset: false,
                                  //         apiKey: _.apikey,
                                  //         hintText: "Find a place ...",
                                  //         searchingText: "Please wait ...",
                                  //         selectText: "Select place",
                                  //         outsideOfPickAreaText:
                                  //             "Place not in area",
                                  //         initialPosition: _.kInitialPosition,
                                  //         useCurrentLocation: true,
                                  //         selectInitialPosition: true,
                                  //         usePinPointingSearch: true,
                                  //         usePlaceDetailSearch: true,
                                  //         zoomGesturesEnabled: true,
                                  //         zoomControlsEnabled: true,
                                  //         onMapCreated: (GoogleMapController
                                  //             controller) {},
                                  //         onPlacePicked: (PickResult result) {
                                  //           // _.getAddressFrom(
                                  //           //     result.geometry!.location.lat,
                                  //           //     result.geometry!.location.lng);

                                  //           _.latfrom =
                                  //               result.geometry!.location.lat;
                                  //           _.longfrom =
                                  //               result.geometry!.location.lng;
                                  //           _.storage.write(
                                  //               "session_from",
                                  //               result.formattedAddress
                                  //                   .toString());
                                  //           _.from.value.text = result
                                  //               .formattedAddress
                                  //               .toString();
                                  //           _.update();
                                  //           _.addMarker(
                                  //               LatLng(_.latfrom, _.longfrom),
                                  //               "1",
                                  //               BitmapDescriptor.defaultMarker);
                                  //           // print(
                                  //           //     "check Distance ${_.distance(_.lat, _.long, _.latfrom, _.longfrom)}");
                                  //           Get.back();
                                  //         },
                                  //         onMapTypeChanged:
                                  //             (MapType mapType) {},
                                  //       ),
                                  //     );
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.location_on_outlined,
                                  //   ),
                                  // ),
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
                                        hintText: 'To:',
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
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDepartureDateDialog(context, _);
                                          },
                                          child: Image.asset(
                                            AppAssets.calenderLogo,
                                            width: 30,
                                          ),
                                        ),
                                        MyText(
                                          'DEPARTURE',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        // TextField(
                                        //   controller: _.departure,
                                        // )
                                        MyText(
                                          '${_.departureDateString}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      AppConstants.departureIconFerry,
                                      width: 121,
                                      height: 53,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (DateTime.parse(
                                                    _.departureDateString) ==
                                                '') {
                                              ShowToastMessage(
                                                  'Please Select Departure');
                                            } else {
                                              showReturnDateDialog(context, _);
                                            }
                                          },
                                          child: Image.asset(
                                            AppAssets.calenderLogo,
                                            width: 30,
                                          ),
                                        ),
                                        MyText(
                                          'RETURN',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        MyText(
                                          '${_.returnDateString}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ],
                                    )
                                  ]),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppConstants.destination,
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Obx(
                          () => _.from.value.text.isEmpty
                              ? Text(
                                  "Location verification is in progress",
                                  style: GoogleFonts.sora(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      AppConstants.confirmationDesMsg,
                                      style: GoogleFonts.sora(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (!_.soundPlayed)
                                      Builder(
                                        builder: (context) {
                                          if (_.landingPageController.isSound) {
                                            _.playSoundEffect();
                                          }
                                          _.soundPlayed = true;
                                          return Container();
                                        },
                                      ),
                                  ],
                                ),
                        ),

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
                          height: 7,
                        ),
                        Text(
                          "Starting point confirmed within 1Km airport radius",
                          textAlign: TextAlign.center,
                          style: tipStyle,
                        ).marginOnly(left: 10, right: 10),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_.from.value.text.trim() == '' ||
                                _.to.value.text.trim() == '' ||
                                _.departureDateString == '') {
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
                                  Get.toNamed(Routes.totalmintingRoutes,
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
                            // else if (_.distance(
                            //         _.lat, _.long, _.latfrom, _.longfrom) <=
                            //     5) {
                            //   var distances = _.distance(
                            //     _.latfrom,
                            //     _.longfrom,
                            //     _.latto,
                            //     _.longto,
                            //   );
                            //   _.storage.write("session_lat", _.latfrom);
                            //   _.storage.write("session_lng", _.longfrom);
                            //   _.storage.write("session_tolat", _.latto);
                            //   _.storage.write("session_tolng", _.longto);
                            //   _.storage.write("session_fromCountry", _.fromCountry);
                            //   _.storage.write("session_toCountry", _.toCountry);
                            //   _.storage.write("session_totalDistance", distances);
                            //   Get.to(() => const TotalMintingScreen(), arguments: {
                            //     "lat": _.latfrom,
                            //     "lng": _.longfrom,
                            //     "fromCountry": _.fromCountry,
                            //     "toCountry": _.toCountry,
                            //     "totalDistance": distances,
                            //   });
                            // } else {
                            //   CommonToast.getToast(
                            //     'Please check your address',
                            //   );
                            // }
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

  Widget buildEmail(DestinationController _) {
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

  Widget buildEmail2(DestinationController _) {
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

  suggestionBox(DestinationController _, {bool isTo = false}) {
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

  Widget listData(List<Nearby> a, DestinationController _,
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

  void showDepartureDateDialog(BuildContext context, DestinationController _) {
    DateTime departureDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text('Select Departure Date')),
              content: Container(
                width: Get.width,
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2040, 12, 31),
                  focusedDay: departureDate,
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(departureDate, date);
                  },
                  onDaySelected: (DateTime date, DateTime focusedDay) {
                    setState(() {
                      departureDate =
                          date; // Update the selected departure date
                    });
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _.departureDateString =
                        DateFormat('yyyy-MM-dd').format(departureDate);

                    setState(() {
                      // Add your code here to store or display the selected departure date as needed
                    });
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showReturnDateDialog(BuildContext context, DestinationController _) {
    DateTime returnDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text('Select Return Date')),
              content: Container(
                width: Get.width,
                child: TableCalendar(
                  firstDay: DateTime.parse(_.departureDateString),
                  // Set first day as departure date
                  lastDay: DateTime(2040, 12, 31),
                  focusedDay: DateTime.parse(_.departureDateString),
                  // Set focused day as departure date
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(returnDate, date);
                  },
                  onDaySelected: (DateTime date, DateTime focusedDay) {
                    setState(() {
                      returnDate = date; // Update the selected return date
                    });
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _.returnDateString =
                        DateFormat('yyyy-MM-dd').format(returnDate);
                    _.update();
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
