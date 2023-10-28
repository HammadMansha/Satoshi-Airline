// // flutter imports
// import 'package:flutter/material.dart';

// // package imports
// import 'package:get/get.dart';


// class CommonScaffold extends StatelessWidget {
//   final appTitle;
//   final tabar;
//   final appbarcolor;
//   final TextStyle ?appbarstyle;
//   final Color ?backarrow;
//   final Widget ?bodyData;
//   final showFAB;
//   final showDrawer;
//   final showClipdrawer;
//   final showAppBar;
//   final backGroundColors;
//   final actionFirstIcon;
//   final actionSecondIcon;
//   final scaffoldKey;
//   final showBottomNav;
//   final floatingIcon;
//   final centerDocked;
//   final elevation;
//   final enableHeader;
//   final String headerTitle;
//   final String headerSubTitle;
//   final headerName;
//   final topButton;
//   final qrCallback;
//   final String headerImage;
//   final actionFirstIconCallBack;
//   final actionSecondIconCallBack;
//   final appBarSearch;
//   final appBarSearchShow;
//   final appBarAction;

//   CommonScaffold({
//     this.appTitle,
//     this.appbarstyle,
//     this.tabar = false,
//     this.appbarcolor,
//     this.backarrow,
//     this.bodyData,
//     this.showFAB = false,
//     this.showDrawer = false,
//     this.showClipdrawer = false,
//     this.showAppBar = false,
//     this.backGroundColors,
//     this.actionFirstIcon = false,
//     this.actionSecondIcon = false,
//     this.scaffoldKey,
//     this.showBottomNav = false,
//     this.centerDocked = false,
//     this.floatingIcon = Icons.add,
//     this.elevation = 4.0,
//     this.enableHeader = false,
//     this.headerName = false,
//     this.headerTitle = '',
//     this.headerSubTitle = '',
//     this.topButton = 'menu',
//     this.qrCallback,
//     this.headerImage = '',
//     this.actionFirstIconCallBack,
//     this.actionSecondIconCallBack,
//     this.appBarSearch,
//     this.appBarSearchShow = false,
//     this.appBarAction,
//   });

//   Widget myBottomBar() => BottomAppBar(
//         clipBehavior: Clip.antiAlias,
//         child: SizedBox(
//           height: Get.height / 10 - 10,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ReusableIconButton(
//                 icon: Icon(Icons.assignment_rounded, color:
//                     // Get.currentRoute
//                     // == Routes.orderRoutes
//                     // ? UIDataColors.btnColor
//                     // :
//                     Colors.grey,
//                     ),
//                 btntxt: Text("Orders" , style:
//                 // Get.currentRoute == Routes.orderRoutes ?
//                 // UIDataTextStyles.btntext :
//                 UIDataTextStyles.btntext1,),
//                 onPressed: () {
//                   // if (Get.currentRoute != Routes.orderRoutes) {
//                   //   Get.toNamed(Routes.orderRoutes);
//                   // }
//                 },
//               ),
//               ReusableIconButton(
//                 icon: Icon(Icons.post_add, color:
//                 // Get.currentRoute
//                 //     == Routes.productsRoutes
//                 //     ? UIDataColors.btnColor
//                 //     :
//                 Colors.grey,
//                 ),
//                 btntxt: Text("Products" , style:
//                 // Get.currentRoute
//                 //     == Routes.productsRoutes ?
//                 // UIDataTextStyles.btntext :
//                 UIDataTextStyles.btntext1,),
//                 onPressed: () {
//                   // if (Get.currentRoute != Routes.productsRoutes) {
//                   //   Get.toNamed(Routes.productsRoutes);
//                   // }
//                 },),
//               ReusableIconButton(
//                 icon: Icon(Icons.post_add, color:
//                 // Get.currentRoute
//                 //     == Routes.requisitionRoutes
//                 //     ? UIDataColors.btnColor
//                 //     :
//                 Colors.grey,
//                 ),
//                 btntxt: Text("Requisition" , style:
//                 // Get.currentRoute
//                 //     == Routes.requisitionRoutes ?
//                 // UIDataTextStyles.btntext :
//                 UIDataTextStyles.btntext1,),
//                 onPressed: () {
//                   // if (Get.currentRoute != Routes.requisitionRoutes) {
//                   //   // Get.toNamed(Routes.orderRoutes);
//                   // }
//                 },),
//               ReusableIconButton(
//                 icon: Icon(Icons.request_page_outlined, color:
//                 // Get.currentRoute
//                 //     == Routes.reportsRoutes
//                 //     ? UIDataColors.btnColor
//                 //     :
//                 Colors.grey,
//                 ),
//                 btntxt: Text("Reports" , style:
//                 // Get.currentRoute
//                 //     == Routes.reportsRoutes ? UIDataTextStyles.btntext :
//                 UIDataTextStyles.btntext1,),
//                 onPressed: () {
//                   // if (Get.currentRoute != Routes.reportsRoutes) {
//                   //   // Get.toNamed(Routes.orderRoutes);
//                   // }
//                 },),
//               ReusableIconButton(
//                 icon: Icon(Icons.settings, color:
//                 // Get.currentRoute
//                 //     == Routes.settingsRoutes
//                 //     ? UIDataColors.btnColor
//                 //     :
//                 Colors.grey,
//                 ),
//                 btntxt: Text("Settings" , style:
//                 // Get.currentRoute
//                 //     == Routes.settingsRoutes ? UIDataTextStyles.btntext :
//                 UIDataTextStyles.btntext1,),
//                 onPressed: () {
//                   // if (Get.currentRoute != Routes.settingsRoutes) {
//                   //   // Get.toNamed(Routes.settingsRoutes);
//                   // }
//                 },),
//             ],
//           ),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       key: scaffoldKey != null ? scaffoldKey : null,
//       backgroundColor: backGroundColors,
//       appBar: showAppBar
//           ? AppBar(
//               iconTheme: IconThemeData(
//                 color:backarrow!= null ?  backarrow  : Color(0xff1A1B1E),
//               ),
//               elevation: elevation,
//               // leading: InkWell(child: Icon(Icons.keyboard_arrow_left),onTap:(){
//               //   Get.back(result: true);
//               // }),
//               backgroundColor: appbarcolor,
//               title: Text(
//                 appTitle,
//                 style:appbarstyle != null ? appbarstyle : UIDataTextStyles.kSignInHeading,
//               ),
//               actions: appBarAction,
//               centerTitle: true,
              
//             )
//           : null,
//       drawer: showDrawer
//           ? CommonDrawer()
//           : null,
//       body: OrientationBuilder(builder: (context, orientation) {
//         return SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//               color:backGroundColors != null ? backGroundColors : Color(0xffffffff),
//             ),
//             width: (MediaQuery.of(context).size.width.ceil()).toDouble(),
//             height: (MediaQuery.of(context).size.height.ceil()).toDouble(),
//             child: bodyData,
//           ),
//         );
//       }),
//       floatingActionButton: showFAB
//           ? CustomFloat(
//               builder: centerDocked
//                   ? Text(
//                       "5",
//                       style: TextStyle(color: Colors.white, fontSize: 10.0),
//                     )
//                   : null,
//               icon: floatingIcon,
//               qrCallback: qrCallback,
//             )
//           : null,
//       floatingActionButtonLocation: centerDocked
//           ? FloatingActionButtonLocation.centerDocked
//           : FloatingActionButtonLocation.endFloat,
//       bottomNavigationBar: showBottomNav ? myBottomBar() : null,
//     );
//   }
  
// }
