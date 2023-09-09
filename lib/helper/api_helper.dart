import 'dart:convert';
import '../model/quote_modal.dart';
import 'package:http/http.dart' as http;

class ApiHelper{
  ApiHelper._();
  static final ApiHelper apiHelper = ApiHelper._();

  Future<QuoteModal?> fetchQuote() async {

    String BaseUrl = "http://api.quotable.io/random";

    http.Response response = await http.get(Uri.parse(BaseUrl));

    if(response.statusCode == 200) {
      Map<String,dynamic> decodedData = jsonDecode(response.body);
      QuoteModal quoteData = QuoteModal.fromMap(decodedData);
      return quoteData;
    }
    return null;
  }
}