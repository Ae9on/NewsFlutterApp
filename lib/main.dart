import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/app_theme.dart';
import 'package:newsapp/view/screens/articles_screen.dart';
import 'package:newsapp/view/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (ctx) => const SplashScreen(),
        '/articles': (ctx) => const ArticlesScreen(),
      },
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeData(),
      initialRoute: '/',
    );
  }
}
