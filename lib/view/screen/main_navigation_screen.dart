import 'package:flutter/cupertino.dart';
import 'package:quotes_db_miner/export_app.dart';


class Navigation_Screen extends StatelessWidget {
   Navigation_Screen({super.key});

   NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          onPageChanged: (index) {
            controller.Change_Inedex(index: index);
          },
          controller: controller.pageController,
          children:  [
            Home_component(),
            Add_component(),
            Home_component(),
          ],
        ),
        bottomNavigationBar: Obx(
           () => BottomNavigationBar(
              backgroundColor: MyColor.greenAccent,
              selectedItemColor: MyColor.black,
              unselectedItemColor: MyColor.black54,
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
                    icon: Icon(CupertinoIcons.add_circled_solid),
                  label: "Add"
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_favorites),
                  label: "favourite"
                ),
              ],
            ),
        ),
    );
  }
}
