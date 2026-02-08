import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const darkNavy = Color(0xff1C2938);
  static const lightNavy = Color(0xff9B9BAF);
  static const canvasBackground = Color(0xff1A2744);
  static const accent = Color(0xffFC4A71);
  static const recursiveButton = Color(0xff684AFF);
  static const backtrackButton = Color(0xff45D3C2);

  static ThemeData get theme => ThemeData(
        canvasColor: darkNavy,
        hintColor: lightNavy,
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
      );
}

