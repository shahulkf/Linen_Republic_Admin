import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic_admin/features/authentication/controller/repository/admin_services.dart';
import 'package:linen_republic_admin/features/authentication/model/admin_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AdminAuthenticationServices authenticationServices;
  AuthBloc(this.authenticationServices) : super(AuthInitial()) {
    on<LoginclickedEvent>(_loginclickedEvent);
  }

  FutureOr<void> _loginclickedEvent(
      LoginclickedEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    final response = await authenticationServices.loginAdmin(AdminLoginModel(
        userName: event.adminLoginModel.userName,
        password: event.adminLoginModel.password));
    response.fold((l) => emit(LoginErrorState(message: l)),
        (r) => emit(LoginSuccessState(message: r)));
  }
}
