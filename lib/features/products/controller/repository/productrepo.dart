import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';

abstract class ProductAddRepo {
  Future<Either<String, String>> addProduct(
      {required ProductModel productModel});
  Future<Either<String, List<ProductModel>>> getProducts();
}
