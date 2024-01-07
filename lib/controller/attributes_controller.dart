import 'package:quotes_db_miner/export_app.dart';

class AttributesController extends GetxController {

  final RxList<Color> containerColors = <Color>[].obs;

  final RxInt currentIndex = 0.obs;

  void changeGradientColor(int index) {
    if (containerColors.length <= index) {
      containerColors.add(getRandomColor());
    } else {
      containerColors[index] = getRandomColor();
    }
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  AttributesModel attributesModel = AttributesModel(
      id: 0,
      categoryname: "Love",
      image: images[0]
  );

  getImage({required String img}) {
    attributesModel.image = img;
    update();
  }

  getCategoryId({required int val}) {
    attributesModel.id = val;
    update();
  }

  getCategoryName({required String val}) {
    attributesModel.categoryname = val;
    update();
  }
}