import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB_helper {

  DB_helper._();

  DB_helper db_helper = DB_helper._();


  init() async {

    String dbPath = await getDatabasesPath();
    String dbName = 'qu.db';
    String path = join(dbPath,dbName);

  }
}