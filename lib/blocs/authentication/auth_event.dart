part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  SignUpRequested();
}

class AuthInitEvent extends AuthEvent {}

class SignOutUser extends AuthEvent {}
