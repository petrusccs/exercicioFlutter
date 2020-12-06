class Datasource {
   static List<ProductModel> products = [
    ProductModel(cod: 1,
        title: "Seashel Necklace", subtitle: "Special Design", imageName: "images/product1.png", price: 15.00, inStock: true),
    ProductModel(cod: 2,
        title: "Tote Bag", subtitle: "Special Design", imageName: "images/product2.png", price: 36.00, inStock: false),
    ProductModel(cod: 3,
        title: "Scarf", subtitle: "Special Design", imageName: "images/product3.png", price: 16.00, inStock: true),
    ProductModel(cod: 4,
        title: "Metal Earrings", subtitle: "Special Design", imageName: "images/product4.png", price: 12.00, inStock: false),
    ProductModel(cod: 5,
        title: "Scarf 2", subtitle: "Special Design", imageName: "images/product5.png", price: 16.00, inStock: true),
    ProductModel(cod: 6,
        title: "Metal Earrings 2", subtitle: "Special Design", imageName: "images/product6.png", price: 12.00, inStock: false),
  ];

  static List<ItemCart> cart = [];
}

class ProductModel {
  final int cod;
  final String title;
  final String subtitle;
  final String imageName;
  final double price;
  final bool inStock;

  ProductModel({this.cod, this.title, this.subtitle, this.imageName, this.price, this.inStock});
}

class ItemCart {
  final ProductModel product;
  int qtd;

  ItemCart({this.product, this.qtd});
}
