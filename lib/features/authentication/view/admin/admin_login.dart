import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/constants/constants.dart';
import 'package:linen_republic_admin/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic_admin/features/authentication/model/admin_model.dart';
import 'package:linen_republic_admin/features/authentication/widget/button_widget.dart';
import 'package:linen_republic_admin/features/authentication/widget/text_field.dart';
import 'package:linen_republic_admin/features/home/view/main_screen.dart';

final formKey = GlobalKey<FormState>();

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              height50,
              _buildAdminTitleWidget(),
              height20,
              _buildAdminInputField(auth),
              height40,
              _buildLoginButton(auth)
            ],
          ),
        ),
      ),
    )));
  }

  BlocConsumer<AuthBloc, AuthState> _buildLoginButton(AuthBloc auth) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginErrorState || current is LoginSuccessState,
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (route) => false);
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(LoginclickedEvent(
                  adminLoginModel: AdminLoginModel(
                      userName: auth.adminEmailController.text.trim(),
                      password: auth.passwordController.text.trim())));
            }
          },
          child: state is LoginLoadingState
              ? const CircularProgressIndicator()
              : const ButtonWidget(
                  text: 'Login',
                ),
        );
      },
    );
  }

  Column _buildAdminTitleWidget() {
    return const Column(
      children: [
        Icon(
          Icons.lock,
          size: 200,
          color: Colors.grey,
        ),
        Text('Admin Login',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Column _buildAdminInputField(AuthBloc auth) {
    return Column(
      children: [
        TextFieldWidget(
          hintText: 'E mail',
          prefixIcon: Icons.account_circle_outlined,
          controller: auth.adminEmailController,
        ),
        height20,
        TextFieldWidget(
          hintText: 'Password',
          prefixIcon: Icons.password,
          controller: auth.passwordController,
          obscureText: true,
        ),
      ],
    );
  }
}
