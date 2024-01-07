import 'package:quotes_db_miner/export_app.dart';


class HomeController extends GetxController {

  // IndexedStack index controller
  var index = 0.obs;
  void changeIndex (int newIndex) {
    index.value = newIndex ;
  }

  // random Container
  final RxList<Color> containerColors = <Color>[].obs;

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xffff21de).toInt() << 1)
        .withOpacity(1.0);
  }

  void changeGradientColor(int index) {
    if (containerColors.length <= index) {
      containerColors.add(getRandomColor());
    } else {
      containerColors[index] = getRandomColor();
    }
  }


  // carousel slider

   RxInt currentIndex = 0.obs;
  final List<String> images = [
    "assets/images/carousel_slider/1.png",
    "assets/images/carousel_slider/2.png",
    "assets/images/carousel_slider/3.png",
    "assets/images/carousel_slider/4.png",
    "assets/images/carousel_slider/5.png",
    "assets/images/carousel_slider/6.png",
  ];
  void updateIndex(int index) {
    currentIndex.value = index;
  }
}