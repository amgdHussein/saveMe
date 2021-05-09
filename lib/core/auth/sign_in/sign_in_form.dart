// import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/config/themes/colors.dart';
import 'package:save_me/core/auth/blocs/auth_bloc.dart';
import 'package:save_me/core/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:save_me/core/auth/sign_up/sign_up.dart';
import 'package:save_me/modules/save_me/repositories/user_repository.dart';

class SignInForm extends StatefulWidget {
  final UserRepository _userRepository;
  const SignInForm({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool secure = true;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(SignInState state) =>
      state.isFormValid && this.isPopulated && !state.isSubmitting;

  SignUpBloc _signInBloc;
  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignUpBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          print("fail");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.brown[100],
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sign-in Failure"),
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
                  Text("Signing In..."),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.isSuccess)
          BlocProvider.of<AuthBloc>(context).add(
            AuthSignedIn(),
          );
      },
      child: BlocBuilder<SignUpBloc, SignInState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_rounded),
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
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      if (isButtonEnabled(state)) _onFormSubmitted();
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUpScreen(
                          userRepository: widget._userRepository,
                        ),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "New to ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          text: "save",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: GRAY_CHATEAU),
                        ),
                        TextSpan(
                          text: "Me",
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "? Sign up now.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
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
