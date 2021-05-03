import 'package:flutter/material.dart';
import 'layout/app_layout.dart';

import 'shared/constants/colors.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'save me',
      debugShowCheckedModeBanner: false,
      home: AppLayout(),

      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: bourbon,
        canvasColor: mineShaft,

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: concrete,
          unselectedItemColor: austyGray,
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: bourbon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          splashColor: codGray,
        )
      ),
    );
  }
}
