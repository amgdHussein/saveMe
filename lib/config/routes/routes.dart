import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/save_me/cubit/save_me_cubit.dart';
import '../../modules/save_me/screens/camera.dart';
import '../../modules/save_me/screens/chat.dart';
import '../../modules/save_me/screens/home.dart';
import '../../modules/save_me/screens/profile.dart';
import '../../modules/save_me/screens/search.dart';

class AppRouter {
  final SaveMeCubit _saveMeCubit = SaveMeCubit();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _saveMeCubit,
            child: HomeScreen(),
          ),
        );

      case 'camera':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _saveMeCubit,
            child: CameraScreen(),
          ),
        );

      case 'chat':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _saveMeCubit,
            child: ChatScreen(),
          ),
        );

      case 'profile':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _saveMeCubit,
            child: ProfileScreen(),
          ),
        );

      case 'search':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _saveMeCubit,
            child: SearchScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  void dispose() {
    _saveMeCubit.close();
  }
}
