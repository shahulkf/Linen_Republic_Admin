import 'dart:async';

import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/features/home/view/home_page.dart';
import 'package:linen_republic_admin/features/search/controller/bloc/search_bloc.dart';
import 'package:linen_republic_admin/utils/responsive/responsive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String searchQuery = '';
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchProductEvent(query: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchBar(),
      body: _buildProductViewWidget(context),
    );
  }

  Widget _buildProductViewWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is FilterErrorState) {
            return const Center(child: Text('Error'));
          } else if (state is FilterSuccessState) {
            final products = state.products;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ProductViewTile(
                          product: products[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  PreferredSize _buildSearchBar() {
    final debouncer = Debouncer(delay: 500);
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        title: Container(
          height: Responsive.height * 0.05,
          width: Responsive.width * 0.82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colorGrey6),
          child: CupertinoSearchTextField(
            onChanged: (value) {
              debouncer.run(() {
                context
                    .read<SearchBloc>()
                    .add(SearchProductEvent(query: value));
              });
            },
          ),
        ),
      ),
    );
  }
}

class Debouncer {
  final int delay;
  Timer? timer;
  Debouncer({required this.delay});

  void run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: delay), action);
  }
}
