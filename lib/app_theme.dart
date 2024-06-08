import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightThemeData() {
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
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'OpenSans',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          shadowColor: Colors.black26,
          elevation: 4,
          foregroundColor: Colors.white),
    );
  }
}
