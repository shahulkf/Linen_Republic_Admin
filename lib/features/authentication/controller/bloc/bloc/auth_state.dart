part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState{}

class LoginSuccessState extends AuthState{
  final String message;
  LoginSuccessState({required this.message});
}

class LoginErrorState extends AuthState{
  final String message;
  LoginErrorState({required this.message});
}
