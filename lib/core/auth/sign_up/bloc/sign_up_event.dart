part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEmailChange extends SignUpEvent {
  final String email;

  SignUpEmailChange({this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SignUpEmailChange(email: $email)';
}

class SignUpNameChange extends SignUpEvent {
  final String userName;

  SignUpNameChange({this.userName});

  @override
  List<Object> get props => [userName];

  @override
  String toString() => 'SignUpNameChange(userName: $userName)';
}

class SignUpPasswordChange extends SignUpEvent {
  final String password;

  SignUpPasswordChange({this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'SignUpPasswordChange(password: $password)';
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String userName;
  final String password;

  SignUpSubmitted({this.email, this.userName, this.password});

  @override
  List<Object> get props => [email, userName, password];

  @override
  String toString() =>
      'SignUpSubmitted(email: $email, userName: $userName, password: $password)';
}
