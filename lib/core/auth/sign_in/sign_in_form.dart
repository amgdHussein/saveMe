// import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/core/auth/blocs/auth_bloc.dart';
import 'package:save_me/core/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:save_me/utils/mixins/validation_mixins.dart';
import 'package:save_me/widgets/snack_bars/sign_in_failure.dart';
import 'package:save_me/widgets/snack_bars/sign_in_submitting.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(SignInState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  SignInBloc _signInBloc;
  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure)
          ScaffoldMessenger.of(context).showSnackBar(singInFailureSnackBar());

        if (state.isSubmitting)
          ScaffoldMessenger.of(context).showSnackBar(signInSubmittingSnackBar(
            context: context,
          ));

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(AuthSignedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
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
                    _passwordController.selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: _passwordController.text.length,
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      if (isButtonEnabled(state)) _onFormSubmitted();
                    },
                  ),
                ),
              ],
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
    super.dispose();
  }

  void _onEmailChange() {
    _signInBloc.add(
      SignInEmailChange(
        email: _emailController.text,
      ),
    );
  }

  void _onPasswordChange() {
    _signInBloc.add(
      SignInPasswordChange(
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.add(
      SignInWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
