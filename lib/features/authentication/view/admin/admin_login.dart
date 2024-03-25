import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/constants/constants.dart';
import 'package:linen_republic_admin/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic_admin/features/authentication/model/admin_model.dart';
import 'package:linen_republic_admin/features/authentication/widget/button_widget.dart';
import 'package:linen_republic_admin/features/authentication/widget/text_field.dart';
import 'package:linen_republic_admin/features/home/view/main_screen.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passworController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            height50,
            const Icon(
              Icons.lock,
              size: 200,
              color: Colors.grey,
            ),
            const Text('Admin Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            height20,
            TextFieldWidget(
              hintText: 'E mail',
              prefixIcon: Icons.account_circle_outlined,
              controller: _userNameController,
            ),
            height20,
            TextFieldWidget(
              hintText: 'Password',
              prefixIcon: Icons.password,
              controller: _passworController,
              obscureText: true,
            ),
            height40,
            BlocConsumer<AuthBloc, AuthState>(
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
                    context.read<AuthBloc>().add(LoginclickedEvent(
                        adminLoginModel: AdminLoginModel(
                            userName: _userNameController.text.trim(),
                            password: _passworController.text.trim())));
                  },
                  child: state is LoginLoadingState
                      ? const CircularProgressIndicator()
                      : const ButtonWidget(
                          text: 'Login',
                        ),
                );
              },
            )
          ],
        ),
      ),
    )));
  }
}
  