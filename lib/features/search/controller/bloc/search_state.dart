part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class FilterSuccessState extends SearchState{
 final  List<ProductModel> products;

  FilterSuccessState({required this.products});
}

final class FilterErrorState extends SearchState{}
