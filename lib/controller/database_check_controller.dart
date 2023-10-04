import 'package:quotes_db_miner/export_app.dart';


class DataBaseCheckController extends GetxController {

  DataBaseCheckModel dataBaseCheckModel = DataBaseCheckModel(isInsert: false);

  InsertInValue() {
    dataBaseCheckModel.isInsert = true;

    data.write("isInsert", dataBaseCheckModel.isInsert);

    update();

  }
}