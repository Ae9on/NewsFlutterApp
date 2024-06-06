import 'package:flutter/material.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/view/article_cover.dart';
import 'package:newsapp/view/articles_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ArticleCover(uri: data.urlToImage ?? ''),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 6.0, left: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.source?.name ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                          fontSize: 14)),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(timeago.format(DateTime.parse(data.publishedAt ?? '')),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                          fontSize: 13)),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                data.title ?? '',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
