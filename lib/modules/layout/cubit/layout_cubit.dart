import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../save_me/screens/report/report.dart';
import '../../save_me/screens/profile/profile.dart';
import '../../save_me/screens/search.dart';
import '../../save_me/screens/chat/chat.dart';
import '../../save_me/screens/home.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  List<Widget> screens;
  LayoutCubit() : super(LayoutState.initial()) {
    screens = [
      HomeScreen(),
      ChatScreen(),
      ReportScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];

    changeLayout(screenIndex: 0);
  }

  void changeLayout({@required int screenIndex}) {
    emit(LayoutState.changing(tab: screenIndex, screen: screens[screenIndex]));
  }
}
