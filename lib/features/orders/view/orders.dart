import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic_admin/features/orders/controller/orders/orders_bloc.dart';
import 'package:linen_republic_admin/utils/responsive/responsive.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(GetOrdersEvent());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Orders',
              style: GoogleFonts.prata(fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is FetchOrdersSuccessState) {
                return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Responsive.height * 0.16,
                      width: Responsive.width * 1,
                      decoration: BoxDecoration(
                          color: colorGrey6,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(state.orders[index].orderId),
                          Container(
                            height: Responsive.height * 0.04,
                            width: Responsive.width * 0.47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: TextButton(
                                onPressed: () {
                                  final status =
                                      getStatus(state.orders[index].status);
                                  if (status == 'Delivered') {
                                    return;
                                  }
                                  context
                                      .read<OrdersBloc>()
                                      .add(UpdateOrderStatusEvent(
                                        status: getUpdateStatus(
                                            state.orders[index].status),
                                        orderId: state.orders[index].orderId,
                                      ));
                                },
                                child: Text(
                                    getStatus(state.orders[index].status))),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}

String getStatus(String status) {
  switch (status) {
    case 'Order Placed':
      return 'Confirm for shipping';
    case 'Order Shipped':
      return 'Confirm for delivery';
    case 'Out For Delivery':
      return 'Delivered';
    default:
      return '';
  }
}

String getUpdateStatus(String status) {
  switch (status) {
    case 'Order Placed':
      return 'Order Shipped';
    case 'Order Shipped':
      return 'Out For Delivery';
    default:
      return '';
  }
}
