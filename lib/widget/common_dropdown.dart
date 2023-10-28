// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CommonDropDownField extends StatelessWidget {
//   final TextEditingController controller;
//   final String placeholder;
//   final String? hinttext;
//   final Color? fillcolor;
//   final Color? bordercolor;
//   final List values;
//   final checkedvalue;
//   final String listMapName;
//   final String listMapId;
//   final screenController;
//   final flex;
//   final readOnly;
//   final doCallback;
//   final double? height;
//   final double? width;

//   CommonDropDownField({
//     required this.controller,
//     required this.placeholder,
//     required this.values,
//     this.bordercolor,
//     this.fillcolor,
//     this.hinttext,
//     this.checkedvalue,
//     this.listMapName = 'name',
//     this.listMapId = 'id',
//     @required this.screenController,
//     this.flex = 1,
//     this.readOnly = false,
//     this.doCallback,
//     this.height = 33,
//     this.width = 50,
//   });

//   @override
//   Widget build(context) {
//     TextEditingController terminalName = TextEditingController();
//     if (readOnly) {
//       values.forEach((list) {
//         if (checkedvalue.text == list[listMapId])
//           terminalName.text = list[listMapName];
//       });
//     }
//     return readOnly == false
//         ? Container(
//             width: width,
//             height: height,
//             color: Color(0xffFFE9DD).withOpacity(0.1),
//             child: InputDecorator(
//               baseStyle: TextStyle(fontSize: 10, color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: placeholder,
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
//                 focusColor: Colors.black,
//                 hoverColor: Colors.black,
//                 // labelText: placeholder,
//                 // hintText: hinttext,
//                 filled: true,
//                 fillColor: fillcolor ?? Colors.white,
//                 hintStyle: TextStyle(
//                     color: Colors.black,
//                     overflow: TextOverflow.ellipsis,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Roboto',
//                     letterSpacing: 0.0),

//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                       color: bordercolor ?? Colors.transparent, width: 1.0),
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5.0),
//                     ),
//                     borderSide: BorderSide(width: 1.0)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(5.0),
//                   ),
//                   borderSide: BorderSide(
//                       color: bordercolor ?? Colors.black, width: 3.0),
//                 ),
//                 labelStyle: TextStyle(color: Color(0xff2B2B2B), fontSize: 12.0),
//                 // fillColor: Colors.white,
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   borderRadius: BorderRadius.circular(4),
//                   dropdownColor: Colors.white,
//                   icon: Icon(
//                     Icons.arrow_drop_down_rounded,
//                     size: 15.0,
//                     color: Colors.black,
//                   ),
//                   style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400),
//                   value: checkedvalue.text != ''
//                       ? checkedvalue.text
//                       : values[0][listMapId].toString(),
//                   isDense: true,
//                   isExpanded: true,
//                   items: values.map((list) {
//                     return DropdownMenuItem(
//                       child: list[listMapName] != ''
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   list['iconPath'],
//                                   height: 27,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Flexible(
//                                   child: Text(
//                                     '${list[listMapName]}',
//                                     maxLines: 1,
//                                   ),
//                                 )
//                               ],
//                             )
//                           : Text('notfound'),
//                       value: list[listMapId].toString(),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     print('Drowdown value Selected: ' + value.toString());
//                     controller.text = value.toString();
//                     if (screenController != null) {
//                       screenController.update();
//                     }
//                     doCallback != null ? doCallback() : print('no callback');
//                   },
//                 ),
//               ),
//             ),
//           )
//         : TextFormField(
//             controller: terminalName,
//             readOnly: false,
//           );
//   }
// }
