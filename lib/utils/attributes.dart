import 'package:get_storage/get_storage.dart';
import 'package:quotes_db_miner/model/quotes_database_model.dart';
import '../model/category_database_models.dart';


  final data = GetStorage();

Future<List<CategoryDatabaseModel>>? getAllCategory;
Future<List<QuotesDatabaseModel>>? getAllQuotes;