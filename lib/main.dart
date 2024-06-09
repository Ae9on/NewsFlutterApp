import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/app_theme.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/view/screens/articles_screen.dart';
import 'package:newsapp/view/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getExternalStorageDirectory();
  Hive
    ..init(dir?.path)
    ..registerAdapter(ArticleAdapter())
    ..registerAdapter(SourceAdapter());
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
      theme: AppTheme.mainTheme(),
      initialRoute: '/',
    );
  }
}
