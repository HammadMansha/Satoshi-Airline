import 'package:flutter/material.dart';

import '../../../../../Utils/utils.dart';

class Year extends StatefulWidget {
  const Year({Key? key}) : super(key: key);

  @override
  State<Year> createState() => _YearState();
}

class _YearState extends State<Year> {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height*0.63,
            width: MediaQuery.of(context).size.width*0.89,

            // padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 40),
              child: Image.asset(AppConstants.recordStatus),
            )
          ),
        ),
      ),
    );
  }
}
