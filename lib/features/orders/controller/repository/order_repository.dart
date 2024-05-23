import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/orders/model/order_model.dart';

abstract class OrderRepository {
  Future<Either<String, List<OrderModel>>> fetchOrders();
  Future<void> updateOrderStatus(String orderStatus, String orderId);
}
