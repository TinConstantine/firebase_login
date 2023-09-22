import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationIsLoggedIn extends AuthenticationEvent {}

class AuthenticationIsLoggedOut extends AuthenticationEvent {}
