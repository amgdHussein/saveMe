import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/modules/save_me/screens/profile/cubit/profile_cubit.dart';
import 'package:save_me/utils/ui/dialogs/email_verification.dart';
import '../../../core/auth/blocs/auth_bloc.dart';
import '../repositories/user_repository.dart';
import 'profile/edit_profile.dart';
import '../../../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserRepository _userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    if (_userRepository.getUser().displayName == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileEditScreen()),
      );
    }

    return GestureDetector(
      onTap: () {
        if (!_userRepository.getUser().emailVerified)
          showEmailVerificationDialog(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar(context, isAppTitle: true, disableBack: true),
        body: Center(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialButton(
                child: Text("Sign out"),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthSignedOut());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
