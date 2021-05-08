import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: ATHENS_GRAY,
  canvasColor: ABBEY,

  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   type: BottomNavigationBarType.fixed,
  //   elevation: 0.0,
  //   selectedIconTheme: IconThemeData(opacity: 1.0, size: 30),
  //   unselectedIconTheme: IconThemeData(opacity: 0.3, size: 30),
  // ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ATHENS_GRAY,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),

  textTheme: TextTheme(
    button: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: ABBEY,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    ),
    headline3: TextStyle(
      color: ABBEY,
      fontSize: 24,
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    isDense: true,
    hintStyle: TextStyle(color: GRAY_CHATEAU),
    filled: true,
    fillColor: Colors.white,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: ATHENS_GRAY,
    // iconTheme: IconThemeData(color: ABBEY),
    textTheme: TextTheme(
      button: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: ATHENS_GRAY,
    size: 30,
  ),
);
