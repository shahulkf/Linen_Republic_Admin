part of 'product_bloc.dart';

class ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel product;
  AddProductEvent({required this.product});
}

class FetchProductsEvent extends ProductEvent {}

class SelectImageEvent extends ProductEvent {}
