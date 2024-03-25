class ProductModel {
  String? id;
  String name;
  String description;
  num price;
  String category;
  List<String> images;
  Map<String, dynamic> sizeWithQuantity;

  ProductModel({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.images,
    required this.price,
    required this.sizeWithQuantity,
  });
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      images: (map['images'] as List).map((e) => e.toString()).toList(),
      price: map['price'] ?? 0,
      sizeWithQuantity: map['sizeWithQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'sizeWithQuantity': sizeWithQuantity,
    };
  }
}
