import 'package:flutter/material.dart';

import '../../../../../Utils/utils.dart';

class Week extends StatefulWidget {
  const Week({Key? key}) : super(key: key);

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
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
            child: Center(child: Text('Recode in weeks'),),
          ),
        ),
      ),
    );
  }
}
