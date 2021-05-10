import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../save_me/screens/camera.dart';
import '../../save_me/screens/chat.dart';
import '../../save_me/screens/home.dart';
import '../../save_me/screens/profile.dart';
import '../../save_me/screens/report.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final User user;
  List<Widget> screens;
  LayoutCubit({@required this.user}) : super(LayoutState.initial()) {
    screens = [
      HomeScreen(user: user),
      ChatScreen(),
      CameraScreen(),
      ReportScreen(),
      ProfileScreen(),
    ];

    changeLayout(screenIndex: 0);
  }

  void changeLayout({@required int screenIndex}) {
    emit(LayoutState.changing(tab: screenIndex, screen: screens[screenIndex]));
  }
}
