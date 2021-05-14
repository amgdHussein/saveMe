import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/mixins/validation_mixins.dart';
import '../../../../modules/save_me/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInState.initial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChange)
      yield* _mapSignInEmailChangeToState(email: event.email);
    else if (event is SignInPasswordChange)
      yield* _mapSignInPasswordChangeToState(password: event.password);
    else if (event is SignInWithCredentialsPressed)
      yield* _mapSignInWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
  }

  Stream<SignInState> _mapSignInEmailChangeToState({String email}) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email) == null);
  }

  Stream<SignInState> _mapSignInPasswordChangeToState(
      {String password}) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password) == null);
  }

  Stream<SignInState> _mapSignInWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield SignInState.loading();

    try {
      await _userRepository.singInWithCredentials(
        email: email,
        password: password,
      );
      yield SignInState.success();
    } catch (error) {
      print(error);
      yield SignInState.failure();
    }
  }
}
