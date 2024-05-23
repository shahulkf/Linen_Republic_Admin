part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class FetchOrdersSuccessState extends OrdersState {
  final List<OrderModel> orders;
  FetchOrdersSuccessState({required this.orders});
}

class FetchOrdersErrorState extends OrdersState {}

class UpdateStatusSuccessState extends OrdersState {}

class UpdateStatusErrorState extends OrdersState {}
