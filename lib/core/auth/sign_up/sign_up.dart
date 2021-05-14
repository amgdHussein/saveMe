import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/app_bar.dart';
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
      extendBodyBehindAppBar: true,
      appBar: appBar(
        context,
        isAppTitle: false,
        disableBack: false,
        title: "Back to sign in",
      ),
      body: BlocProvider(
        create: (context) => SignUpBloc(userRepository: _userRepository),
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
                    style: Theme.of(
                      context,
                    ).textTheme.headline3,
                  ),
                  Text(
                    "Sing Up",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  SizedBox(height: 70),
                  SignUpForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
