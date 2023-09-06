class CategoryDataModel {
   int id;
   String category_name;

   CategoryDataModel({
      required this.id,
      required this.category_name,
});

   factory CategoryDataModel.fromMap({ required Map data}) {
      return CategoryDataModel(
          id: data['id'],
          category_name: data['category_name']
      );
   }
}


