part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEmailChange extends SignInEvent {
  final String email;

  SignInEmailChange({this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SignInEmailChange(email: $email)';
}

class SignInPasswordChange extends SignInEvent {
  final String password;

  SignInPasswordChange({this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'SignInPasswordChange(password: $password)';
}

class SignInWithCredentialsPressed extends SignInEvent {
  final String email;
  final String password;

  SignInWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'SignInWithCredentialsPressed(email: $email, password: $password)';
}
