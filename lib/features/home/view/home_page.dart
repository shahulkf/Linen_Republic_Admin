import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic_admin/constants/app_strings/app_strings.dart';
import 'package:linen_republic_admin/constants/constants.dart';
import 'package:linen_republic_admin/features/products/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';
import 'package:linen_republic_admin/features/products/view/edit_products.dart';
import 'package:linen_republic_admin/utils/responsive/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductsEvent());
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildProductsView(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text(
      'Admin',
      style: GoogleFonts.prata(fontWeight: FontWeight.bold, fontSize: 25),
    ));
  }

  BlocBuilder<ProductBloc, ProductState> _buildProductsView() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductFetchSuccessState) {
          return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductEditScreen(productModel: product),
                            ));
                      },
                      child: ProductViewTile(product: product)),
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
    );
  }
}

class ProductViewTile extends StatelessWidget {
  final ProductModel product;
  const ProductViewTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.3,
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
          SizedBox(width: Responsive.width * 0.02),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: colorGrey4,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "${AppStrings.rupee} ${product.price}",
                style: const TextStyle(
                    color: colorGrey4,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          BlocListener<ProductBloc, ProductState>(
            listenWhen: (previous, current) =>
                current is DeleteSuccessState || current is DeleteErrorState,
            listener: (context, state) {
              if (state is DeleteSuccessState) {
                context.read<ProductBloc>().add(FetchProductsEvent());
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is DeleteErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: IconButton(
                onPressed: () {
                  _showDailogue(context, product.id);
                },
                icon: const Icon(Icons.delete)),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Future<dynamic> _showDailogue(BuildContext context, String? id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete',
              style: CustomTextStyle.titleStyle,
            ),
            content: Text(
              'Do You Want to Delete this Product ?',
              style: CustomTextStyle.titleStyle,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  context.read<ProductBloc>().add(DeleteProductEvent(id: id!));
                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: CustomTextStyle.titleStyle,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: CustomTextStyle.titleStyle,
                ),
              ),
            ],
          );
        });
  }
}
