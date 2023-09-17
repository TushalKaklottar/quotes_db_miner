// import 'package:get/get.dart';
// import 'package:quotes_db_miner/model/quote_modal.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class quoteController extends GetxController {
//   dateModel datemodel = dateModel(datetime: DateTime.now());
//
//   date() async {
//     datemodel.dateTime = "${datemodel.datetime.day}/${datemodel.datetime.month}/${datemodel.datetime.year} ${datemodel.datetime.hour}:${datemodel.datetime.minute}";
//
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//
//     preferences.setString('dateTime', datemodel.dateTime!);
//
//     update();
//   }
// }