part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSignedIn extends AuthEvent {}

class AuthSignedOut extends AuthEvent {}
