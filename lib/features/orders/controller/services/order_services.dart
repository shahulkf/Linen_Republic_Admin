import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:linen_republic_admin/features/orders/controller/repository/order_repository.dart';
import 'package:linen_republic_admin/features/orders/model/order_model.dart';

class OrderServices implements OrderRepository {
  @override
  Future<Either<String, List<OrderModel>>> fetchOrders() async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('Orders').get();
      final orders =
          response.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      return right(orders);
    } catch (e) {
      return left('Something Went Wrong $e');
    }
  }

  @override
  Future<void> updateOrderStatus(String orderStatus, String orderId) async {
    try {
      // Get the current timestamp map from the Firestore document
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .get();
      if (snapshot.data() != null) {
        final dataMap = snapshot.data()! as Map<String, dynamic>;
        final timestampMap = dataMap['timestamp'] as Map<String, dynamic>;

        // Update the timestamp map with the new status and its corresponding timestamp
        timestampMap[orderStatus] = DateTime.now().toString();

        // Update the Firestore document with the updated status and timestamp map
        await FirebaseFirestore.instance
            .collection('Orders')
            .doc(orderId)
            .update({
          'status': orderStatus,
          'timestamp': timestampMap,
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }
}
