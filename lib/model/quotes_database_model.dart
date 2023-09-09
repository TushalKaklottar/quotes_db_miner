class QuotesDataModel {

  int? id;
  String quotes;
  String author;


  QuotesDataModel ({
    required this.id,
    required this.quotes,
    required this.author,
});

  factory QuotesDataModel.fromMap({required Map data}) {
    return QuotesDataModel(
        id: data['id'],
        quotes: data['quotes'],
        author: data['author']
    );
  }
}
