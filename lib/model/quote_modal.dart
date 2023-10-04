import 'package:quotes_db_miner/export_app.dart';

class QuoteModal {
  String id;
  String content;
  String author;
  String authorSlug;
  String text;

  QuoteModal({
    required this.id,
    required this.content,
    required this.author,
    required this.authorSlug,
    required this.text,
});

  factory QuoteModal.fromMap(Map<String,dynamic> data) {
    return QuoteModal(
        id: data['_id'],
        content: data['content'],
        author: data['author'],
        authorSlug: data['authorSlug'],
        text: data['text'],
    );
  }
}

Future<void> saveToSharedPreference(QuoteModal quote) async {
  final pref = await SharedPreferences.getInstance();
  final quoteMap = {
    'id': quote.id,
    'content': quote.content,
    'author': quote.author,
    'authorSlug': quote.authorSlug,
  };
 await pref.setStringList('saved_quote', quoteMap.values.toList());
}

class dateModel {
  DateTime datetime;
  String? dateTime;

  dateModel({
   required this.datetime,
});
}