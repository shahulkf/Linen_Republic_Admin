import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic_admin/features/authentication/controller/repository/admin_repo.dart';
import 'package:linen_republic_admin/features/authentication/model/admin_model.dart';

class AdminAuthenticationServices implements AdminAuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<Either<String, String>> loginAdmin(
      AdminLoginModel adminLoginModel) async {
    try {
      final adminCredential = await _auth.signInWithEmailAndPassword(
          email: adminLoginModel.userName, password: adminLoginModel.password);

      if (adminCredential.user!.uid == 'sdzfu1ZAh0VSdKeTzI1RdmNX2X93') {
        return right('Login Successfully');
      } else {
        return left('Something Went Wrong');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return left('User not found. Please check your email and try again.');
        case 'wrong-password':
          return left('Invalid password. Please try again.');
        case 'invalid-email':
          return left('Invalid email address. Please enter a valid email.');
        default:
          return left('An error occurred. Please try again later.');
      }
    } catch (e) {
      // print(e.toString());
      rethrow;
    }
  }
}
