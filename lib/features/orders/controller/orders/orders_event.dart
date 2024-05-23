part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {}

class UpdateOrderStatusEvent extends OrdersEvent {
  final String status;
  final String orderId;
  UpdateOrderStatusEvent({required this.status, required this.orderId});
}
