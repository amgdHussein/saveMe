import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../modules/save_me/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  AuthBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted)
      yield* _mapAuthStartedToState();
    else if (event is AuthSignedIn)
      yield* _mapAuthSignedInToState();
    else if (event is AuthSignedOut) yield* _mapAuthSignedOutToState();
  }

  // authentication started
  Stream<AuthState> _mapAuthStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      yield AuthSucess(user);
    } else {
      yield AuthFailure();
    }
  }

  // authentication logged in
  Stream<AuthState> _mapAuthSignedInToState() async* {
    yield AuthSucess(await _userRepository.getUser());
  }

  // authentication logged out
  Stream<AuthState> _mapAuthSignedOutToState() async* {
    yield AuthFailure();
    _userRepository.singOut();
  }
}
