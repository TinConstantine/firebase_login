import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterEventEmailChange extends RegisterEvent {
  final String? email;
  const RegisterEventEmailChange({this.email});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Email change: $email';
}

class RegisterEventPasswordChange extends RegisterEvent {
  final String? password;
  const RegisterEventPasswordChange({this.password});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Email change: $password';
}

class RegisterEventWithGooglePressed extends RegisterEvent {}

class RegisterEventIsLoading extends RegisterEvent {}

class RegisterEventWithEmailAndPasswordPressed extends RegisterEvent {
  final String email;
  final String password;
  const RegisterEventWithEmailAndPasswordPressed(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'Email: $email  /   Password: $password';
  }
}
