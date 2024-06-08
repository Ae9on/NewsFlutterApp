import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme() {
    return ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          surfaceTintColor: Colors.deepPurple,
          shadowColor: Colors.black26,
          elevation: 16,
        ),
        cardTheme: CardTheme(
          elevation: 24,
          shadowColor: Colors.black45,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ));
  }
}
