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
      
      theme: ThemeData(
        primaryColor: austyGray,
        canvasColor: concrete,

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: austyGray,
        )
      ),

      darkTheme: ThemeData(
        primaryColor: bourbon,
        canvasColor: mineShaft,

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: bourbon,
        )
      ),

      themeMode: ThemeMode.dark,

    );
  }
}
