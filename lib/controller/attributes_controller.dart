import '../model/attributes_modal.dart';
import 'package:get/get.dart';
import '../utils/list.dart';

class AttributesController extends GetxController {

  var attributesModel = AttributesModel(
  id: 0,
  categoryname: "Quotes_love",
  image: images[0]
  ).obs;


  void getImage({required String img}) {
    attributesModel.update((model) {
      model?.image = img;
    });
  }

  void getCategoryId({required int val}) {
    attributesModel.update((model) {
      model?.id = val;
    });
  }

  void getCategoryName({required String val}) {
    attributesModel.update((model) {
      model?.categoryname = val;
    });
  }
}