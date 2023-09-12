import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../model/category_database_models.dart';
import '../model/quotes_database_model.dart';

  final data = GetStorage();


final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<QuotesDataModel>>? getAllQuotes;
  Future<List<CategoryDataModel>>? getAllCategory;