import 'dart:async';
// import 'dart:html';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'sign_in_form.dart';
import '../../../modules/save_me/repositories/user_repository.dart';
import '../../../config/themes/colors.dart';
import 'bloc/sign_in_bloc.dart';

import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  final UserRepository _userRepository;
  const SignInScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isConnected;

  @override
  void initState() {
    DataConnectionChecker().hasConnection.then((value) {
      this.isConnected = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text("Back")),
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: widget._userRepository),
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
                  SignInForm(userRepository: widget._userRepository),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}









// actions: <Widget>[
//           TextButton(
//             child: Text('Approve'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),