class QuotesModel {

  int id;
  String category;
  List<Quote> quotes;


  QuotesModel({
    required this.id,
    required this.category,
    required this.quotes,
});

  factory QuotesModel.fromJson(Map<String,dynamic> data) => QuotesModel(
      id: data['id'],
      category: data['category'],
      quotes: data['quotes']
  );
}

class Quote {
  int? id;
  String quote;
  String author;

  Quote({
    this.id,
    required this.quote,
    required this.author
});
  factory Quote.fromJson(Map<String , dynamic> data) => Quote(
    id: data['id'],
      quote: data['quote'],
      author: data['author']
  );
}
