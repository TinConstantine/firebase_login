import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginEventEmailChange extends LoginEvent {
  final String? email;
  const LoginEventEmailChange({this.email});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Email change: $email';
}

class LoginEventPasswordChange extends LoginEvent {
  final String? password;
  const LoginEventPasswordChange({this.password});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Email change: $password';
}

class LoginEventWithGooglePressed extends LoginEvent {}

class LoginEventWithEmailAndPasswordPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginEventWithEmailAndPasswordPressed(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'Email: $email  /   Password: $password';
  }
}
