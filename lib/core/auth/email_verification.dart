import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../modules/save_me/repositories/user_auth_repository.dart';

class EmailVerificationScreen extends StatefulWidget {
  EmailVerificationScreen({Key key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserAuthRepository _userRepository;
  User _user;
  Timer _timer;

  @override
  void initState() {
    _userRepository = UserAuthRepository(firebaseAuth: _firebaseAuth);
    _user = _firebaseAuth.currentUser;
    if (_user != null) {
      _user.sendEmailVerification();
      checkEmailVerified();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _userRepository.singOut().then((value) {
                  Phoenix.rebirth(context);
                });
              },
            ),
          ),
          Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Text(
                "Verify your Email",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white),
              )),
          Positioned(
            top: 180,
            left: 30,
            right: 30,
            child: Column(
              children: [
                Text(
                  "Check your email & click the link to activate you account",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Icon(
              FontAwesomeIcons.solidPaperPlane,
              size: 200,
              color: Colors.white70,
            ),
          ),
          Positioned(
            right: 50,
            left: 50,
            bottom: 70,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).canvasColor,
              child: Text(
                "Continue",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                if (_user != null) {
                  checkEmailVerified();
                }
              },
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 20,
            child: GestureDetector(
              onTap: () async {
                await _user.sendEmailVerification();
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "It may take some time, ",
                    ),
                    TextSpan(
                      text: "Resend",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    _timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) async {
        _user = _firebaseAuth.currentUser;
        await _user.reload();
        if (_user.emailVerified) {
          timer.cancel();
          Phoenix.rebirth(context);
        }
      },
    );
  }
}
