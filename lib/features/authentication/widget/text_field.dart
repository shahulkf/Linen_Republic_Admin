import 'package:flutter/material.dart';
import 'package:linen_republic_admin/utils/validation/validation.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    required controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return fieldIsEmpty(_controller, context);
        }
        return null;
      },
      obscureText: obscureText,
      controller: _controller,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
    );
  }
}
