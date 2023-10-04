import 'package:quotes_db_miner/export_app.dart';

class AttributesController extends GetxController {

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