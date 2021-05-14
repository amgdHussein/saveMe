part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSucess extends AuthState {
  final User firebaseUser;
  AuthSucess(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];
}

class AuthFailure extends AuthState {
  // final String error;
  // AuthFailure({@required this.error});

  // @override
  // String toString() => 'AuthFailure(error: $error)';
}
