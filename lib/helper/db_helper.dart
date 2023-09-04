import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quotes_db_miner/model/quotes_model.dart';
import 'package:sqflite/sqflite.dart';

class DB_helper {

  DB_helper._();
  DB_helper db_helper = DB_helper._();
  Database? database;

  Future<List<QuotesModel>> LocalJsonDataLoad() async {

    String JsonPath = "assets/json/quotes_file.json";
    String JsonData = await rootBundle.loadString(JsonPath);

    List decoded = jsonDecode(JsonData);

    List<QuotesModel> Category = decoded.map((e) => QuotesModel.fromJson(e)).toList();

    return Category;
  }

  init() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'qu.db';
    String path = join(dbPath,dbName);



    }
}