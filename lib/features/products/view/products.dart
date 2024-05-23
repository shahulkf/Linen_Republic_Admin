import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic_admin/colors/colors.dart';
import 'package:linen_republic_admin/constants/constants.dart';
import 'package:linen_republic_admin/features/products/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic_admin/features/products/model/product_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  List<String> images = [];
  Map<String, int> sizes = {
    'S': 0,
    'M': 0,
    'L': 0,
    'XL': 0,
  };
  double? rating;
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: GoogleFonts.prata(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            buildImageSelector(),
            height20,
            buildProductNameField(),
            height10,
            buildProductPriceField(),
            height20,
            buildCategoryDropdown(),
            height20,
            buildSizeFields(),
            height10,
            buildProductDescriptionField(),
            height20,
            buildAddProductButton(),
          ],
        ),
      ),
    );
  }

  Widget buildImageSelector() {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ImageSelectedState) {
          images = state.images;
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<ProductBloc>().add(SelectImageEvent());
          },
          child: SizedBox(
            height: 300,
            child: state is ImageSelectedState
                ? ListView.builder(
                    itemCount: state.images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(state.images[index])),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: whiteColor,
                    height: 300,
                    width: double.infinity,
                    child: const Icon(
                      color: greyColor,
                      Icons.collections,
                      size: 60,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget buildProductNameField() {
    return TextFormField(
      controller: _productNameController,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Product Name',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the product name';
        }
        return null;
      },
    );
  }

  Widget buildProductPriceField() {
    return TextFormField(
      controller: _productPriceController,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Price',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the product price';
        }
        return null;
      },
    );
  }

  Widget buildCategoryDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Expanded(
              child: Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 14,
                  color: blackColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: ['Classic', 'Vintage', 'Printed']
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                  ),
                ))
            .toList(),
        value: category,
        onChanged: (value) {
          setState(() {
            category = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white70,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          iconSize: 18,
          iconEnabledColor: blackColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: whiteColor,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  Widget buildSizeFields() {
    return Column(
      children: sizes.keys.map((size) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(size),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    sizes[size] = int.parse(value);
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildProductDescriptionField() {
    return TextFormField(
      controller: _productDescriptionController,
      maxLines: 10,
      minLines: 3,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Description',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Description';
        }
        return null;
      },
    );
  }

  Widget buildAddProductButton() {
    return InkWell(
      onTap: _addProduct,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(14),
            ),
            height: 50,
            width: 300,
            child: Center(
              child: state is ProductAddLoadingState
                  ? const CircularProgressIndicator(color: whiteColor)
                  : const Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      int totalQuantity = 0;
      for (var element in sizes.values) {
        totalQuantity += element;
      }
      if (totalQuantity < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("At least one size quantity is required"),
          ),
        );
        return;
      }
      if (category == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category is required")),
        );
        return;
      }
      if (images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Images are required")),
        );
        return;
      }
      _formKey.currentState!.save();
      final name = _productNameController.text.trim();
      final price = _productPriceController.text.trim();
      final description = _productDescriptionController.text.trim();

      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category!,
        description: description,
        images: images,
        price: int.parse(price),
        sizeWithQuantity: sizes,
      );
      context.read<ProductBloc>().add(AddProductEvent(product: product));
      _productNameController.clear();
      _productPriceController.clear();
      _productDescriptionController.clear();
      category = null;
      setState(() {
        sizes = {'S': 0, 'M': 0, 'L': 0, 'XL': 0};
      });
    }
  }
}
