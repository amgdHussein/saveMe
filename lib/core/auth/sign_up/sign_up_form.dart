// import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:save_me/core/auth/blocs/auth_bloc.dart';
import 'package:save_me/utils/mixins/validation_mixins.dart';
import 'package:save_me/widgets/snack_bars/sign_in_failure.dart';
import 'package:save_me/widgets/snack_bars/sign_in_submitting.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _userNameController.text.isNotEmpty;

  bool isButtonEnabled(SignUpState state) =>
      state.isFormValid && this.isPopulated && !state.isSubmitting;

  SignUpBloc _signUpBloc;
  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
    _userNameController.addListener(_onNameChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isFailure)
          ScaffoldMessenger.of(context).showSnackBar(singInFailureSnackBar());

        if (state.isSubmitting)
          ScaffoldMessenger.of(context).showSnackBar(
            signInSubmittingSnackBar(context: context),
          );

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(AuthSignedIn());
          Phoenix.rebirth(context);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Card(
            color: Theme.of(context).canvasColor,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email_rounded),
                        labelText: "Email Address",
                      ),
                      validator: Validators.isValidEmail,
                      onChanged: (email) {
                        _emailController.text = email;
                        _emailController.selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: _emailController.text.length,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person_rounded),
                        labelText: "Username",
                      ),
                      validator: Validators.isValidUserName,
                      onChanged: (name) {
                        _userNameController.text = name;
                        _userNameController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            offset: _userNameController.text.length,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.vpn_key_rounded),
                        labelText: "Password",
                      ),
                      validator: Validators.isValidPassword,
                      onChanged: (password) {
                        _passwordController.text = password;
                        _passwordController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            offset: _passwordController.text.length,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      maxLength: 10,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("+20"),
                        ),
                        suffixIcon: Icon(Icons.phone_android_rounded),
                        labelText: "Phone Number",
                      ),
                      validator: Validators.isValidPhoneNumber,
                      onChanged: (phone) {
                        _phoneController.text = phone;
                        _phoneController.selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: _phoneController.text.length,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        child: Text("Sign Up"),
                        onPressed: () {
                          if (isButtonEnabled(state)) _onFormSubmitted();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _signUpBloc.add(
      SignUpEmailChange(
        email: _emailController.text,
      ),
    );
  }

  void _onNameChange() {
    _signUpBloc.add(
      SignUpNameChange(
        userName: _userNameController.text,
      ),
    );
  }

  void _onPasswordChange() {
    _signUpBloc.add(
      SignUpPasswordChange(
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      SignUpSubmitted(
        email: _emailController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
      ),
    );
  }
}
