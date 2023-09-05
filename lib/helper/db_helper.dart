import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quotes_db_miner/model/quotes_model.dart';
import 'package:sqflite/sqflite.dart';

class DB_helper {

  DB_helper._();
  DB_helper db_helper = DB_helper._();
  Database? db;

  Future<List<QuotesModel>> LocalJsonDataLoad() async {

    String JsonPath = "assets/json/quotes_file.json";
    String JsonData = await rootBundle.loadString(JsonPath);

    List decoded = jsonDecode(JsonData);

    List<QuotesModel> Category = decoded.map((e) => QuotesModel.fromJson(e)).toList();

    return Category;
  }

  Future init() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'qut.db';
    String path = join(dbPath,dbName);

    db = await openDatabase(
        path,
      version: 1,
      onCreate: (db,_) async {
          String query = "CREATE TABLE IF NOT EXISTS category(id INTEGER, category_tittle TEXT NOT NULL);";

          String query2 = "CREATE TABLE IF NOT EXISTS quotes(id INTEGER ,quote TEXT NOT NULL,author TEXT NOT NULL);";

          await db.execute(query);
          await db.execute(query2);
      });

   Future categoryInsert() async {
     await init();

      List<QuotesModel> Category = await LocalJsonDataLoad();
      for(int i = 0; i < Category.length; i++) {
        String query = "INSERT INTO category(id,category_tittle)VALUES(?,?);";
        List args = [
          Category[i].id,
          Category[i].category,
        ];
       await db!.rawInsert(query,args);
      }

      for(int i=0; i<Category.length; i++) {
        for(int j=0; j<Category[i].quotes.length; j++) {
          String query2 = "INSERT INTO quotes(id,quote,author)VALUES(?,?,?);";
          List args = [
            Category[i].quotes[j].id,
            Category[i].quotes[j].quote,
            Category[i].quotes[j].author,
          ];
          db!.rawInsert(query2,args);
        }
      }
   }
  }
}