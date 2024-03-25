import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/features/products/controller/bloc/product/product_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductsEvent());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Products',
              ),
              Tab(
                text: 'Orders',
              )
            ]),
            title: const Text(
              'Admin',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
        body: TabBarView(children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductFetchSuccessState) {
                return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.16,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          product.images.first,
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.61,
                                    child: Text(
                                      product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "\$ ${product.price}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else if (state is ProductFetchErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is ProductFetchLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
          Container(
            child: const Text('Orders Page'),
          ),
        ]),
      ),
    );
  }
}
