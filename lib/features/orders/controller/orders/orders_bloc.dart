// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:linen_republic_admin/features/orders/controller/repository/order_repository.dart';
import 'package:linen_republic_admin/features/orders/model/order_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepository;
  OrdersBloc(this._orderRepository) : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      final response = await _orderRepository.fetchOrders();
      response.fold((l) => emit(FetchOrdersErrorState()),
          (r) => emit(FetchOrdersSuccessState(orders: r)));
    });
    on<UpdateOrderStatusEvent>((event, emit) async {
      await _orderRepository.updateOrderStatus(event.status, event.orderId);
      final response = await _orderRepository.fetchOrders();
      response.fold((l) => emit(FetchOrdersErrorState()),
          (r) => emit(FetchOrdersSuccessState(orders: r)));
    });
  }
}
