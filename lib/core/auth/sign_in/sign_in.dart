import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sign_up/sign_up.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_logo.dart';
import 'sign_in_form.dart';
import '../../../modules/save_me/repositories/user_repository.dart';
import '../../../config/themes/colors.dart';
import 'bloc/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const SignInScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        isAppTitle: false,
        disableBack: false,
        title: "Back to on boarding",
      ),
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: _userRepository),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logoRichText(
                    textStyle1: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: GRAY_CHATEAU),
                    textStyle2: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: ABBEY),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Proceed with your",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    "Sing In",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  SizedBox(height: 70),
                  SignInForm(),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      GestureDetector(
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
                    ],
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
