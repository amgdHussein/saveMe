import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text("Back")),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "save",
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                color: GRAY_CHATEAU,
                              ),
                        ),
                        TextSpan(
                          text: "Me",
                          style: Theme.of(
                            context,
                          ).textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Proceed with your",
                    style: Theme.of(
                      context,
                    ).textTheme.headline3,
                  ),
                  Text(
                    "Sing In",
                    style: Theme.of(
                      context,
                    ).textTheme.headline3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 70),
                  SignInForm(userRepository: _userRepository)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
