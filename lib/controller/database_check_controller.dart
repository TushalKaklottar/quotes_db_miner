import 'package:get/get.dart';
import 'package:quotes_db_miner/model/database_check_model.dart';
import 'package:quotes_db_miner/utils/attributes.dart';

class DataBaseCheckController extends GetxController {

  DataBaseCheckModel dataBaseCheckModel = DataBaseCheckModel(isInsert: false);

  InsertInValue () {
    dataBaseCheckModel.isInsert = true;

    data.write("isInsert", dataBaseCheckModel.isInsert);

    update();
  }

}