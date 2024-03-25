part of 'product_bloc.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

class ProductAddLoadingState extends ProductState {}

class ProductFetchLoadingState extends ProductState {}

class ProductAddSuccessState extends ProductState {
  final String message;
  ProductAddSuccessState({required this.message});
}

class ProductAddErrorState extends ProductState {
  final String message;
  ProductAddErrorState({required this.message});
}

class ProductFetchSuccessState extends ProductState {
  final List<ProductModel> products;
  ProductFetchSuccessState({required this.products});
}

class ProductFetchErrorState extends ProductState {
  final String message;
  ProductFetchErrorState({required this.message});
}

class ImageSelectedState extends ProductState {
  List<String> images;
  ImageSelectedState({required this.images});
}
