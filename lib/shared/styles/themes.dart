import 'package:flutter/material.dart';
import 'colors.dart';

class SaveMeTheme {
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: ABBEY,
    canvasColor: GRAY_CHATEAU[50],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      selectedIconTheme: IconThemeData(opacity: 1.0, size: 30),
      unselectedIconTheme: IconThemeData(opacity: 0.3, size: 30),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),

    textTheme: TextTheme(
      button: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline1: TextStyle(
        color: ABBEY,
        fontSize: 30, 
        fontWeight: 
        FontWeight.w900,
      ),
      headline2: TextStyle(
        color: ABBEY,
        fontSize: 24, 
      ),
      bodyText2: TextStyle(
        color: ABBEY,
        fontSize: 16, 
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      hintStyle: TextStyle(color: GRAY_CHATEAU),
      filled: true,
      fillColor: Colors.white
    ),
  );
}