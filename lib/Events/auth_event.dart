import 'package:equatable/equatable.dart';

import '../Models/usuario_model.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final User user;

  const LoginEvent({required this.user});

  @override
  List<Object> get props => [user];
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class UnauthenticatedState extends AuthState {}