part of 'product_bloc.dart';

class ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel product;
  AddProductEvent({required this.product});
}

class FetchProductsEvent extends ProductEvent {}

class SelectImageEvent extends ProductEvent {}

class SelectDefaultImageEvent extends ProductEvent {
  final List<String> images;

  SelectDefaultImageEvent({required this.images});
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent({required this.id});
}

class UpdateProductEvent extends ProductEvent{
  final ProductModel product;

  UpdateProductEvent({required this.product});
}
