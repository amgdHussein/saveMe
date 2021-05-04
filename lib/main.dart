import 'package:flutter/material.dart';
import 'package:save_me/screen/on_boarding.dart';
import 'package:save_me/shared/styles/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'save me',
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(), //AppLayout(),
      themeMode: ThemeMode.light,
      theme: SaveMeTheme.lightTheme,
    );
  }
}
