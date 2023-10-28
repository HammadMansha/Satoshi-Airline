import 'package:flutter/material.dart';

import '../../../../../Utils/utils.dart';

class Day extends StatefulWidget {
  const Day({Key? key}) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: MediaQuery(
          data: mqDataNew,
          child: Container(
            height: MediaQuery.of(context).size.height*0.63,
            width: MediaQuery.of(context).size.width*0.89,

            // padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text('Recode in days'),),
          ),
        ),
      ),
    );
  }
}
