import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_db_miner/component/home_component.dart';
import 'package:quotes_db_miner/controller/page_controller.dart';
import 'package:get/get.dart';
import 'package:quotes_db_miner/utils/app_color.dart';

import '../../component/add_component.dart';

class Navigation_Screen extends StatelessWidget {
   Navigation_Screen({super.key});

   NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          onPageChanged: (index) {
            controller.Change_Inedex(index: index);
          },
          controller: controller.pageController,
          children: const [
            Home_component(),
            Add_component(),
            Home_component(),
          ],
        ),
        bottomNavigationBar: Obx(
           () => BottomNavigationBar(
              backgroundColor: MyColor.greenAccent,
              selectedItemColor: MyColor.black,
              unselectedItemColor: MyColor.black87,
              showUnselectedLabels: false,
              onTap: (index) {
                controller.Change_Inedex(index: index);
              },
              currentIndex: controller.getIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                  label: "Home"
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                  label: "Home"
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                  label: "Home"
                ),
              ],
            ),
        ),
      ),
    );
  }
}
