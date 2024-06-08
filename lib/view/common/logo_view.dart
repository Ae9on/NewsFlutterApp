import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key, this.size = 26});

  final double size;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Text(
          'Tech',
          style: TextStyle(
              letterSpacing: -2,
              fontWeight: FontWeight.w900,
              fontSize: size,
              color: Colors.white),
        ),
        Text(
          'Feed',
          style: TextStyle(
              letterSpacing: -2,
              fontWeight: FontWeight.w300,
              fontSize: size,
              color: Colors.white),
        ),
      ],
    );
  }
}
