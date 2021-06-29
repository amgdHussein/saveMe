import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:save_me/modules/save_me/screens/report/bloc/report_bloc.dart';
import 'core/auth/email_verification.dart';
import 'modules/save_me/screens/profile/cubit/profile_cubit.dart';
import 'core/on_boarding/on_boarding.dart';
import 'modules/layout/layout.dart';
import 'modules/save_me/repositories/user_auth_repository.dart';
import 'utils/app_bloc_observer.dart';
import 'config/themes/app_theme.dart';
import 'core/auth/blocs/auth_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserAuthRepository _userRepository = UserAuthRepository(
    firebaseAuth: FirebaseAuth.instance,
  );

  runApp(
    Phoenix(
      child: BlocProvider(
        create: (context) =>
            AuthBloc(userRepository: _userRepository)..add(AuthStarted()),
        child: MyApp(userRepository: _userRepository),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserAuthRepository _userRepository;
  MyApp({UserAuthRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'saveMe',
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: _router.generateRoute,
      themeMode: ThemeMode.dark,
      darkTheme: appTheme,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure)
            return OnboardingScreen(
              userRepository: _userRepository,
            );

          if (state is AuthSucess) {
            if (FirebaseAuth.instance.currentUser != null &&
                !FirebaseAuth.instance.currentUser.emailVerified) {
              return EmailVerificationScreen();
            }
            return AppLayout();
          }

          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
