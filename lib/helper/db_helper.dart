import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quotes_db_miner/controller/database_check_controller.dart';
import 'package:quotes_db_miner/model/1).quotes_modal.dart';
import 'package:quotes_db_miner/model/category_database_models.dart';
import 'package:quotes_db_miner/model/quotes_database_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import '../utils/attributes.dart';

class DB_helper {


  DB_helper._();
  static final DB_helper db_helper = DB_helper._();

  Database? db;

  Future<List<QuotesModel>> LocalJsonDataLoad() async {

    String JsonPath = "assets/json/quotes_file.json";
    String JsonData = await rootBundle.loadString(JsonPath);

    List decoded = jsonDecode(JsonData);
    List<QuotesModel> Category =
        decoded.map((e) => QuotesModel.fromJson(e)).toList();

    return Category;
  }



  Future init() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath,'qut.db');

    db = await openDatabase(path,version: 1, onCreate: (db,_) {
      String query = "CREATE TABLE IF NOT EXISTS category(id INTEGER, category_tittle TEXT NOT NULL);";

      String query2 = "CREATE TABLE IF NOT EXISTS quotes(id INTEGER ,quote TEXT NOT NULL,author TEXT NOT NULL);";

      db.execute(query);
      db.execute(query2);
    });
  }



  insertCategory() async {
   await init();

    List<QuotesModel> Category = await LocalJsonDataLoad();

    for(int i = 0; i < Category.length; i++) {
      String query = "INSERT INTO category(id, category_tittle)VALUES(?,?);";
      List args = [
        Category[i].id,
        Category[i].category
      ];
      await db!.rawInsert(query,args);
    }

    for(int i= 0; i < Category.length; i++) {
      for(int j=0; j<Category[i].quotes.length; j++) {
        String query2 = "INSERT INTO quotes(id,quote,author)VALUES(?,?,?);";
        List args = [
          Category[i].quotes[j].id,
          Category[i].quotes[j].quote,
          Category[i].quotes[j].author,
        ];
        await db!.rawInsert(query2,args);
      }
    }
  }


Future<List<CategoryDataModel>> fatchAllCategory() async {

    await init();

    DataBaseCheckController dataBaseCheckController = DataBaseCheckController();

    if(data.read("isInsert") != true) {
      await insertCategory();
    }
    dataBaseCheckController.InsertInValue();
    String query = "SELECT * FROM category;";

    List<Map<String,dynamic>> res = await db!.rawQuery(query);

    List<CategoryDataModel> allCategory =
    res.map((e) => CategoryDataModel.fromMap(data: e)).toList();

    return allCategory;
}


  Future<List<CategoryDataModel>> fetchSearchCategory({required String data}) async {
    await init();

    String query = "SELECT * FROM category WHERE category_name LIKE '%$data%'";

    List<Map<String,dynamic>> res = await db!.rawQuery(query);

    List<CategoryDataModel> query1 = res.map((e) => CategoryDataModel.fromMap(data: e)).toList();
    return query1;
  }



  Future<List<QuotesDataModel>> fatchAllQuotes({required int id}) async {
    await init();

    String query = "SELECT * FROM quotes WHERE id = ?;";

    List args = [id];

    List<Map<String,dynamic>> res = await db!.rawQuery(query,args);

    List<QuotesDataModel> allQuotes = res.map((e) => QuotesDataModel.fromMap(data: e)).toList();

    return allQuotes;
  }
}

class APIHelper {
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<QuotesModel?> fetchQuotes() async {
    String baseUrl = "http://api.quotable.io/random";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode == 200) {
      Map<String,dynamic> decodedData = jsonDecode(response.body);
      QuotesModel quotesData = QuotesModel.fromJson(decodedData);
      return quotesData;
    }
    return null;
  }
}
