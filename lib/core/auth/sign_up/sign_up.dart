import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/app_logo.dart';
import 'sign_up_form.dart';
import '../../../modules/save_me/repositories/user_repository.dart';
import '../../../config/themes/colors.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const SignUpScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(userRepository: _userRepository),
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
                            text: "Sign Up",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    right: 20,
                    left: 20,
                    child: SignUpForm(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              TextSpan(
                                text: "account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              TextSpan(
                                text: "Sign In",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.w900),
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
