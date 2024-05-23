import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/features/authentication/controller/bloc/bloc/auth_bloc.dart';

String fieldIsEmpty(TextEditingController controller, context) {
  final provider = BlocProvider.of<AuthBloc>(context);
  if (provider.adminEmailController == controller) {
    return 'Email is required';
  } else if (provider.passwordController == controller) {
    return 'Password is required';
  } else {
    return 'Field is required';
  }
}
