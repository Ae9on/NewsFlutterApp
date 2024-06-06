import 'package:flutter/material.dart';

class ArticleCover extends StatelessWidget {
  const ArticleCover({
    super.key,
    required this.uri,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
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
