import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {

  PageController pageController = PageController();
   RxInt _currentIndex = 0.obs;

   int get getIndex {
     return _currentIndex.value;
   }

   void Change_Inedex({required int index}) {
     _currentIndex(index);
     pageController.animateToPage(
         index,
         duration: const Duration(milliseconds: 600),
         curve: Curves.easeOut,
     );
   }

}