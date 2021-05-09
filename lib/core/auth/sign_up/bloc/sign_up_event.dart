part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailChange extends SignUpEvent {
  final String email;

  SignUpEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChange extends SignUpEvent {
  final String password;

  SignUpPasswordChange({this.password});

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;

  SignUpSubmitted({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
