import 'package:flutter/material.dart';

class ArticleCover extends StatelessWidget {
  const ArticleCover({super.key, required this.uri, this.ratio = 2.2});

  final String uri;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: ratio,
        child: FadeInImage.assetNetwork(
          image: uri,
          imageErrorBuilder: (ctx, _, e) {
            return Image.asset(
              'assets/placeholder.png',
              fit: BoxFit.cover,
            );
          },
          placeholder: 'assets/placeholder.png',
          fit: BoxFit.cover,
        ));
  }
}
