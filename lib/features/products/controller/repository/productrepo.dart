import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';

abstract class ProductAddRepo {
  Future<Either<String, String>> addProduct(
      {required ProductModel productModel});
  Future<Either<String, List<ProductModel>>> getProducts();
  Future<Either<String, String>> deleteProduct({required String id});
  Future<Either<String, String>> editProduct({required ProductModel productModel});
  Future<Either<String, List<ProductModel>>> searchProducts(
      String query);
}
