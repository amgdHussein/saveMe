import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/themes/colors.dart';
import '../../../modules/save_me/repositories/user_auth_repository.dart';
import '../../../widgets/app_logo.dart';
import '../sign_up/sign_up.dart';
import 'bloc/sign_in_bloc.dart';
import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  final UserAuthRepository _userRepository;
  const SignInScreen({Key key, UserAuthRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: _userRepository),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 400,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 50,
                    child: logoRichText(
                      textStyle1: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: GRAY_CHATEAU),
                      textStyle2: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 50,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 18),
                        children: [
                          TextSpan(text: "Proceed with your "),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    right: 20,
                    left: 20,
                    child: SignInForm(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpScreen(
                                userRepository: _userRepository,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
