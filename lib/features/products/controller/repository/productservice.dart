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
      await _firebase
          .collection('products')
          .doc(productModel.id)
          .set(productModel.toMap());
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

  @override
  Future<Either<String, String>> deleteProduct({required String id}) async {
    try {
      await _firebase.collection('products').doc(id).delete();
      return right('Deleted Successfully');
    } catch (e) {
      return left('Something Went Wrong $e');
    }
  }
  
  @override
  Future<Either<String, String>> editProduct({required ProductModel productModel})async {
   try {
   await  _firebase.collection('products').doc(productModel.id).update(productModel.toMap());
     return right('Updated Successfully');
   } catch (e) {
    return left('Something Went Wrong');
     
   }
  }
  @override
  Future<Either<String, List<ProductModel>>> searchProducts(
      String query) async {
    try {
      QuerySnapshot querySnapshot;

      if (query.isNotEmpty) {
        // If a query is provided, perform a search based on the product name
        querySnapshot = await _firebase
            .collection('products')
            .where('nameLower', isGreaterThanOrEqualTo: query.toLowerCase())
            .where('nameLower', isLessThan: '${query.toLowerCase()}z')
            .get();
      } else {
        // Otherwise, fetch all products
        querySnapshot = await _firebase.collection('products').get();
      }

      final products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      return right(products);
    } catch (e) {
      return left(e.toString());
    }
  }
}
