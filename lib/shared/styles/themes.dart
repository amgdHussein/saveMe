import 'package:flutter/material.dart';
import 'colors.dart';

class SaveMeTheme {
  static ThemeData get lightTheme => ThemeData(
    primaryColor: GHARADE,
    canvasColor: CONCRETE,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      selectedIconTheme:
          IconThemeData(color: GHARADE, opacity: 1.0, size: 30),
      unselectedIconTheme:
          IconThemeData(color: GHARADE, opacity: 0.3, size: 30),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: GHARADE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}