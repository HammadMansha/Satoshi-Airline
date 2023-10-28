import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/bottom_tab_controllers.dart';


class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(

        currentIndex: Get.find<BottomTabController>().bottomSelectedTab.value,
        onTap: (index) {
          Get.find<BottomTabController>().bottomSelectedTab.value = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
