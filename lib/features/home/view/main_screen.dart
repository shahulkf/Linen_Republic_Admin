import 'package:flutter/material.dart';
import 'package:linen_republic_admin/features/orders/view/orders.dart';
import 'package:linen_republic_admin/features/products/view/products.dart';
import 'package:linen_republic_admin/features/search/view/search.dart';
import 'package:linen_republic_admin/features/home/view/home_page.dart';
import 'package:linen_republic_admin/features/home/widget/bottom_nav/bottomnav.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final List _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const OrdersScreen(),
    const ProductsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, value, _) {
          return _pages[value];
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
