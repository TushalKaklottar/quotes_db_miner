class QuotesDatabaseModel {

  int? id;
  String quotes;
  String author;


  QuotesDatabaseModel ({
    required this.id,
    required this.quotes,
    required this.author,
});

  factory QuotesDatabaseModel.fromMap({required Map data}) {
    return QuotesDatabaseModel(
        id: data['id'],
        quotes: data['quotes'],
        author: data['author']
    );
  }
}
