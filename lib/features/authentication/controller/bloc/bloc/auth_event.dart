part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginclickedEvent extends AuthEvent{
  final AdminLoginModel adminLoginModel;

  LoginclickedEvent({required this.adminLoginModel});
  
}


