class ProductModel{

  int id;
  String name;
  String image;
  String description;
  double price;
  int amount;
  double ranking;
  int category;

  ProductModel({
    required this.id, required this.name, required this.image, required this.description, required this.price, required this.amount, 
    required this.ranking, required this.category
  });

}