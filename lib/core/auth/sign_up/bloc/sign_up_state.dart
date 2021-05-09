part of 'sign_up_bloc.dart';

class SignUpState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignUpState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SignUpState.initial() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.failure() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }
  factory SignUpState.success() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignUpState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  // @override
  // List<Object> get props =>
  //     [isEmailValid, isPasswordValid, isSubmitting, isSuccess, isFailure];

       @override
  String toString() =>
      'SignUpState(isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure)';


}
