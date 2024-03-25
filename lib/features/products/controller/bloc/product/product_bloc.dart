import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/features/products/controller/repository/productrepo.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';
import 'package:linen_republic_admin/utils/imagepicker.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductAddRepo productRepo;
  ProductBloc(this.productRepo) : super(ProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      emit(ProductAddLoadingState());
      final imageUrls = await ImageServices().uploadImages(
          imagePaths: event.product.images, productName: event.product.name);
      event.product.images = imageUrls;
      final response =
          await productRepo.addProduct(productModel: event.product);
      response.fold((l) => emit(ProductAddErrorState(message: l)),
          (r) => emit(ProductAddSuccessState(message: r)));
    });
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductFetchLoadingState());
      final response = await productRepo.getProducts();
      response.fold((l) => emit(ProductFetchErrorState(message: l)),
          (r) => emit(ProductFetchSuccessState(products: r)));
    });
    on<SelectImageEvent>((event, emit) async {
      final imagess = await uploadImage();
      if (imagess.isEmpty) {
        emit(ProductInitial());
        return;
      }
      emit(ImageSelectedState(images: imagess));
    });
  }
}
