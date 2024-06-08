import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/view/common/logo_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, '/articles');
    });

    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: const Center(
          child: LogoView(
            size: 42,
          ),
        ),
      ),
    );
  }
}
