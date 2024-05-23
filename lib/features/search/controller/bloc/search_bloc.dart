import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:linen_republic_admin/features/products/controller/repository/productrepo.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final  ProductAddRepo  productAddRepo;
  SearchBloc(this.productAddRepo) : super(SearchInitial()) {
    
        on<SearchProductEvent>(_searchProductEvent);

  }

  FutureOr<void> _searchProductEvent(SearchProductEvent event, Emitter<SearchState> emit)async {
     final response = await productAddRepo.searchProducts(event.query);
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      products.sort((a, b) => a.price.compareTo(b.price));
      emit(FilterSuccessState(products: products));
    });
  }
}
