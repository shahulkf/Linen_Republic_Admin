import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/products/controller/repository/productrepo.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';

class ProductAddServices implements ProductAddRepo {
  final _firebase = FirebaseFirestore.instance;
  @override
  Future<Either<String, String>> addProduct(
      {required ProductModel productModel}) async {
    try {
      await _firebase.collection('products').doc(productModel.id).set(productModel.toMap());
      return right("Product added successful");
    } catch (e) {
      return left('error occured $e');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firebase.collection('products').get();
      final products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      return right(products);
    } catch (e) {
      return left('error occured $e');
    }
  }
}
