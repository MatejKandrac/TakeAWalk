import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      background: Color(0xff222131),
      brightness: Brightness.dark,
      primary: Color(0xffF20AB8),
      onPrimary: Color(0xffffffff),
      secondary: Color(0xff7740c2),
      onSecondary: Color(0xffffffff),
      error: Color(0xffff0000),
      onError: Color(0xffffffff),
      onBackground: Color(0xffffffff),
      surface: Color(0xff27283D),
      onSurface: Color(0xffffffff),
    ),
    scaffoldBackgroundColor: const Color(0xff222131),
    cardColor: const Color(0xff27283D),
    dialogBackgroundColor: const Color(0xff27283D),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 25, fontFamily: 'Nunito', color: Colors.white),
      bodyMedium: TextStyle(fontSize: 20, fontFamily: 'Nunito', color: Colors.white),
      bodySmall: TextStyle(fontSize: 15, fontFamily: 'Nunito', color: Colors.white),
      displayLarge: TextStyle(fontSize: 45, fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Colors.white)
    ),
    fontFamily: 'Nunito');
