// import 'package:bloc_provider/bloc_provider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/core/auth/blocs/auth_bloc.dart';
import 'package:save_me/utils/ui/app_dialogs.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool secure = true;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(SignUpState state) =>
      state.isFormValid && this.isPopulated && !state.isSubmitting;

  SignUpBloc _signUpBloc;
  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.brown[100],
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sign-up Failure"),
                  Icon(Icons.error_rounded),
                ],
              ),
            ),
          );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[100],
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Signing Up..."),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthSignedIn(),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_rounded),
                    labelText: "Username",
                  ),
                  validator: (email) {
                    if (email.isEmpty) return "User name is required.";
                    return null;
                  },
                  onChanged: (email) {
                    _userNameController.text = email;
                    _userNameController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _userNameController.text.length));
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_rounded),
                    labelText: "Email Address",
                  ),
                  validator: (_) =>
                      !state.isEmailValid ? "Invalid Email." : null,
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
                  obscureText: secure,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.vpn_key_rounded),
                    labelText: "Password",
                  ),
                  validator: (_) =>
                      !state.isPasswordValid ? "Invalid Password." : null,
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
                // for bloc addition
                FutureBuilder(
                  future: DataConnectionChecker().hasConnection,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        child: Text("Sign In"),
                        onPressed: () {
                          if (!snapshot.data)
                            showErrorNetworkDiag(context);
                          else if (isButtonEnabled(state)) _onFormSubmitted();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _signUpBloc.add(
      SignUpEmailChange(
        email: _emailController.text,
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
        password: _passwordController.text,
      ),
    );
  }
}
