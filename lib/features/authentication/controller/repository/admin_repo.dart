import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/authentication/model/admin_model.dart';

abstract class AdminAuthRepo{
Future<Either<String,String>>loginAdmin(AdminLoginModel adminLoginModel);  
}