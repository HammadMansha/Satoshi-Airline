
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utils/appcolor_wallet.dart';


class CustomTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;

  CustomTabBar({
    required this.tabs,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      color: Colors.grey[200],
      child: Row(
        children: tabs.map((tab) {
          final tabIndex = tabs.indexOf(tab);
          return SizedBox(
            height: 100,
            child: Stack(
              children: [
                Positioned(
                  top: 49,
                  left:70,
                  child: Transform(
                    transform: Matrix4.identity(),
                    child: Container(
                      width: 240,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff62C8A9),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.5, // <-- set border width here
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 67,
                  child: Transform(
                    transform: Matrix4.identity(),
                    child: Container(
                        width: 240,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: const Color(0xffFFFDFD),
                            color: AppColor.buttonColor,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5, // <-- set border width here
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'CONNECT',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,fontFamily: 'Sora'),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TabItem {
  final String text;

  TabItem({required this.text});
}